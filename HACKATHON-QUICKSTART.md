# Betterness MCP — Hackathon Quickstart for Builders

> **OpenClaw Hackathon for Longevity — March 2026**
> Everything you need to start building with real health data in under 10 minutes.

---

## What You're Working With

Betterness is the **first health & wellness platform with a native MCP server**. One API key gives your AI agent access to:

- **Real wearable data** — heart rate, HRV, sleep stages, VO2 max, steps, body composition from Garmin, Oura, Apple Health, Peloton, Wahoo, Eight Sleep, Withings
- **Clinical lab ordering** — browse 47+ blood panels, purchase with Stripe checkout, find Quest locations, book appointments
- **Biomarker intelligence** — search results by LOINC code, get biological age calculations, reference ranges
- **Payments built in** — your agent can purchase lab tests and manage payment methods autonomously

**26 tools. 7 device integrations. All through one MCP connection.**

---

## Step 1: Get Your API Key (2 minutes)

1. Go to [betterness.ai/mcp](https://www.betterness.ai/mcp)
2. Sign in (or create account)
3. Click **"Generate API Key"** — copy the `bk_...` key immediately (shown only once)

> **First 50 hackers** get a free $49 Biological Age lab panel.

---

## Step 2: Connect to Your AI Tool (3 minutes)

### Claude Desktop / Claude Code

Add to your MCP config (`~/Library/Application Support/Claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "headers": {
        "Authorization": "Bearer bk_YOUR_API_KEY_HERE"
      }
    }
  }
}
```

### Cursor / Windsurf

Add to `.mcp.json` in your project root:

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "headers": {
        "Authorization": "Bearer bk_YOUR_API_KEY_HERE"
      }
    }
  }
}
```

### ChatGPT (Custom GPT)

Create a Custom GPT with Actions only if your Action layer handles the MCP 3-step handshake (`initialize` → `notifications/initialized` → `tools/call`). For most teams, use a small backend proxy API and have the GPT call that proxy instead.

### Any AI Agent (REST)

See the [MCP Integration Guide](./MCP-INTEGRATION-GUIDE.md) for the full HTTP protocol.

> **Apple Health note:** Apple Health connection is done in the Junction (formerly Vital) app (Junction SDK flow), not via MCP `generateUserLinkToken`. Once connected in-app, the data is available via MCP.

---

## Step 3: Start Talking to Your Agent

Once connected, just ask in natural language:

```
"What wearables can I connect?"
"Show me my sleep data from the last week"
"What lab panels are available under $100?"
"Calculate my biological age"
"Find Quest labs near 10001 and book an appointment"
```

Your AI handles the MCP tool calls automatically.

---

## The 26 Tools — Organized by What You Can Build

### 🏃 Personal Health Agent
| Tool | What it does |
|------|-------------|
| `getActivityData` | Steps, calories, distance, workouts, VO2 max from wearables |
| `getVitals` | Heart rate, HRV, blood oxygen, blood pressure, respiratory rate |
| `getSleepData` | Nightly sleep summaries with stage breakdown |
| `getSleepStages` | Minute-by-minute sleep stage transitions (Deep, Core, REM, Awake) |
| `getBodyComposition` | Weight, body fat %, muscle mass, BMI, visceral fat |
| `getBiologicalAge` | Biological age vs calendar age with contributing biomarkers |

### 🔬 Lab & Biomarker Agent
| Tool | What it does |
|------|-------------|
| `listAvailableLabTests` | Browse ~47 panels with prices, descriptions, included markers |
| `searchBiomarkers` | Search lab results by name, LOINC code, category, date range |
| `getLoincCodes` | Reference list of all standardized biomarker identifiers |
| `getUserLabData` | User's lab orders and results with status and next steps |
| `getLabOrderStatus` | Check status of a specific lab order |

### 💳 Commerce Agent (Buy Labs Autonomously)
| Tool | What it does |
|------|-------------|
| `purchaseLabTestWithCheckout` | Returns Stripe checkout URL to buy a panel |
| `searchLabServiceCenters` | Find Quest Diagnostics locations near a ZIP code |
| `bookLabAppointment` | Schedule a blood draw appointment |
| `getServiceCenterSlots` | Available time slots at a specific Quest location |
| `listSavedPaymentMethods` | List saved payment methods |
| `purchaseLabTest` | Buy a panel directly with a saved payment method |

### ⌚ Device Connection Agent
| Tool | What it does |
|------|-------------|
| `listConnectedDevices` | Show user's active wearable connections |
| `getAvailableIntegrations` | List providers the user can still connect |
| `generateUserLinkToken` | Get OAuth URL to connect a new wearable |
| `disconnectIntegration` | Remove a device connection |

### 👤 User Profile
| Tool | What it does |
|------|-------------|
| `getUserContactData` | Name, email, phone, gender, DOB, address |
| `updateUserContactData` | Update any profile field |

---

## Critical Technical Details (Read This!)

### The MCP Uses Streamable HTTP Transport

If you're building a custom integration (not using Claude/Cursor/ChatGPT), the MCP server requires a **3-step session handshake**:

```
1. POST /mcp → { method: "initialize", params: { protocolVersion: "2025-03-26", ... } }
   ← Save the `Mcp-Session-Id` response header

2. POST /mcp → { method: "notifications/initialized" }
   (include Mcp-Session-Id header)

3. POST /mcp → { method: "tools/call", params: { name: "toolName", arguments: {...} } }
   (include Mcp-Session-Id header)
```

**Without steps 1-2, you'll get a 400 error.** This is the #1 issue developers hit.

### Responses Are SSE Format

The server returns Server-Sent Events, not plain JSON:

```
id:abc123
event:message
data:{"jsonrpc":"2.0","result":{"content":[{"type":"text","text":"..."}]},"id":2}
```

You need to parse the `data:` line. Here's a helper:

```typescript
function parseSSE(text: string): unknown | null {
  for (const line of text.split('\n')) {
    if (line.startsWith('data:')) {
      try { return JSON.parse(line.slice(5)); } catch { continue; }
    }
  }
  try { return JSON.parse(text); } catch { return null; }
}
```

### Required Headers

```
Content-Type: application/json
Accept: application/json, text/event-stream
Authorization: Bearer bk_YOUR_KEY
Mcp-Session-Id: <from step 1 response>
```

### Response Formats Vary by Tool

- **Lab data** (`listAvailableLabTests`, `searchBiomarkers`): JSON inside `result.content[0].text`
- **Device data** (`listConnectedDevices`, `getAvailableIntegrations`): YAML inside `result.content[0].text`
- **`generateUserLinkToken`**: JSON with `linkWebUrl` field (OAuth URL via tryvital.io)

---

## Hackathon Project Ideas

### 1. Longevity Coach (No Code)
Connect Claude Desktop → ask it to analyze your sleep, HRV trends, and suggest a biological age optimization protocol. Use `getSleepData`, `getVitals`, `getBiologicalAge`.

### 2. Autonomous Lab Advisor (No Code)
Ask ChatGPT with Betterness MCP: "Based on my symptoms [X], what blood panel should I order?" → it calls `listAvailableLabTests`, recommends one, generates checkout link with `purchaseLabTestWithCheckout`.

### 3. Wearable Data Dashboard (Beginner)
Build a Next.js app that calls the MCP via BFF pattern. Show activity trends, sleep quality, and heart rate variability over time. See `src/app/api/user/` in betterness-v2 for reference implementations.

### 4. Multi-Agent Health Swarm (Advanced)
Build a swarm where one agent monitors wearable data, another tracks biomarkers, and a coordinator agent synthesizes insights and alerts. Use `getVitals` + `searchBiomarkers` + `getBiologicalAge` together.

### 5. Biomarker Correlation Engine (Advanced)
Pull all historical lab results via `searchBiomarkers`, correlate with wearable data from the same time periods, and identify patterns (e.g., "Your HRV drops 3 days before your CRP spikes").

---

## BFF Pattern (For Web Apps)

If you're building a web app, proxy MCP calls through your backend:

```typescript
// /api/health/sleep — Next.js API route example
import { auth0 } from '@/lib/auth0';

const BACKEND = 'https://api.betterness.ai';

export async function GET(request) {
  const session = await auth0.getSession(request);
  const token = session?.tokenSet?.accessToken;
  if (!token) return Response.json({ error: 'Unauthorized' }, { status: 401 });

  const headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json, text/event-stream',
    Authorization: `Bearer ${token}`,
  };

  // Step 1: Initialize
  const init = await fetch(`${BACKEND}/mcp`, {
    method: 'POST', headers,
    body: JSON.stringify({
      jsonrpc: '2.0', method: 'initialize',
      params: { protocolVersion: '2025-03-26', capabilities: {},
        clientInfo: { name: 'my-app', version: '1.0.0' } },
      id: 1
    })
  });
  const sid = init.headers.get('mcp-session-id');
  if (sid) headers['Mcp-Session-Id'] = sid;

  // Step 2: Notify
  await fetch(`${BACKEND}/mcp`, {
    method: 'POST', headers,
    body: JSON.stringify({ jsonrpc: '2.0', method: 'notifications/initialized' })
  });

  // Step 3: Call tool
  const res = await fetch(`${BACKEND}/mcp`, {
    method: 'POST', headers,
    body: JSON.stringify({
      jsonrpc: '2.0', method: 'tools/call',
      params: { name: 'getSleepData', arguments: { from: '2026-02-01', to: '2026-03-06' } },
      id: 2
    })
  });

  const raw = await res.text();
  // Parse SSE format
  const data = raw.split('\n').find(l => l.startsWith('data:'));
  const parsed = data ? JSON.parse(data.slice(5)) : null;
  return Response.json(parsed?.result?.content?.[0]?.text || {});
}
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| **400 error on POST /mcp** | You skipped the 3-step handshake. Send `initialize` → `notifications/initialized` → then your tool call |
| **Empty response / parse error** | Response is SSE format. Extract the `data:` line, then JSON.parse it |
| **"Tool not found"** | Check exact tool name spelling. Use `tools/list` to see all available tools |
| **Device connect shows no URL** | `generateUserLinkToken` returns JSON with `linkWebUrl` — check you're parsing SSE correctly |
| **Lab markers have duplicates** | The `markers` array in `listAvailableLabTests` may contain duplicate names — deduplicate in your UI |
| **YAML responses** | Device tools return YAML, not JSON. Parse accordingly or use an AI that handles it natively |
| **Auth errors** | Ensure `Authorization: Bearer bk_...` header is on every request including initialize |

---

## Links

- **MCP Page & API Keys**: [betterness.ai/mcp](https://www.betterness.ai/mcp)
- **Lab Panels**: [betterness.ai/dashboard/labs](https://www.betterness.ai/dashboard/labs)
- **Skills Library**: [betterness.ai/skills](https://www.betterness.ai/skills)
- **Devices**: [betterness.ai/dashboard/devices](https://www.betterness.ai/dashboard/devices)
- **Integration Guide**: [MCP-INTEGRATION-GUIDE.md](./MCP-INTEGRATION-GUIDE.md)
- **Register Clawbot**: [augmentedgames.ai/operate](https://augmentedgames.ai/operate)

---

## Security

- HIPAA compliant infrastructure
- TLS 1.3 + AES-256 encryption
- Auth0 OAuth 2.0 authentication
- API keys are revocable at any time from [betterness.ai/mcp](https://www.betterness.ai/mcp)
- Your health data is never shared or sold

---

*Built with care by Betterness — the coordinating intelligence layer for global wellness.*
*Questions? Find us at the hackathon or reach out at betterness.ai.*
