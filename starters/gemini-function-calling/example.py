"""
Betterness MCP — Gemini Function Calling Bridge Example

Demonstrates how to wire Betterness health tools into Google Gemini
using Gemini's native function calling API.

Usage:
    export GEMINI_API_KEY="your-gemini-key"
    export BETTERNESS_MCP_KEY="your-betterness-mcp-key"
    python example.py

Requirements:
    pip install google-generativeai requests
"""

import os
import json
import requests
import google.generativeai as genai

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

BETTERNESS_MCP_URL = "https://api.betterness.ai/mcp"
BETTERNESS_MCP_KEY = os.environ.get("BETTERNESS_MCP_KEY", "")
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY", "")

if not BETTERNESS_MCP_KEY:
    raise SystemExit("Set BETTERNESS_MCP_KEY environment variable")
if not GEMINI_API_KEY:
    raise SystemExit("Set GEMINI_API_KEY environment variable")

genai.configure(api_key=GEMINI_API_KEY)

# ---------------------------------------------------------------------------
# Step 1: Define Betterness MCP tools as Gemini function declarations
# ---------------------------------------------------------------------------

list_devices = genai.protos.FunctionDeclaration(
    name="listConnectedDevices",
    description="List all wearable devices connected to the user's Betterness profile.",
    parameters=genai.protos.Schema(
        type=genai.protos.Type.OBJECT,
        properties={},
    ),
)

get_sleep_data = genai.protos.FunctionDeclaration(
    name="getSleepData",
    description="Retrieve sleep data for a given date range including duration, stages, and quality score.",
    parameters=genai.protos.Schema(
        type=genai.protos.Type.OBJECT,
        properties={
            "startDate": genai.protos.Schema(
                type=genai.protos.Type.STRING,
                description="Start date in YYYY-MM-DD format",
            ),
            "endDate": genai.protos.Schema(
                type=genai.protos.Type.STRING,
                description="End date in YYYY-MM-DD format",
            ),
        },
        required=["startDate", "endDate"],
    ),
)

get_user_lab_data = genai.protos.FunctionDeclaration(
    name="getUserLabData",
    description="Retrieve the user's most recent lab results and biomarkers.",
    parameters=genai.protos.Schema(
        type=genai.protos.Type.OBJECT,
        properties={
            "category": genai.protos.Schema(
                type=genai.protos.Type.STRING,
                description="Lab category filter: 'metabolic', 'thyroid', 'hormones', 'cbc', 'lipids', or 'all'",
            ),
        },
    ),
)

betterness_tools = genai.protos.Tool(
    function_declarations=[list_devices, get_sleep_data, get_user_lab_data]
)

# ---------------------------------------------------------------------------
# Step 2: MCP bridge — translate Gemini function calls to MCP JSON-RPC
# ---------------------------------------------------------------------------


def call_betterness_mcp(tool_name: str, arguments: dict) -> dict:
    """Send an MCP tools/call JSON-RPC request to the Betterness endpoint."""
    payload = {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "tools/call",
        "params": {
            "name": tool_name,
            "arguments": arguments,
        },
    }
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {BETTERNESS_MCP_KEY}",
    }
    resp = requests.post(BETTERNESS_MCP_URL, json=payload, headers=headers, timeout=30)
    resp.raise_for_status()

    result = resp.json()
    if "error" in result:
        raise RuntimeError(f"MCP error: {json.dumps(result['error'])}")

    return result.get("result", {})


# ---------------------------------------------------------------------------
# Step 3: Chat loop with automatic function call handling
# ---------------------------------------------------------------------------


def handle_function_calls(chat, response):
    """Process any function calls Gemini returns, forwarding them to MCP."""
    while True:
        part = response.candidates[0].content.parts[0]

        # Check if this part contains a function call
        fc = part.function_call
        if not fc or not fc.name:
            break

        tool_name = fc.name
        arguments = dict(fc.args) if fc.args else {}

        print(f"  [MCP] Calling {tool_name}({json.dumps(arguments)})")
        mcp_result = call_betterness_mcp(tool_name, arguments)
        print(f"  [MCP] Got result: {json.dumps(mcp_result)[:200]}...")

        # Send the function response back to Gemini
        response = chat.send_message(
            genai.protos.Content(
                parts=[
                    genai.protos.Part(
                        function_response=genai.protos.FunctionResponse(
                            name=tool_name,
                            response={"result": mcp_result},
                        )
                    )
                ]
            )
        )

    return response


def main():
    model = genai.GenerativeModel(
        model_name="gemini-1.5-pro",
        tools=[betterness_tools],
        system_instruction=(
            "You are a health assistant powered by Betterness. "
            "Use the available tools to fetch the user's real health data "
            "before answering questions. Be concise and actionable."
        ),
    )

    chat = model.start_chat()

    print("Betterness + Gemini Function Calling Bridge")
    print("Type a health question. Press Ctrl+C to exit.\n")

    sample_prompts = [
        "What devices do I have connected?",
        "How did I sleep this past week?",
        "Show me my latest lab results.",
    ]
    print("Sample prompts to try:")
    for i, p in enumerate(sample_prompts, 1):
        print(f"  {i}. {p}")
    print()

    while True:
        try:
            user_input = input("You: ").strip()
            if not user_input:
                continue

            response = chat.send_message(user_input)
            response = handle_function_calls(chat, response)

            print(f"\nGemini: {response.text}\n")

        except KeyboardInterrupt:
            print("\nGoodbye!")
            break
        except Exception as exc:
            print(f"\nError: {exc}\n")


if __name__ == "__main__":
    main()
