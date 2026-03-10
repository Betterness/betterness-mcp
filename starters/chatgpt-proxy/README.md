# ChatGPT Action Proxy Starter Kit

Connect Betterness MCP to ChatGPT via a proxy layer that translates OpenAI actions to MCP tool invocations.

## Important Note

**This is NOT the simplest integration path.** If you are building a Claude-native application, [use Claude directly](/mcp/claude) — Claude natively supports MCP without a proxy layer. This starter kit is only necessary if ChatGPT is your required interface.

## Who This Is For

- Advanced builders who must use ChatGPT as the user-facing surface
- Integrators distributing health workflows through ChatGPT Custom GPTs
- Teams managing multi-LLM deployments where Betterness is the unified health backend
- Architects who need ChatGPT agents to orchestrate Betterness health services

## Problem Statement

ChatGPT does not natively support MCP. Betterness exposes health intelligence, content orchestration, and wellness workflows exclusively via MCP. This creates a gap:

- Your users expect a ChatGPT interface
- Your health backend (Betterness MCP) is only accessible via MCP protocol
- You need a translation layer that bridges both

This starter kit provides a proxy server that:
1. Listens for ChatGPT OpenAI Action API calls
2. Translates OpenAI action schema to Betterness MCP tool invocations
3. Returns results back to ChatGPT in OpenAI action format
4. Handles bearer token authentication and session management

## Architecture

```
ChatGPT Custom GPT
        ↓
   (OpenAI Action)
        ↓
  Your Proxy Server
        ↓
   (MCP Protocol)
        ↓
Betterness MCP Endpoint
(https://api.betterness.ai/mcp)
```

Your proxy server acts as a protocol translator. ChatGPT sends structured OpenAI action calls; your proxy translates them to MCP `CallTool` invocations, streams the response, and reformats the result for ChatGPT.

## Setup

### Option A: Auto-Generate Your Proxy (Recommended)

Use Claude Code to generate a production-ready proxy:

1. Open [Claude Code](https://claude.com/claude-code)
2. Run this prompt:

```
You are a senior backend engineer building a ChatGPT Action Proxy for Betterness MCP.

Task: Generate a complete proxy server (Express.js or FastAPI, your choice) that:
1. Listens on POST /api/gpt-action for OpenAI action calls
2. Authenticates requests via X-API-Key header (bearer token from betterness.ai/mcp/keys)
3. Translates OpenAI action schema to Betterness MCP CallTool messages
4. Calls https://api.betterness.ai/mcp (Streamable HTTP/JSON-RPC transport)
5. Parses streaming MCP responses and formats them as OpenAI action results
6. Handles errors, timeouts, and partial responses gracefully

Output:
- Complete server code with comments
- package.json or requirements.txt
- .env.example with required variables
- Example deployment config (Docker + environment)

The proxy should be production-ready, handle 500+ concurrent requests, and include structured logging.
```

3. Follow Claude's output to deploy your proxy

### Option B: Manual Setup

Use this Express.js skeleton as a starting point:

```javascript
// proxy-server.js
const express = require('express');
const axios = require('axios');
const app = express();

app.use(express.json());

// MCP endpoint and auth
const MCP_ENDPOINT = 'https://api.betterness.ai/mcp';
let mcpSession = null;

// Initialize MCP session (run once on startup)
async function initMcpSession(bearerToken) {
  try {
    const response = await axios.post(
      `${MCP_ENDPOINT}/initialize`,
      { protocolVersion: '2024-11-05' },
      {
        headers: {
          'Authorization': `Bearer ${bearerToken}`,
          'Content-Type': 'application/json'
        }
      }
    );
    mcpSession = response.data.session;
    console.log('MCP session initialized:', mcpSession);
    return mcpSession;
  } catch (error) {
    console.error('Failed to initialize MCP session:', error.message);
    throw error;
  }
}

// Main GPT action handler
app.post('/api/gpt-action', async (req, res) => {
  const { toolName, arguments: toolArgs } = req.body;
  const bearerToken = req.headers['x-api-key'];

  if (!bearerToken) {
    return res.status(401).json({ error: 'Missing X-API-Key header' });
  }

  if (!toolName) {
    return res.status(400).json({ error: 'Missing toolName in request body' });
  }

  try {
    // Initialize session if needed
    if (!mcpSession) {
      await initMcpSession(bearerToken);
    }

    // Translate OpenAI action to MCP CallTool
    const mpcPayload = {
      jsonrpc: '2.0',
      id: Date.now(),
      method: 'tools/call',
      params: {
        name: toolName,
        arguments: toolArgs || {}
      }
    };

    // Call Betterness MCP
    const response = await axios.post(
      `${MCP_ENDPOINT}/message`,
      mpcPayload,
      {
        headers: {
          'Authorization': `Bearer ${bearerToken}`,
          'Content-Type': 'application/json'
        },
        timeout: 30000
      }
    );

    // Format result for ChatGPT
    const result = {
      success: true,
      toolName: toolName,
      result: response.data.result || response.data,
      timestamp: new Date().toISOString()
    };

    res.json(result);
  } catch (error) {
    console.error(`Tool call failed (${toolName}):`, error.message);
    res.status(500).json({
      success: false,
      error: error.message,
      toolName: toolName
    });
  }
});

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`ChatGPT Action Proxy listening on port ${PORT}`);
});
```

**Environment setup:**

```bash
# .env.example
MCP_ENDPOINT=https://api.betterness.ai/mcp
BEARER_TOKEN=betterness_key_xxxxxxx
PORT=3000
LOG_LEVEL=debug
```

**Deployment checklist:**

- [ ] Install dependencies: `npm install express axios`
- [ ] Set environment variables
- [ ] Test locally: `curl -X POST http://localhost:3000/health`
- [ ] Deploy to AWS Lambda, Heroku, Railway, or your platform
- [ ] Whitelist proxy URL in Betterness console (optional, for rate limiting)
- [ ] Record your proxy URL for ChatGPT configuration

## ChatGPT Custom GPT Configuration

### 1. Create Your Custom GPT

1. Go to [ChatGPT Custom GPTs](https://chatgpt.com/gpts/mine)
2. Click "Create a GPT"
3. Give it a name (e.g., "Betterness Health Coach")
4. Go to **Configuration** → **Actions**

### 2. Add Betterness Action Schema

Click "Create new action" and paste this OpenAPI schema:

```json
{
  "openapi": "3.0.0",
  "info": {
    "title": "Betterness Health MCP",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://your-proxy-domain.com"
    }
  ],
  "paths": {
    "/api/gpt-action": {
      "post": {
        "operationId": "callBetternessTool",
        "summary": "Execute a Betterness MCP tool",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "type": "object",
                "properties": {
                  "toolName": {
                    "type": "string",
                    "description": "Name of the Betterness tool to invoke (e.g., get_health_profile, analyze_labs, get_content_recommendations)"
                  },
                  "arguments": {
                    "type": "object",
                    "description": "Tool-specific arguments as JSON object"
                  }
                },
                "required": ["toolName"]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Tool execution successful",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "properties": {
                    "success": {
                      "type": "boolean"
                    },
                    "toolName": {
                      "type": "string"
                    },
                    "result": {
                      "type": "object"
                    },
                    "timestamp": {
                      "type": "string"
                    }
                  }
                }
              }
            }
          },
          "400": {
            "description": "Invalid tool name or arguments"
          },
          "401": {
            "description": "Missing or invalid API key"
          },
          "500": {
            "description": "Tool execution failed"
          }
        }
      }
    }
  }
}
```

### 3. Authentication Setup

In the ChatGPT GPT editor, go to **Configuration** → **Authentication**:

- Select **API Key**
- **Key name**: `x-api-key`
- **Key**: Paste your Betterness bearer token from [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys)

### 4. Example Tools to Expose

Here are 3 example tools to start with. Add their descriptions to your GPT's system prompt:

```
Available Betterness Tools:

1. get_health_profile
   Retrieves a user's health profile including biological age, lab results, and wellness scores
   Arguments: { user_id: string, include_history: boolean }

2. analyze_labs
   Analyzes lab results and returns AI insights with recommendations
   Arguments: { lab_data: object, analysis_type: string ("full" | "quick") }

3. get_content_recommendations
   Fetches AI-generated wellness content tailored to user health data
   Arguments: { user_id: string, content_type: string ("article" | "workout" | "meal_plan"), limit: number }
```

## MCP Handshake & Protocol Details

### Bearer Token

Obtain your bearer token from [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys):

1. Log in to Betterness
2. Go to Settings → Integrations → MCP Keys
3. Click "Generate New Key"
4. Copy the token (format: `betterness_key_...`)
5. Store securely in your proxy's environment variables

### HTTP Transport

Betterness MCP uses Streamable HTTP/JSON-RPC 2.0:

**Request:**
```json
POST https://api.betterness.ai/mcp/message
Authorization: Bearer betterness_key_xxx
Content-Type: application/json

{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "get_health_profile",
    "arguments": { "user_id": "user_123" }
  }
}
```

**Response (Streaming):**
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "{"profile": {...}, "age": 35, ...}"
      }
    ]
  }
}
```

## Smoke Tests

### 1. Test Proxy Health

```bash
curl https://your-proxy-domain.com/health
# Expected: { "status": "ok", "timestamp": "2026-03-09T..." }
```

### 2. Test MCP Connection

```bash
curl -X POST https://your-proxy-domain.com/api/gpt-action \
  -H "X-API-Key: betterness_key_xxx" \
  -H "Content-Type: application/json" \
  -d '{
    "toolName": "get_available_tools",
    "arguments": {}
  }'
```

Expected response:
```json
{
  "success": true,
  "toolName": "get_available_tools",
  "result": {
    "tools": [
      { "name": "get_health_profile", "description": "..." },
      { "name": "analyze_labs", "description": "..." },
      ...
    ]
  },
  "timestamp": "2026-03-09T..."
}
```

### 3. Test in ChatGPT

1. Create a test message in your Custom GPT:
   - "What tools does Betterness MCP provide?"
2. ChatGPT should call your proxy action
3. Check your proxy logs for the call
4. Verify the response appears in ChatGPT

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| `401 Unauthorized` | Missing or invalid bearer token | Verify token at [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys), ensure X-API-Key header is set |
| `404 Not Found` | Proxy URL is incorrect in ChatGPT | Update the `servers[0].url` in your OpenAPI schema with your actual proxy domain |
| `500 Internal Error` | MCP endpoint unreachable | Check proxy logs, verify proxy can reach https://api.betterness.ai/mcp, check firewall/VPN |
| `Timeout` | Tool execution > 30 seconds | Increase timeout in proxy code, split complex operations into smaller tools |
| `ChatGPT shows "Action error"` | Proxy returned malformed JSON | Ensure proxy always returns `{ success, toolName, result, timestamp }` structure |
| `Bearer token expired` | Token rotated or revoked | Generate a new token at [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys) |

### Debug Mode

Enable verbose logging in your proxy:

```javascript
// Add to proxy-server.js
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  console.log('Headers:', req.headers);
  console.log('Body:', req.body);
  next();
});
```

Then check logs:
```bash
tail -f /var/log/proxy.log  # or your logging system
```

## Upgrade Path

### Phase 1 (Now)

- Single custom GPT with 3–5 tools
- Proxy hosted on a single instance
- Manual bearer token management

### Phase 2 (Recommended)

- Multi-tenant proxy: support multiple Betterness accounts
- Token refresh logic (automatic bearer token rotation)
- Rate limiting and quota management
- Logging and analytics (track which tools are used via ChatGPT)

### Phase 3 (Scale)

- OAuth flow for end-user authentication (so ChatGPT users authenticate with Betterness)
- Webhook support (proxy triggers Betterness workflows from ChatGPT)
- Caching layer (cache tool responses for faster ChatGPT interaction)
- Custom prompt templates (GPT system message generator based on Betterness account)

## Current Limitations

1. **ChatGPT Action Latency**: MCP calls add 200–1000ms latency. For real-time health dashboards, use Claude directly.

2. **Tool Limit**: ChatGPT actions support ~20 tools max in the schema. If you need all 26 Betterness MCP tools, use tool categories or build a tool browser action that lists and invokes tools dynamically.

3. **Streaming Responses**: ChatGPT actions do not stream long responses. Large reports or full data exports may be truncated. Use pagination or summaries.

4. **Session Management**: Each ChatGPT conversation is stateless from Betterness's perspective. User context (health profile, preferences) must be passed per request. Use a "load user context" tool at the start of conversation.

5. **Cost**: Proxy hosting + MCP API calls + ChatGPT premium add up. For high-volume use, direct Claude integration is more cost-effective.

6. **No Webhooks**: ChatGPT actions are request/response only. Proactive notifications (e.g., "Your lab results are back") require polling or a separate notification layer.

## Support

- **MCP Documentation**: [betterness.ai/mcp](https://betterness.ai/mcp)
- **Proxy Issues**: Check logs, run smoke tests, verify bearer token
- **ChatGPT Integration**: Consult OpenAI's [Custom GPT Actions Guide](https://platform.openai.com/docs/gpts/custom-actions)
- **Betterness Support**: [help@betterness.ai](mailto:help@betterness.ai)

---

**Last Updated**: March 2026 | MCP Version: 2024-11-05
