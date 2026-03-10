# Connecting Betterness MCP to Other Clients

Any application that supports the **MCP Streamable HTTP transport** can connect to the Betterness health data API. This guide covers generic configuration, Gemini function calling, and building custom clients.

## Universal Connection Details

| Parameter | Value |
|-----------|-------|
| **Endpoint URL** | `https://api.betterness.ai/mcp` |
| **Transport** | Streamable HTTP (MCP specification) |
| **Authentication** | Bearer token in `Authorization` header |
| **Token** | Your API key from [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys) |
| **Content-Type** | `application/json` |
| **Protocol** | JSON-RPC 2.0 |

### Minimal Request Example

```http
POST https://api.betterness.ai/mcp HTTP/1.1
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/list",
  "params": {}
}
```

### Minimal Tool Call

```http
POST https://api.betterness.ai/mcp HTTP/1.1
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "jsonrpc": "2.0",
  "id": 2,
  "method": "tools/call",
  "params": {
    "name": "getSleepData",
    "arguments": {
      "startDate": "2026-03-01",
      "endDate": "2026-03-09"
    }
  }
}
```

## Gemini Function Calling

Google's Gemini models support function calling, which can be mapped to Betterness MCP tools. See the reference implementation in `starters/gemini-function-calling/` for a complete working example.

### Architecture

```
┌────────────────┐     Function Call      ┌──────────────────┐     MCP/HTTP     ┌─────────────────────┐
│  Gemini Model  │  ──────────────────>   │  Your App Layer  │  ─────────────>  │  Betterness MCP     │
│  (via API)     │  <──────────────────   │  (translation)   │  <─────────────  │  api.betterness.ai  │
└────────────────┘   Function Response    └──────────────────┘   JSON-RPC 2.0   └─────────────────────┘
```

### Setup Steps

1. **Discover tools**: Call `tools/list` on the Betterness MCP endpoint to get the current tool definitions.

2. **Convert to Gemini function declarations**: Map each MCP tool to a Gemini `FunctionDeclaration`:

```python
import google.generativeai as genai

# Example: mapping Betterness MCP tools to Gemini functions
betterness_tools = [
    genai.protos.Tool(
        function_declarations=[
            genai.protos.FunctionDeclaration(
                name="getSleepData",
                description="Get sleep data for a date range",
                parameters=genai.protos.Schema(
                    type=genai.protos.Type.OBJECT,
                    properties={
                        "startDate": genai.protos.Schema(type=genai.protos.Type.STRING),
                        "endDate": genai.protos.Schema(type=genai.protos.Type.STRING),
                    },
                ),
            ),
            genai.protos.FunctionDeclaration(
                name="getVitals",
                description="Get vitals data including HRV, heart rate, SpO2",
                parameters=genai.protos.Schema(
                    type=genai.protos.Type.OBJECT,
                    properties={
                        "startDate": genai.protos.Schema(type=genai.protos.Type.STRING),
                        "endDate": genai.protos.Schema(type=genai.protos.Type.STRING),
                    },
                ),
            ),
            # Add remaining tools...
        ]
    )
]

model = genai.GenerativeModel("gemini-pro", tools=betterness_tools)
```

3. **Handle function calls**: When Gemini returns a function call, forward it to the Betterness MCP endpoint and return the result:

```python
import requests

def handle_betterness_call(function_call):
    response = requests.post(
        "https://api.betterness.ai/mcp",
        headers={
            "Authorization": f"Bearer {BETTERNESS_API_KEY}",
            "Content-Type": "application/json",
        },
        json={
            "jsonrpc": "2.0",
            "id": 1,
            "method": "tools/call",
            "params": {
                "name": function_call.name,
                "arguments": dict(function_call.args),
            },
        },
    )
    return response.json()["result"]
```

4. **Complete the loop**: Feed the MCP result back to Gemini as a function response so it can generate a natural language answer.

See `starters/gemini-function-calling/` for the full implementation with error handling, tool discovery automation, and conversation management.

## Building Custom Clients

### Using an MCP SDK

The fastest way to build a custom client is with an official MCP SDK. SDKs are available for:

- **TypeScript/JavaScript**: `@modelcontextprotocol/sdk`
- **Python**: `mcp` (PyPI)
- **Go**: Community SDKs available

#### TypeScript Example

```typescript
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StreamableHTTPClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";

const transport = new StreamableHTTPClientTransport(
  new URL("https://api.betterness.ai/mcp"),
  {
    requestInit: {
      headers: {
        Authorization: `Bearer ${process.env.BETTERNESS_API_KEY}`,
      },
    },
  }
);

const client = new Client({ name: "my-health-app", version: "1.0.0" });
await client.connect(transport);

// List available tools
const tools = await client.listTools();
console.log("Available tools:", tools.tools.map((t) => t.name));

// Call a tool
const sleepData = await client.callTool({
  name: "getSleepData",
  arguments: { startDate: "2026-03-01", endDate: "2026-03-09" },
});
console.log("Sleep data:", sleepData);

// Clean up
await client.close();
```

#### Python Example

```python
from mcp import ClientSession
from mcp.client.streamable_http import streamablehttp_client

async def main():
    async with streamablehttp_client(
        "https://api.betterness.ai/mcp",
        headers={"Authorization": f"Bearer {api_key}"},
    ) as (read, write, _):
        async with ClientSession(read, write) as session:
            await session.initialize()

            # List tools
            tools = await session.list_tools()
            for tool in tools.tools:
                print(f"  {tool.name}: {tool.description}")

            # Call a tool
            result = await session.call_tool(
                "getSleepData",
                arguments={"startDate": "2026-03-01", "endDate": "2026-03-09"},
            )
            print(result)
```

### Raw HTTP (No SDK)

If you prefer not to use an SDK, the Betterness MCP server accepts standard JSON-RPC 2.0 over HTTPS POST requests. The full protocol flow:

1. **Initialize**: Send `initialize` method to establish a session.
2. **List tools**: Send `tools/list` to discover available health tools and their schemas.
3. **Call tools**: Send `tools/call` with tool name and arguments.
4. **Handle responses**: Parse the JSON-RPC `result` field.

### Endpoint Details

| Detail | Value |
|--------|-------|
| Base URL | `https://api.betterness.ai/mcp` |
| Method | `POST` |
| Protocol | JSON-RPC 2.0 over HTTP |
| Auth header | `Authorization: Bearer <key>` |
| Request content type | `application/json` |
| Response content type | `application/json` |
| Rate limit | See [troubleshooting](../troubleshooting/common-issues.md) |
| TLS | Required (TLS 1.2+) |

## Supported Clients (Community Reports)

The following clients have been reported to work with Betterness MCP by the community. Betterness does not officially support or test these integrations:

- **Cursor** — Works via MCP server configuration in settings
- **Windsurf** — Works via MCP config
- **Continue.dev** — Works via MCP config in VS Code / JetBrains
- **Zed** — Works via MCP settings panel
- **LibreChat** — Works with MCP plugin

If you successfully connect a client not listed here, open a PR to add it.
