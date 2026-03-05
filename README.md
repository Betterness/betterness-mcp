# Betterness MCP Server

Betterness is the first health and wellness platform with a native [Model Context Protocol (MCP)](https://modelcontextprotocol.io) server. Connect your wearables, labs, and health profile to any AI assistant.

**Endpoint:** `https://api.betterness.ai/sse` (SSE transport)

## Quick Start

### 1. Get an API Key

Sign up at [betterness.ai/mcp](https://www.betterness.ai/mcp) and generate an API key from the Developer Dashboard.

### 2. Connect Your AI Agent

The Betterness MCP server uses **SSE (Server-Sent Events) transport** with **Bearer token authentication**. Any MCP-compatible AI agent can connect.

#### Claude Desktop

Add to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/sse",
      "headers": {
        "Authorization": "Bearer bk_your-api-key-here"
      }
    }
  }
}
```

#### Claude Code (CLI)

Add to your `.mcp.json` or project settings:

```json
{
  "mcpServers": {
    "betterness": {
      "type": "url",
      "url": "https://api.betterness.ai/sse",
      "headers": {
        "Authorization": "Bearer bk_your-api-key-here"
      }
    }
  }
}
```

#### Any MCP Client / AI Agent / Clawbot

To connect any MCP-compatible agent (including Augmented Games Clawbots):

- **Transport:** SSE (Server-Sent Events)
- **URL:** `https://api.betterness.ai/sse`
- **Authentication:** HTTP header `Authorization: Bearer bk_your-api-key-here`
- **Protocol:** MCP 2024-11-05

The SSE connection returns a session endpoint. Send JSON-RPC messages to that endpoint:

```
1. Connect to SSE:  GET https://api.betterness.ai/sse
   → Receives: event:endpoint, data:/mcp/message?sessionId=<id>

2. Initialize:      POST https://api.betterness.ai/mcp/message?sessionId=<id>
   Body: {"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"your-agent","version":"1.0"}}}

3. Notify ready:    POST https://api.betterness.ai/mcp/message?sessionId=<id>
   Body: {"jsonrpc":"2.0","method":"notifications/initialized"}

4. List tools:      POST https://api.betterness.ai/mcp/message?sessionId=<id>
   Body: {"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}

5. Call a tool:     POST https://api.betterness.ai/mcp/message?sessionId=<id>
   Body: {"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"getUserContactData","arguments":{}}}
```

All responses are delivered via the SSE stream, not in the HTTP response body.

### 3. Test the Connection

```bash
curl -s https://api.betterness.ai/sse \
  -H "Authorization: Bearer bk_your-api-key-here" \
  -H "Accept: text/event-stream"
```

You should see an `event:endpoint` message with a session ID — that means your key works.

---

## Tools (18 available)

### User Profile

#### `getUserContactData()`

Returns the authenticated user's contact information: first name, last name, email, and phone number.

Use this early in a conversation to identify the user and personalize responses. The data comes from the user's Betterness account profile.

**Returns:** YAML with `firstName`, `lastName`, `email`, `phone`.

#### `getUserWellnessProfile()`

Returns the user's self-reported wellness profile — health goals, existing conditions, exercise habits, dietary preferences, sleep patterns, and lifestyle details.

This is NOT wearable data. It reflects what the user reported during onboarding. Use it to understand context and personalize recommendations.

**Returns:** Text summary.

---

### Connected Devices

#### `listConnectedDevices()`

Lists the user's currently active wearable and health data connections — for example Apple Health, Garmin, Oura, Withings, Eight Sleep, or Peloton.

Call this before querying any health data tool. If a health data tool returns empty results, this tool tells you whether the user actually has a relevant device connected. Only returns active connections; disconnected or disabled integrations are excluded.

**Returns:** YAML list of active providers with connection date.

#### `getAvailableIntegrations()`

Lists health device integrations the user can connect — providers that are either not yet connected or were previously disconnected.

Available providers: `GARMIN`, `OURA`, `PELOTON`, `WAHOO`, `EIGHT_SLEEP`, `WITHINGS`. Apple Health requires the mobile app and is not available through this flow.

**Returns:** YAML list with provider `key`, human-readable `name`, and `description`.

#### `generateUserLinkToken(integrationKey, redirectUrl)`

Generates a connection link for a specific health device integration. The user must open the returned URL in their browser to authorize the connection on the provider's side.

- `integrationKey` (required) — provider key from `getAvailableIntegrations` (e.g. `GARMIN`, `OURA`)
- `redirectUrl` (required) — URL to redirect the user to after they complete the authorization

Returns an error if the user is already connected to the specified provider. Show the `linkWebUrl` to the user so they can click it.

**Returns:** JSON with `linkToken`, `linkWebUrl`, and `provider`.

#### `disconnectIntegration(integrationKey)`

Disconnects a health device integration, removing the connection between the user and the specified provider. Disables the connection locally and deregisters from the provider.

- `integrationKey` (required) — provider key to disconnect (e.g. `GARMIN`, `OURA`)

**Returns:** Success or error message.

---

### Health Data (from wearables)

These tools pull measured data from connected wearables. All require `from` and `to` date parameters in `YYYY-MM-DD` format and accept an optional `zoneId` parameter (IANA timezone like `America/New_York`, defaults to UTC). Always pass the user's timezone so daily aggregations align with their local day boundaries. Best results with 7–30 day date ranges.

#### `getActivityData(from, to, activityTypes?, zoneId?)`

Returns daily activity metrics and workout sessions from connected wearables and apps (Apple HealthKit, Strava, Garmin, Peloton, Wahoo).

Includes steps, distance, active and basal calories, floors climbed, VO2 max, and workout sessions (running, cycling, yoga, weightlifting, swimming, hiking, etc.) with duration and details.

Use `activityTypes` (comma-separated, e.g. `"RUNNING,YOGA"`) to narrow results when the user asks about a specific activity type.

**Returns:** YAML with daily activity data and workout sessions.

#### `getVitals(from, to, zoneId?)`

Returns vital sign measurements from connected wearables and apps (Apple HealthKit, Oura, Garmin, Withings).

Includes heart rate, heart rate variability (HRV), blood pressure (systolic/diastolic), blood oxygen (SpO2), glucose, and respiratory rate for each day in the requested range.

**Returns:** YAML with daily vital sign data.

#### `getSleepData(from, to, zoneId?)`

Returns nightly sleep summaries from connected wearables and apps (Apple HealthKit, Oura, Eight Sleep, Garmin).

Includes time in bed, total time asleep, and a breakdown by sleep stage (deep, light/core, REM, awake) for each night in the requested range. For detailed sleep cycle analysis, use `getSleepStages` instead.

**Returns:** YAML with nightly sleep data.

#### `getSleepStages(from, to, zoneId?)`

Returns minute-by-minute sleep stage transitions from connected wearables (Apple HealthKit, Oura, Eight Sleep, Garmin).

Each entry contains the stage name (Deep, Core, REM, Awake), start time, end time, and duration. Entries are grouped by night. More granular than `getSleepData` — use it when the user wants cycle-level detail.

**Returns:** YAML with chronological sleep stage transitions grouped by night date.

#### `getBodyComposition(from, to, zoneId?)`

Returns body composition measurements from connected devices (Apple HealthKit, Withings, Garmin).

Includes weight, body fat %, body water %, muscle mass %, bone mass %, visceral fat index, BMI, lean body mass, and waist circumference.

**Returns:** YAML with daily body composition data.

---

### Biomarkers & Lab Results

#### `searchBiomarkers(biomarkerExternalId?, biomarkerLoincCode?, searchParam?, name?, startDate?, endDate?, categories?, range?)`

Searches and filters the user's biomarker lab results. Returns values with reference ranges and categories.

All parameters are optional:
- `biomarkerExternalId` — filter by specific biomarker ID
- `biomarkerLoincCode` — filter by LOINC code (use `getLoincCodes` to find valid codes)
- `searchParam` — free-text search across biomarker names
- `name` — exact biomarker name filter
- `startDate` / `endDate` — ISO-8601 date range (e.g. `"2025-01-01T00:00:00Z"` or `"2025-01-01"`)
- `categories` — comma-separated categories (e.g. `"METABOLIC,HORMONAL"`)
- `range` — `OPTIMAL`, `AVERAGE`, `OUT_OF_RANGE`, or `UNKNOWN`

**Returns:** JSON with biomarker values, reference ranges, and categories.

#### `getLoincCodes()`

Returns all available LOINC codes — a reference list of standardized biomarker identifiers with names and descriptions.

Use this to look up valid LOINC codes before filtering with `searchBiomarkers`.

**Returns:** JSON list of LOINC codes with names and descriptions.

#### `getBiologicalAge()`

Returns the user's biological age history — a series of assessments showing how the user's biological age compares to their calendar age, with the contributing biomarker values for each assessment.

**Returns:** JSON list of biological age results with calendar age, biological age, and biomarker values.

---

### Lab Test Ordering

#### `listAvailableLabTests(query?, isPopular?)`

Lists lab tests available for ordering through Betterness.

- `query` (optional) — free-text search to filter by test name or description
- `isPopular` (optional) — `"true"` for popular tests only, `"false"` for non-popular only

Use this after finding a biomarker gap (e.g. no recent Vitamin D results) to suggest a specific test the user can order.

**Returns:** JSON array of tests with `externalId`, `name`, `description`, `lab`, `price`, `isPopular`, and `markers`.

#### `getUserLabData(externalId?, startDate?, endDate?)`

Returns the user's lab data in a unified format — both lab orders placed through Betterness and lab results uploaded by the user.

- `externalId` (optional) — filter to a specific order or result
- `startDate` (optional, `yyyy-MM-dd`) — only items collected on or after this date
- `endDate` (optional, `yyyy-MM-dd`) — only items collected on or before this date

**Returns:** JSON array with `source` (`"order"` or `"result"`), `externalId`, `name`, `status`, `dateCollected`, `dateCreated`.

#### `getLabOrderStatus(orderId?)` *(deprecated)*

Returns lab order statuses only (does not include uploaded results). Use `getUserLabData` instead.

**Returns:** JSON.

---

### Knowledge Base

#### `searchKnowledge(query)`

Searches the Betterness wellness knowledge base for evidence-based health insights. Returns both curated content and the user's personal synced knowledge.

- `query` (required) — search query text

**Returns:** JSON with relevant knowledge entries.

---

## Developer Tips

- **Check devices first.** If a health data tool returns empty, call `listConnectedDevices` to see if the user has a relevant wearable.
- **Pass the user's timezone** via `zoneId` so daily aggregations align with their local day.
- **Use 7-30 day ranges** for health data. Very large ranges return a lot of data.
- **Start with the profile.** Call `getUserContactData` and `getUserWellnessProfile` first to personalize the conversation.
- **Biomarker workflow:** `getLoincCodes` → `searchBiomarkers` → if missing, `listAvailableLabTests` to suggest a test → `getUserLabData` to check if one is in progress.
- **Device connection workflow:** `getAvailableIntegrations` → user picks a provider → `generateUserLinkToken` → show `linkWebUrl` → `disconnectIntegration` to remove.

---

## Supported Providers

- Apple Health (via mobile app)
- Garmin
- Oura
- Peloton
- Wahoo
- Eight Sleep
- Withings

---

## Security

Your health data is encrypted and transmitted securely. Device connections and lab orders require explicit user authorization. Authentication uses API key bearer tokens issued through the Betterness Developer Dashboard.

---

## Links

- [Betterness MCP Developer Page](https://www.betterness.ai/mcp)
- [Model Context Protocol](https://modelcontextprotocol.io)
- [Betterness](https://www.betterness.ai)
