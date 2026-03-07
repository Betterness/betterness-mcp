# Betterness MCP Integration Guide

Everything you need to build with the Betterness health data MCP server. Written for developers at a hackathon who want health data in their app in 30 minutes.

**Server endpoint:** `https://api.betterness.ai/mcp`
**Protocol:** MCP Streamable HTTP (not SSE transport, not stdio)
**Auth:** Auth0 JWT Bearer token
**Tools available:** 26

---

## Table of Contents

1. [The 3-Step Session Handshake](#1-the-3-step-session-handshake)
2. [SSE Response Parsing](#2-sse-response-parsing)
3. [Authentication](#3-authentication)
4. [Complete Tool Reference (26 tools)](#4-complete-tool-reference-26-tools)
5. [Response Format Gotchas](#5-response-format-gotchas)
6. [BFF Pattern (Next.js API Routes)](#6-bff-pattern-nextjs-api-routes)
7. [Quick Start for Non-Developers](#7-quick-start-for-non-developers)
8. [Testing with curl](#8-testing-with-curl)
9. [Common Pitfalls](#9-common-pitfalls)

---

## 1. The 3-Step Session Handshake

The Betterness MCP server uses **Streamable HTTP transport**. This is NOT Server-Sent Events transport. Every interaction requires a 3-step handshake. Skip steps 1-2 and you get a 400 error.

### Step 1: Initialize the session

```bash
POST https://api.betterness.ai/mcp
Content-Type: application/json
Accept: application/json, text/event-stream
Authorization: Bearer <your_auth0_jwt>

{
  "jsonrpc": "2.0",
  "method": "initialize",
  "params": {
    "protocolVersion": "2025-03-26",
    "capabilities": {},
    "clientInfo": { "name": "your-app", "version": "1.0.0" }
  },
  "id": 1
}
```

The response includes an `Mcp-Session-Id` header. **Save it.** You need it for every subsequent request in this session.

### Step 2: Send the initialized notification

```bash
POST https://api.betterness.ai/mcp
Content-Type: application/json
Accept: application/json, text/event-stream
Authorization: Bearer <your_auth0_jwt>
Mcp-Session-Id: <session_id_from_step_1>

{
  "jsonrpc": "2.0",
  "method": "notifications/initialized"
}
```

This is a notification (no `id` field). No meaningful response body.

### Step 3: Call a tool

```bash
POST https://api.betterness.ai/mcp
Content-Type: application/json
Accept: application/json, text/event-stream
Authorization: Bearer <your_auth0_jwt>
Mcp-Session-Id: <session_id_from_step_1>

{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
    "name": "listConnectedDevices",
    "arguments": {}
  },
  "id": 2
}
```

You can make multiple `tools/call` requests on the same session. Just keep incrementing `id` and reusing the same `Mcp-Session-Id`.

---

## 2. SSE Response Parsing

Here is what actually trips people up: the response body is **not plain JSON**. It comes wrapped in Server-Sent Events format:

```
id:abc123
event:message
data:{"jsonrpc":"2.0","result":{"content":[{"type":"text","text":"..."}]},"id":2}
```

If you try `JSON.parse(responseBody)` directly, you get a parse error. You need to extract the `data:` line first.

### The helper function you need

```typescript
function parseSSE(text: string): unknown | null {
  const lines = text.split('\n');
  for (const line of lines) {
    if (line.startsWith('data:')) {
      try {
        return JSON.parse(line.slice(5));
      } catch {
        // continue to next data line
      }
    }
  }
  // Fallback: maybe the server returned plain JSON (no SSE wrapper)
  try {
    return JSON.parse(text);
  } catch {
    return null;
  }
}
```

### Extracting the actual tool result

After parsing SSE, the JSON-RPC response has this shape:

```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "content": [
      {
        "type": "text",
        "text": "... the actual data is in here ..."
      }
    ]
  }
}
```

The value at `result.content[0].text` is a **string**. That string may contain JSON, YAML, or plain text depending on the tool. See [Response Format Gotchas](#5-response-format-gotchas) for details.

---

## 3. Authentication

All requests require an `Authorization: Bearer <jwt>` header. The JWT comes from Auth0.

### Getting the token in Next.js (server-side)

```typescript
import { auth0 } from '@/lib/auth0';

async function getToken(request: NextRequest): Promise<string | null> {
  try {
    const session = await auth0.getSession(request);
    return session?.tokenSet?.accessToken || null;
  } catch {
    return null;
  }
}
```

### Getting the token in a client app

If you are building outside the Betterness Next.js app, you need an Auth0 access token for the Betterness API audience. Contact the Betterness team for Auth0 client credentials and audience configuration.

---

## 4. Complete Tool Reference (26 tools)

### User Profile (2 tools)

| Tool | Description | Parameters | Returns |
|------|-------------|------------|---------|
| `getUserContactData` | User's profile: name, email, phone, gender, DOB, address. Call before purchasing a lab test -- purchases require gender, phone, birthdate, and full address. | none | YAML |
| `updateUserContactData` | Update profile fields. All params optional -- only provided fields change. Confirm with user before calling. | `firstName?`, `lastName?`, `phone?`, `phoneDialCode?`, `gender?`, `birthDate?`, `addressFullAddress?`, `addressCity?`, `addressState?`, `addressZipCode?`, `addressCountry?` | JSON |

### Connected Devices (4 tools)

| Tool | Description | Parameters | Returns |
|------|-------------|------------|---------|
| `listConnectedDevices` | User's active wearable connections (Apple Health, Garmin, Oura, Withings, Eight Sleep, Peloton). Call before querying health data. | none | YAML |
| `getAvailableIntegrations` | Integrations the user can still connect (not yet connected or previously disconnected). | none | YAML |
| `generateUserLinkToken` | Generates a connection link for a wearable. User opens the returned `linkWebUrl` in their browser to authorize via Vital/tryvital.io. | `integrationKey`, `redirectUrl` | JSON |
| `disconnectIntegration` | Removes a device connection. | `integrationKey` | Text |

### Health Data (5 tools)

| Tool | Description | Parameters | Returns |
|------|-------------|------------|---------|
| `getActivityData` | Steps, calories, distance, VO2 max, floors, workouts (running, cycling, yoga, etc.) from connected wearables. | `from`, `to`, `activityTypes?`, `zoneId?` | YAML |
| `getVitals` | Heart rate, HRV, blood pressure, SpO2, glucose, respiratory rate. | `from`, `to`, `zoneId?` | YAML |
| `getSleepData` | Nightly sleep summaries: time in bed, total asleep, stage breakdown (deep, light/core, REM, awake). | `from`, `to`, `zoneId?` | YAML |
| `getSleepStages` | Minute-by-minute sleep stage transitions: stage name, start/end time, duration, grouped by night. | `from`, `to`, `zoneId?` | YAML |
| `getBodyComposition` | Weight, body fat %, body water %, muscle mass %, bone mass %, visceral fat, BMI, lean mass, waist circumference. | `from`, `to`, `zoneId?` | YAML |

### Biomarkers & Labs (3 tools)

| Tool | Description | Parameters | Returns |
|------|-------------|------------|---------|
| `searchBiomarkers` | Search/filter user's biomarker lab results with reference ranges and categories. All params optional -- combine for targeted queries. | `biomarkerExternalId?`, `biomarkerLoincCode?`, `searchParam?`, `name?`, `startDate?`, `endDate?`, `categories?`, `range?` | JSON |
| `getLoincCodes` | All available LOINC codes -- standardized biomarker identifiers with names and descriptions. Reference list for use with `searchBiomarkers`. | none | JSON |
| `getBiologicalAge` | User's biological age history: biological age vs calendar age over time, with contributing biomarker values. | none | JSON |

### Lab Test Ordering (3 tools)

| Tool | Description | Parameters | Returns |
|------|-------------|------------|---------|
| `listAvailableLabTests` | Lab tests available for ordering. Returns `objectKey` (needed for purchasing), name, description, lab, price, `isPopular`, `imageUrl`, and included biomarkers. | `query?`, `isPopular?` | JSON |
| `getUserLabData` | User's lab data (Betterness orders + uploaded results). Each item has `status`, `statusDescription`, and `nextStep` fields. | `externalId?`, `startDate?`, `endDate?` | JSON |
| `getLabOrderStatus` | Lab order statuses only. **Deprecated** -- use `getUserLabData` instead. | `orderId?` | JSON |

### Purchases & Payments (3 tools)

| Tool | Description | Parameters | Returns |
|------|-------------|------------|---------|
| `listSavedPaymentMethods` | Saved cards: brand, last 4, expiration, default status, `externalId` for `purchaseLabTest`. | none | JSON |
| `purchaseLabTest` | Purchase using a saved payment method. Verify profile fields and confirm with user first. Charged immediately. | `labTestObjectKey`, `paymentMethodExternalId`, `promotionCode?` | JSON |
| `purchaseLabTestWithCheckout` | Generates a Stripe Checkout URL for users without saved cards. Share the full `checkoutUrl` -- never truncate. Order created after payment via webhook. | `labTestObjectKey`, `successUrl`, `cancelUrl`, `promotionCode?` | JSON |

### Lab Order Management (6 tools)

| Tool | Description | Parameters | Returns |
|------|-------------|------------|---------|
| `initializeLabOrder` | Submits a "Paid" order to the lab. Requires complete profile (gender, phone, birthdate, full address). | `labOrderExternalId` | JSON |
| `searchLabServiceCenters` | Blood draw locations near a ZIP code. Use after order reaches "Requisition Created". Returns `siteCode`, name, address, distance. | `zipCode`, `labOrderExternalId` | JSON |
| `getServiceCenterSlots` | Available appointment slots at a service center. Returns `bookingKey`, start, end. | `siteCode`, `labOrderExternalId`, `timezone`, `startDate?`, `rangeDays?` | JSON |
| `bookLabAppointment` | Book a blood draw appointment. For "Requisition Created" or "Appointment Cancelled" orders. Do NOT use to reschedule. | `labOrderExternalId`, `bookingKey`, `timezone` | JSON |
| `rescheduleLabAppointment` | Reschedule an existing appointment. Only for "Appointment Scheduled" status. Previous appointment cancelled automatically. | `labOrderExternalId`, `bookingKey`, `timezone` | JSON |
| `cancelLabAppointment` | Cancel a blood draw appointment. Call without `reasonId` first to get cancellation reasons, then call again with chosen `reasonId`. | `labOrderExternalId`, `reasonId?` | JSON |

---

## 5. Response Format Gotchas

The data inside `result.content[0].text` varies by tool. Here is what to expect:

| Format | Tools | How to handle |
|--------|-------|---------------|
| **JSON string** | `listAvailableLabTests`, `searchBiomarkers`, `getBiologicalAge`, `getUserLabData`, `purchaseLabTestWithCheckout`, `listSavedPaymentMethods`, all lab order management tools | `JSON.parse(textContent)` |
| **YAML string** | `listConnectedDevices`, `getAvailableIntegrations`, `getActivityData`, `getVitals`, `getSleepData`, `getSleepStages`, `getBodyComposition`, `getUserContactData` | Parse YAML or use a simple line parser (see below) |
| **JSON with `linkWebUrl`** | `generateUserLinkToken` | `JSON.parse(textContent)` then access `.linkWebUrl` |
| **Plain text** | `disconnectIntegration` | Use as-is |

### Simple YAML list parser

For device and health data responses that come back as YAML, this minimal parser handles the common format:

```typescript
function parseYamlList(yaml: string): Record<string, string>[] {
  const items: Record<string, string>[] = [];
  let current: Record<string, string> | null = null;

  for (const line of yaml.split('\n')) {
    const trimmed = line.trim();
    if (trimmed.startsWith('- ')) {
      if (current) items.push(current);
      current = {};
      const kv = trimmed.slice(2);
      const colonIdx = kv.indexOf(':');
      if (colonIdx > 0) {
        current[kv.slice(0, colonIdx).trim()] = kv.slice(colonIdx + 1).trim();
      }
    } else if (current && trimmed.includes(':')) {
      const colonIdx = trimmed.indexOf(':');
      current[trimmed.slice(0, colonIdx).trim()] = trimmed.slice(colonIdx + 1).trim();
    }
  }
  if (current) items.push(current);
  return items;
}
```

### Lab test `markers` field has duplicates

When you get results from `listAvailableLabTests`, the `markers` array for each test may contain duplicate biomarker entries. Deduplicate before displaying:

```typescript
const uniqueMarkers = [...new Map(markers.map(m => [m.id || m.name, m])).values()];
```

---

## 6. BFF Pattern (Next.js API Routes)

The recommended architecture: your Next.js API routes act as a Backend-For-Frontend (BFF) that handles the MCP handshake, so your React components just call simple REST endpoints.

### Reusable MCP client

```typescript
// src/lib/mcp-client.ts
import { auth0 } from '@/lib/auth0';
import { NextRequest } from 'next/server';

const BACKEND_URL = process.env.BETTERNESS_BASE_URL || 'https://api.betterness.ai';

function parseSSE(text: string): unknown | null {
  const lines = text.split('\n');
  for (const line of lines) {
    if (line.startsWith('data:')) {
      try { return JSON.parse(line.slice(5)); } catch { /* continue */ }
    }
  }
  try { return JSON.parse(text); } catch { return null; }
}

export async function getToken(request: NextRequest): Promise<string | null> {
  try {
    const session = await auth0.getSession(request);
    return session?.tokenSet?.accessToken || null;
  } catch {
    return null;
  }
}

export async function callMcpTool(
  token: string,
  toolName: string,
  args: Record<string, unknown> = {}
): Promise<string | null> {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    'Accept': 'application/json, text/event-stream',
    Authorization: `Bearer ${token}`,
  };

  // Step 1: Initialize
  const initRes = await fetch(`${BACKEND_URL}/mcp`, {
    method: 'POST',
    headers,
    body: JSON.stringify({
      jsonrpc: '2.0',
      method: 'initialize',
      params: {
        protocolVersion: '2025-03-26',
        capabilities: {},
        clientInfo: { name: 'betterness-web', version: '1.0.0' },
      },
      id: 1,
    }),
    cache: 'no-store',
  });
  if (!initRes.ok) return null;

  const sessionId = initRes.headers.get('mcp-session-id');
  if (sessionId) headers['Mcp-Session-Id'] = sessionId;

  // Step 2: Notify initialized
  await fetch(`${BACKEND_URL}/mcp`, {
    method: 'POST',
    headers,
    body: JSON.stringify({ jsonrpc: '2.0', method: 'notifications/initialized' }),
    cache: 'no-store',
  });

  // Step 3: Call tool
  const toolRes = await fetch(`${BACKEND_URL}/mcp`, {
    method: 'POST',
    headers,
    body: JSON.stringify({
      jsonrpc: '2.0',
      method: 'tools/call',
      params: { name: toolName, arguments: args },
      id: 2,
    }),
    cache: 'no-store',
  });
  if (!toolRes.ok) return null;

  const rawText = await toolRes.text();
  const parsed = parseSSE(rawText) as {
    result?: { content?: { text: string }[] };
  } | null;

  return parsed?.result?.content?.[0]?.text || null;
}
```

### Example: `/api/user/labs` route

```typescript
// src/app/api/user/labs/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { getToken, callMcpTool } from '@/lib/mcp-client';

export async function GET(request: NextRequest) {
  const token = await getToken(request);
  if (!token) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  const query = request.nextUrl.searchParams.get('query') || '';
  const args: Record<string, unknown> = {};
  if (query) args.query = query;

  const rawText = await callMcpTool(token, 'listAvailableLabTests', args);
  if (!rawText) return NextResponse.json([]);

  try {
    const tests = JSON.parse(rawText);
    return NextResponse.json(Array.isArray(tests) ? tests : []);
  } catch {
    return NextResponse.json([]);
  }
}
```

### Example: `/api/user/devices` route

```typescript
// src/app/api/user/devices/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { getToken, callMcpTool } from '@/lib/mcp-client';

export async function GET(request: NextRequest) {
  const token = await getToken(request);
  if (!token) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  const action = request.nextUrl.searchParams.get('action') || 'connected';
  const toolName = action === 'available'
    ? 'getAvailableIntegrations'
    : 'listConnectedDevices';

  const rawText = await callMcpTool(token, toolName);
  if (!rawText) return NextResponse.json([]);

  // Try JSON first, fall back to YAML parsing
  try {
    return NextResponse.json(JSON.parse(rawText));
  } catch {
    return NextResponse.json(parseYamlList(rawText));
  }
}

// POST — connect or disconnect a device
export async function POST(request: NextRequest) {
  const token = await getToken(request);
  if (!token) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  const { action, integrationKey, redirectUrl } = await request.json();

  if (action === 'connect') {
    const rawText = await callMcpTool(token, 'generateUserLinkToken', {
      integrationKey,
      redirectUrl: redirectUrl || 'https://your-app.com/devices?connected=true',
    });
    if (!rawText) return NextResponse.json({ error: 'Failed' }, { status: 502 });
    return NextResponse.json(JSON.parse(rawText));
  }

  if (action === 'disconnect') {
    const rawText = await callMcpTool(token, 'disconnectIntegration', { integrationKey });
    return NextResponse.json({ message: rawText || 'Disconnected' });
  }

  return NextResponse.json({ error: 'Invalid action' }, { status: 400 });
}
```

---

## 7. Quick Start for Non-Developers

### Claude Desktop

Add this to your Claude Desktop MCP config (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS):

```json
{
  "mcpServers": {
    "betterness": {
      "type": "streamableHttp",
      "url": "https://api.betterness.ai/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_AUTH0_JWT"
      }
    }
  }
}
```

Then ask Claude: "What are my connected devices?" or "Show me available lab tests."

### Cursor / Windsurf

Create a `.mcp.json` file in your project root:

```json
{
  "mcpServers": {
    "betterness": {
      "type": "streamableHttp",
      "url": "https://api.betterness.ai/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_AUTH0_JWT"
      }
    }
  }
}
```

Restart the editor. The Betterness tools will appear in the MCP tool picker.

### ChatGPT (Custom GPT with Actions)

Create a Custom GPT and add an Action with this OpenAPI-style flow:

1. Set the server URL to `https://api.betterness.ai/mcp`
2. Auth type: Bearer Token
3. The GPT needs to implement the 3-step handshake internally via its Action schema. This is advanced -- for most GPT use cases, build a proxy API that handles the handshake (see the BFF pattern above) and expose simple REST endpoints to the GPT.

---

## 8. Testing with curl

### Full handshake in one script

```bash
#!/bin/bash
# Usage: ./test-mcp.sh <auth0_jwt> <tool_name> [arguments_json]
TOKEN="$1"
TOOL="$2"
ARGS="${3:-{}}"
BASE="https://api.betterness.ai/mcp"

# Step 1: Initialize
INIT_RESPONSE=$(curl -s -D - "$BASE" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "jsonrpc": "2.0",
    "method": "initialize",
    "params": {
      "protocolVersion": "2025-03-26",
      "capabilities": {},
      "clientInfo": { "name": "curl-test", "version": "1.0.0" }
    },
    "id": 1
  }')

# Extract session ID from headers
SESSION_ID=$(echo "$INIT_RESPONSE" | grep -i "mcp-session-id" | awk '{print $2}' | tr -d '\r')
echo "Session: $SESSION_ID"

# Step 2: Notify initialized
curl -s "$BASE" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Mcp-Session-Id: $SESSION_ID" \
  -d '{"jsonrpc": "2.0", "method": "notifications/initialized"}' \
  > /dev/null

# Step 3: Call tool
echo "Calling $TOOL with $ARGS..."
curl -s "$BASE" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Mcp-Session-Id: $SESSION_ID" \
  -d "{
    \"jsonrpc\": \"2.0\",
    \"method\": \"tools/call\",
    \"params\": { \"name\": \"$TOOL\", \"arguments\": $ARGS },
    \"id\": 2
  }"

echo ""
```

Usage:

```bash
chmod +x test-mcp.sh

# List connected devices
./test-mcp.sh "eyJhbGciOi..." listConnectedDevices

# Search for popular lab tests
./test-mcp.sh "eyJhbGciOi..." listAvailableLabTests '{"isPopular": true}'

# Get vitals for last 7 days
./test-mcp.sh "eyJhbGciOi..." getVitals '{"from": "2026-02-27", "to": "2026-03-06"}'
```

Remember: the response will be in SSE format. Look for the `data:` line and parse the JSON from there.

---

## 9. Common Pitfalls

| Problem | Symptom | Fix |
|---------|---------|-----|
| Skipped the initialize handshake | 400 error on `tools/call` | Always do the 3-step handshake: `initialize` then `notifications/initialized` then `tools/call` |
| `JSON.parse()` on raw response body | Parse error / unexpected token | Response is SSE format. Use the `parseSSE()` helper to extract the `data:` line first |
| Missing `Accept` header | Unexpected response format | Include `Accept: application/json, text/event-stream` on every request |
| Missing `Mcp-Session-Id` header | 400 error after init | Save the `Mcp-Session-Id` from the init response and include it in steps 2 and 3 |
| Lab test `markers` has duplicates | Duplicate biomarkers in UI | Deduplicate by marker ID or name before rendering |
| Forgot `Authorization` header | 401 Unauthorized | Every request needs `Authorization: Bearer <jwt>` |
| Treating `result.content[0].text` as an object | Type errors | It is a **string**. Parse it with `JSON.parse()` or a YAML parser depending on the tool |
| Using SSE transport instead of Streamable HTTP | Connection fails | The server uses Streamable HTTP -- standard `POST` requests, not an EventSource connection |
| Device/health data returns YAML, not JSON | Parse failures when expecting JSON | Check the "Returns" column in the tool reference. YAML tools need a YAML parser or the `parseYamlList` helper |
| `generateUserLinkToken` URL goes to tryvital.io | Unexpected domain | This is correct. Betterness uses Vital for wearable OAuth. The user authenticates their device there and gets redirected back to your `redirectUrl` |

---

## Supported Wearable Providers

These devices can be connected via `generateUserLinkToken`:

- Apple Health (via HealthKit)
- Garmin
- Oura
- Withings
- Eight Sleep
- Peloton
- Wahoo

---

## Architecture Overview

```
Your App (React, Next.js, mobile, etc.)
  |
  |  REST calls
  v
Your API Routes (BFF layer)
  |
  |  MCP Streamable HTTP (3-step handshake)
  |  Auth: Auth0 JWT Bearer token
  v
api.betterness.ai/mcp (MCP Server)
  |
  |  Internal
  v
Betterness Enterprise Backend (Spring Boot, AWS)
  |-- Vital (wearable data aggregation)
  |-- Lab test providers
  |-- Stripe (payments)
  |-- User data (MySQL + Neo4j)
```

The MCP server is a gateway to the full Betterness health data platform. You never talk to Vital, Stripe, or the lab providers directly -- the MCP tools handle everything.

---

## What You Can Build

- **Personal health dashboard** -- pull vitals, sleep, activity from any connected wearable
- **Longevity tracker** -- monitor biological age over time, surface biomarker trends
- **Lab test marketplace** -- browse tests, purchase with Stripe checkout, track order status through blood draw
- **Sleep optimizer** -- analyze sleep stages, correlate with HRV and activity
- **Coach/clinic portal** -- access client health data for personalized recommendations
- **Wearable onboarding flow** -- connect devices via OAuth, show connected status

All of this through 26 MCP tools and a single endpoint.
