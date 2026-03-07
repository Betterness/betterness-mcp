# Betterness MCP Server

Build health agents with real wearable data, biomarkers, lab ordering, and payments.

- Endpoint: `https://api.betterness.ai/mcp`
- Transport: MCP Streamable HTTP
- Protocol: `2025-03-26`
- Auth: `Authorization: Bearer <token>`
  - External builders: use `bk_...` API key from [betterness.ai/mcp](https://www.betterness.ai/mcp)
  - First-party app routes: Auth0 access token is also supported

## Start Here (2 Minutes)

1. Get API key at [betterness.ai/mcp](https://www.betterness.ai/mcp)
2. Connect from your client (see matrix below)
3. If using raw REST, complete the 3-step handshake before any `tools/call`

## Client Setup Matrix

| Client | Recommended Setup | Notes |
|---|---|---|
| Claude Desktop | `claude_desktop_config.json` MCP server config | Direct MCP works |
| Claude Code / Cursor / Windsurf | `.mcp.json` / `.cursor/mcp.json` / client MCP settings | Direct MCP works |
| ChatGPT | Actions/connector or backend proxy | Prompt-only connection is not sufficient |
| Gemini | Function-calling + proxy layer | Map MCP tools to function declarations |
| OpenClaw | MCP server settings in platform UI | Add URL + Bearer header |
| Any custom app | REST + handshake | Use initialize -> notifications/initialized -> tools/call |

## Minimal Config Example

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "headers": {
        "Authorization": "Bearer bk_your_api_key_here"
      }
    }
  }
}
```

## REST Handshake (Required)

### Step 1: initialize

```bash
curl -s -D- -X POST https://api.betterness.ai/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer bk_your_api_key_here" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"your-app","version":"1.0.0"}}}'
```

Save `Mcp-Session-Id` from response headers.

### Step 2: notifications/initialized

```bash
curl -s -X POST https://api.betterness.ai/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer bk_your_api_key_here" \
  -H "Mcp-Session-Id: SESSION_ID_FROM_STEP_1" \
  -d '{"jsonrpc":"2.0","method":"notifications/initialized"}'
```

### Step 3: tools/call

```bash
curl -s -X POST https://api.betterness.ai/mcp \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer bk_your_api_key_here" \
  -H "Mcp-Session-Id: SESSION_ID_FROM_STEP_1" \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"listConnectedDevices","arguments":{}}}'
```

## Tool Surface

26 tools across:

- User Profile
- Connected Devices
- Health Data
- Biomarkers & Labs
- Lab Test Ordering
- Purchases & Payments
- Lab Order Management

For full parameters and flow examples, see:

- [Integration Guide](./INTEGRATION-GUIDE.md)
- [Hackathon Quickstart](./HACKATHON-QUICKSTART.md)
- [Skills](./skills/)

## High-Value Agent Playbook

1. `listConnectedDevices` first
2. Pull `getSleepData` + `getVitals` + `getActivityData` (7-30 day window)
3. Check biomarkers via `searchBiomarkers`
4. Find gaps via `listAvailableLabTests`
5. Execute lab lifecycle when needed:
   - `listSavedPaymentMethods` -> `purchaseLabTest` or `purchaseLabTestWithCheckout`
   - `getUserLabData` -> `initializeLabOrder`
   - `searchLabServiceCenters` -> `getServiceCenterSlots` -> `bookLabAppointment`

## Common Pitfalls

- Skipping step 2 handshake -> tools hang/timeout
- Calling tool name directly as `method` -> invalid JSON-RPC usage
- Parsing raw response as JSON -> must parse SSE `data:` payload
- Missing `Mcp-Session-Id` on steps 2/3 -> invalid session errors

## Security

- HIPAA-aligned infrastructure
- TLS 1.3 in transit, AES-256 at rest
- Revocable API keys from dashboard
- User-controlled connections and ordering actions

## Links

- [Get API Key](https://www.betterness.ai/mcp)
- [Lab Panels](https://www.betterness.ai/dashboard/labs)
- [Devices](https://www.betterness.ai/dashboard/devices)
- [Model Context Protocol](https://modelcontextprotocol.io)
