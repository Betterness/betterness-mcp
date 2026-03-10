# Connecting Betterness MCP to ChatGPT

ChatGPT does not natively support the Model Context Protocol. This guide covers how to bridge Betterness MCP into ChatGPT using a lightweight proxy that translates MCP tool calls into OpenAI-compatible Custom GPT Actions.

> **Honest note**: This is a workaround, not a first-class integration. If you want the smoothest experience, use Claude Desktop or Claude Code where MCP is natively supported. This guide exists for teams that are committed to the ChatGPT ecosystem.

## Architecture

```
┌──────────────┐       HTTPS        ┌──────────────────┐      MCP/HTTP      ┌─────────────────────┐
│              │  ───────────────>   │                  │  ───────────────>   │                     │
│   ChatGPT    │   OpenAI Actions   │   Proxy Server   │   Streamable HTTP   │  Betterness MCP     │
│  Custom GPT  │  <───────────────  │   (your infra)   │  <───────────────   │  api.betterness.ai  │
│              │    JSON responses   │                  │    JSON-RPC 2.0     │                     │
└──────────────┘                    └──────────────────┘                     └─────────────────────┘
```

The proxy server receives REST calls from ChatGPT, translates them into MCP JSON-RPC tool invocations, and returns the results as standard JSON that ChatGPT can interpret.

## Prerequisites

1. **Betterness account** and **MCP API key** from [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys)
2. A server or cloud function to host the proxy (Vercel, Railway, Fly.io, AWS Lambda, etc.)
3. A ChatGPT Plus or Team subscription (Custom GPTs require a paid plan)

## Option A: Generate the Proxy with Claude Code (Recommended)

The fastest path is to have Claude Code scaffold the proxy for you. Open Claude Code with your Betterness MCP server connected and use this prompt:

```
Generate an Express.js proxy server that:
1. Exposes REST endpoints matching the Betterness MCP tools
2. Translates incoming REST calls to MCP JSON-RPC 2.0 tool invocations
3. Forwards them to https://api.betterness.ai/mcp with Bearer auth
4. Returns the MCP response as clean JSON
5. Includes an OpenAPI 3.1 schema at /openapi.json
6. Includes CORS headers for ChatGPT

Use the Betterness MCP tool list from my connected server.
Include a Dockerfile and deploy instructions for Railway.
```

Claude Code will read the live tool definitions from your Betterness MCP connection and generate a complete, deployable proxy.

## Option B: Manual Express.js Proxy

If you prefer to build manually, here is a skeleton:

```javascript
// server.js
import express from "express";

const app = express();
app.use(express.json());

const MCP_URL = "https://api.betterness.ai/mcp";
const BETTERNESS_API_KEY = process.env.BETTERNESS_API_KEY;

// Generic proxy handler
async function callMcpTool(toolName, params) {
  const response = await fetch(MCP_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${BETTERNESS_API_KEY}`,
    },
    body: JSON.stringify({
      jsonrpc: "2.0",
      id: Date.now(),
      method: "tools/call",
      params: {
        name: toolName,
        arguments: params,
      },
    }),
  });
  const data = await response.json();
  return data.result;
}

// Example endpoints — add one per MCP tool
app.get("/api/sleep", async (req, res) => {
  const result = await callMcpTool("getSleepData", {
    startDate: req.query.startDate,
    endDate: req.query.endDate,
  });
  res.json(result);
});

app.get("/api/vitals", async (req, res) => {
  const result = await callMcpTool("getVitals", {
    startDate: req.query.startDate,
    endDate: req.query.endDate,
  });
  res.json(result);
});

app.get("/api/biological-age", async (req, res) => {
  const result = await callMcpTool("getBiologicalAge", {});
  res.json(result);
});

app.get("/api/lab-data", async (req, res) => {
  const result = await callMcpTool("getUserLabData", {});
  res.json(result);
});

app.get("/api/biomarkers/search", async (req, res) => {
  const result = await callMcpTool("searchBiomarkers", {
    query: req.query.q,
  });
  res.json(result);
});

app.get("/api/devices", async (req, res) => {
  const result = await callMcpTool("listConnectedDevices", {});
  res.json(result);
});

app.get("/api/lab-tests", async (req, res) => {
  const result = await callMcpTool("listAvailableLabTests", {});
  res.json(result);
});

// OpenAPI schema endpoint
app.get("/openapi.json", (req, res) => {
  res.json(openapiSchema);
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => console.log(`Proxy running on port ${PORT}`));
```

Deploy this to any Node.js hosting provider with `BETTERNESS_API_KEY` set as an environment variable.

## OpenAPI Schema for Custom GPT

Once your proxy is deployed, create a Custom GPT in ChatGPT and configure an Action with this OpenAPI schema (adjust the `servers` URL to your proxy):

```yaml
openapi: 3.1.0
info:
  title: Betterness Health API
  version: 1.0.0
  description: Access Betterness health data through MCP proxy
servers:
  - url: https://your-proxy-server.example.com
paths:
  /api/sleep:
    get:
      operationId: getSleepData
      summary: Get sleep data for a date range
      parameters:
        - name: startDate
          in: query
          schema:
            type: string
            format: date
        - name: endDate
          in: query
          schema:
            type: string
            format: date
      responses:
        "200":
          description: Sleep data
          content:
            application/json:
              schema:
                type: object
  /api/vitals:
    get:
      operationId: getVitals
      summary: Get vitals data (HRV, heart rate, SpO2)
      parameters:
        - name: startDate
          in: query
          schema:
            type: string
            format: date
        - name: endDate
          in: query
          schema:
            type: string
            format: date
      responses:
        "200":
          description: Vitals data
          content:
            application/json:
              schema:
                type: object
  /api/biological-age:
    get:
      operationId: getBiologicalAge
      summary: Get biological age calculation
      responses:
        "200":
          description: Biological age data
          content:
            application/json:
              schema:
                type: object
  /api/lab-data:
    get:
      operationId: getUserLabData
      summary: Get user lab results
      responses:
        "200":
          description: Lab data
          content:
            application/json:
              schema:
                type: object
  /api/biomarkers/search:
    get:
      operationId: searchBiomarkers
      summary: Search biomarker database
      parameters:
        - name: q
          in: query
          required: true
          schema:
            type: string
      responses:
        "200":
          description: Biomarker search results
          content:
            application/json:
              schema:
                type: object
  /api/devices:
    get:
      operationId: listConnectedDevices
      summary: List connected health devices
      responses:
        "200":
          description: Device list
          content:
            application/json:
              schema:
                type: object
  /api/lab-tests:
    get:
      operationId: listAvailableLabTests
      summary: List available lab tests for ordering
      responses:
        "200":
          description: Available lab tests
          content:
            application/json:
              schema:
                type: object
```

## Authentication Setup

In the Custom GPT Action configuration:

1. Set **Authentication** to **API Key**
2. Set **Auth Type** to **Custom**
3. Set **Custom Header Name** to `x-api-key`
4. Paste a proxy-level API key you define (this authenticates ChatGPT to your proxy; the proxy uses your Betterness key internally)

Do **not** expose your Betterness API key directly to ChatGPT. The proxy holds the Betterness key server-side.

## Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| ChatGPT says "I couldn't reach the action" | Proxy is down or URL is wrong | Verify your proxy is running and the URL in the OpenAPI schema matches |
| 401 from proxy | Missing or wrong proxy API key | Check the `x-api-key` header in ChatGPT Action auth settings |
| 401 from Betterness | Invalid Betterness API key in proxy env | Regenerate at betterness.ai/mcp/keys and update `BETTERNESS_API_KEY` env var |
| Empty responses | No data for the requested date range | Try a wider date range or confirm data sources are connected in Betterness |
| Timeout errors | Proxy or Betterness MCP slow to respond | Increase timeout in proxy fetch calls; check Betterness status page |
| "Action not available" in ChatGPT | OpenAPI schema validation failed | Validate your schema at editor.swagger.io before importing |
| CORS errors in browser testing | Proxy missing CORS headers | Add `cors` middleware to Express (`app.use(cors())`) |

## Limitations

- **No streaming**: ChatGPT Actions are request-response only. You will not get real-time data streaming.
- **No session state**: Each ChatGPT Action call is independent. Multi-step workflows require the LLM to chain calls.
- **Maintenance burden**: You must keep the proxy updated as Betterness adds new MCP tools.
- **Latency**: The extra proxy hop adds 50-200ms per call compared to native MCP in Claude.
