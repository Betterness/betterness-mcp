# Betterness MCP — Gemini Function Calling Starter

Bridge Google Gemini to Betterness health tools via Gemini's native function calling API. This starter shows how to define Betterness MCP tools as Gemini function declarations, translate Gemini function calls into MCP JSON-RPC requests, and pass responses back into the conversation.

## What This Is

Gemini does not speak MCP natively. This starter provides a thin middleware layer that:

1. Declares Betterness MCP tools as Gemini-compatible function declarations.
2. Intercepts Gemini function call responses.
3. Translates them into MCP `tools/call` JSON-RPC requests against the Betterness Streamable HTTP endpoint.
4. Returns the MCP result to Gemini so it can continue reasoning.

```
┌─────────┐        ┌──────────────────┐        ┌─────────────────────┐
│  Gemini │──FC──▶ │  Your Middleware  │──POST─▶│  Betterness MCP     │
│  Model  │◀─resp──│  (Python/Node)   │◀─JSON──│  api.betterness.ai  │
└─────────┘        └──────────────────┘        └─────────────────────┘
```

**FC** = Gemini function call. Your middleware is the translation bridge.

## Prerequisites

| Requirement | Details |
|---|---|
| Google Cloud project | With Gemini API enabled |
| Gemini API key | From Google AI Studio or Vertex AI |
| Betterness MCP key | From your Betterness dashboard (`Settings > MCP Keys`) |
| Python 3.10+ | With `google-generativeai` SDK installed |

```bash
pip install google-generativeai requests
```

## Step 1 — Define Betterness Tools as Gemini Function Declarations

Gemini function calling requires tool definitions in its own schema format. Map each Betterness MCP tool to a Gemini `FunctionDeclaration`:

```python
import google.generativeai as genai

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
    description="Retrieve sleep data for a given date range.",
    parameters=genai.protos.Schema(
        type=genai.protos.Type.OBJECT,
        properties={
            "startDate": genai.protos.Schema(type=genai.protos.Type.STRING, description="Start date (YYYY-MM-DD)"),
            "endDate": genai.protos.Schema(type=genai.protos.Type.STRING, description="End date (YYYY-MM-DD)"),
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
            "category": genai.protos.Schema(type=genai.protos.Type.STRING, description="Lab category filter (e.g. 'metabolic', 'thyroid', 'all')"),
        },
    ),
)

betterness_tools = genai.protos.Tool(function_declarations=[list_devices, get_sleep_data, get_user_lab_data])
```

## Step 2 — Create Middleware That Translates Function Calls to MCP

When Gemini decides to call a function, intercept it and forward to the Betterness MCP endpoint as a JSON-RPC `tools/call` request:

```python
import requests
import json
import os

BETTERNESS_MCP_URL = "https://api.betterness.ai/mcp"
BETTERNESS_MCP_KEY = os.environ["BETTERNESS_MCP_KEY"]

def call_betterness_mcp(tool_name: str, arguments: dict) -> dict:
    """Translate a Gemini function call into an MCP tools/call JSON-RPC request."""
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
        raise RuntimeError(f"MCP error: {result['error']}")
    return result.get("result", {})
```

## Step 3 — Wire It Into a Gemini Chat

Run a chat loop that handles function calls automatically:

```python
genai.configure(api_key=os.environ["GEMINI_API_KEY"])

model = genai.GenerativeModel(
    model_name="gemini-1.5-pro",
    tools=[betterness_tools],
)

chat = model.start_chat()

def send_message(user_message: str) -> str:
    response = chat.send_message(user_message)

    # Handle function calls in a loop (Gemini may chain multiple calls)
    while response.candidates[0].content.parts[0].function_call.name:
        fc = response.candidates[0].content.parts[0].function_call
        tool_name = fc.name
        arguments = dict(fc.args)

        print(f"  -> Calling Betterness MCP: {tool_name}({arguments})")
        mcp_result = call_betterness_mcp(tool_name, arguments)

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

    return response.text
```

## Smoke Tests

Run these to verify the bridge works end to end:

```bash
# 1. Test MCP connectivity directly
curl -X POST https://api.betterness.ai/mcp \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $BETTERNESS_MCP_KEY" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'

# 2. Run the example script
export GEMINI_API_KEY="your-gemini-key"
export BETTERNESS_MCP_KEY="your-betterness-mcp-key"
python example.py
```

Expected behavior: Gemini asks for your health data, the middleware calls Betterness MCP, and Gemini summarizes the results in natural language.

## Limitations

- **Latency**: Every function call adds a network round-trip (Gemini -> your middleware -> Betterness MCP -> back). Expect 500ms-2s per tool call depending on the tool.
- **Proxy overhead**: Unlike native MCP clients (Claude Desktop, OpenClaw), this is a translation layer. You are responsible for hosting the middleware.
- **No streaming**: Betterness MCP responses are returned as complete JSON. Gemini will stream its final text response, but the tool call itself is synchronous.
- **Rate limits**: Both the Gemini API and Betterness MCP have independent rate limits. Monitor both.
- **Schema drift**: If Betterness adds or changes MCP tools, you must update your Gemini function declarations manually. Check the `/mcp` `tools/list` endpoint periodically.

## Resources

- [Gemini Function Calling docs](https://ai.google.dev/gemini-api/docs/function-calling)
- [Betterness MCP documentation](https://betterness.ai/mcp)
- [MCP Specification](https://modelcontextprotocol.io)
