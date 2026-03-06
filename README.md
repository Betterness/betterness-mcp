# Betterness MCP Server

Betterness is the first health and wellness platform with a native [Model Context Protocol (MCP)](https://modelcontextprotocol.io) server. Connect your wearables, labs, and health profile to any AI assistant.

**Endpoint:** `https://api.betterness.ai/mcp` (Streamable HTTP transport)

## Quick Start

### 1. Get an API Key

Sign up at [betterness.ai/mcp](https://www.betterness.ai/mcp) and generate an API key from the Developer Dashboard.

### 2. Connect Your AI Agent

The Betterness MCP server uses **Streamable HTTP transport** with **Bearer token authentication**. Any MCP-compatible AI agent can connect.

#### Claude Desktop

Add to your `claude_desktop_config.json` (`~/Library/Application Support/Claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
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
      "url": "https://api.betterness.ai/mcp",
      "headers": {
        "Authorization": "Bearer bk_your-api-key-here"
      }
    }
  }
}
```

#### Cursor

Add to `.cursor/mcp.json` in your project root:

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "headers": {
        "Authorization": "Bearer bk_your-api-key-here"
      }
    }
  }
}
```

#### Windsurf

Add via Windsurf's MCP settings panel with the same URL and authorization header.

#### OpenClaw

1. Go to **Settings → MCP Servers → Add Server**
2. Set URL to: `https://api.betterness.ai/mcp`
3. Add header: `Authorization: Bearer bk_your-api-key-here`
4. Save — your Clawbot now has access to all 26 health data tools

#### Any MCP Client / AI Agent

- **Transport:** Streamable HTTP
- **URL:** `https://api.betterness.ai/mcp`
- **Authentication:** HTTP header `Authorization: Bearer bk_your-api-key-here`
- **Protocol:** MCP 2024-11-05

Send JSON-RPC requests directly via POST:

```
POST https://api.betterness.ai/mcp
Content-Type: application/json
Authorization: Bearer bk_your-api-key-here

{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"your-agent","version":"1.0"}}}
```

### 3. Test the Connection

```bash
curl -X POST https://api.betterness.ai/mcp \
  -H "Authorization: Bearer bk_your-api-key-here" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}'
```

You should receive a JSON-RPC response with server capabilities — that means your key works.

---

## Tools (26 available)

### User Profile

#### `getUserContactData()`

Returns the authenticated user's profile: name, email, phone, gender, date of birth, and home address. Use before purchasing a lab test — purchases require gender, phone, birthdate, and a complete home address.

**Returns:** YAML

#### `updateUserContactData(firstName?, lastName?, phone?, phoneDialCode?, gender?, birthDate?, addressFullAddress?, addressCity?, addressState?, addressZipCode?, addressCountry?)`

Updates the current user's profile information. All parameters optional — only provided fields are updated. Always confirm changes with the user before calling.

**Returns:** JSON

---

### Connected Devices

#### `listConnectedDevices()`

Lists the user's currently active wearable and health data connections (Apple Health, Garmin, Oura, Withings, Eight Sleep, Peloton). Call before querying any health data tool. Only returns active connections.

**Returns:** YAML

#### `getAvailableIntegrations()`

Lists health device integrations the user can connect — providers not yet connected or previously disconnected. Available: `GARMIN`, `OURA`, `PELOTON`, `WAHOO`, `EIGHT_SLEEP`, `WITHINGS`.

**Returns:** YAML

#### `generateUserLinkToken(integrationKey, redirectUrl)`

Generates a connection link for a specific health device integration. The user must open the returned URL in their browser to authorize the connection.

**Returns:** JSON with `linkToken`, `linkWebUrl`, and `provider`.

#### `disconnectIntegration(integrationKey)`

Disconnects a health device integration. Disables the connection locally and deregisters from the provider.

**Returns:** Text

---

### Health Data (from wearables)

These tools pull measured data from connected wearables. All require `from` and `to` date parameters in `YYYY-MM-DD` format and accept an optional `zoneId` parameter (IANA timezone like `America/New_York`, defaults to UTC). Always pass the user's timezone so daily aggregations align with their local day boundaries. Best results with 7–30 day date ranges.

#### `getActivityData(from, to, activityTypes?, zoneId?)`

Returns daily activity metrics and workout sessions from connected wearables (Apple HealthKit, Strava, Garmin, Peloton, Wahoo). Includes steps, distance, calories, VO2 max, floors, and workouts.

**Returns:** YAML

#### `getVitals(from, to, zoneId?)`

Returns vital sign measurements: heart rate, HRV, blood pressure, SpO2, glucose, respiratory rate.

**Returns:** YAML

#### `getSleepData(from, to, zoneId?)`

Returns nightly sleep summaries with time in bed, total asleep, and stage breakdown (deep, light/core, REM, awake).

**Returns:** YAML

#### `getSleepStages(from, to, zoneId?)`

Returns minute-by-minute sleep stage transitions. More granular than `getSleepData`.

**Returns:** YAML

#### `getBodyComposition(from, to, zoneId?)`

Returns body composition measurements: weight, body fat %, body water %, muscle mass %, bone mass %, visceral fat index, BMI, lean mass, waist circumference.

**Returns:** YAML

---

### Biomarkers & Lab Results

#### `searchBiomarkers(biomarkerExternalId?, biomarkerLoincCode?, searchParam?, name?, startDate?, endDate?, categories?, range?)`

Searches and filters the user's biomarker lab results. Returns values with reference ranges and categories. All parameters optional.

**Returns:** JSON

#### `getLoincCodes()`

Returns all available LOINC codes — a reference list of standardized biomarker identifiers with names and descriptions.

**Returns:** JSON

#### `getBiologicalAge()`

Returns the user's biological age history — assessments showing biological age vs calendar age with contributing biomarker values.

**Returns:** JSON

---

### Lab Test Ordering

#### `listAvailableLabTests(query?, isPopular?)`

Lists lab tests available for ordering. Returns objectKey (needed for purchasing), name, description, lab, price, isPopular, and included biomarkers.

**Returns:** JSON

#### `getUserLabData(externalId?, startDate?, endDate?)`

Returns the user's lab data in a unified format — both Betterness lab orders and uploaded results. Each item includes `status`, `statusDescription`, and `nextStep` fields that guide the agent on what to do next.

**Returns:** JSON

#### `getLabOrderStatus(orderId?)` *(deprecated)*

Use `getUserLabData` instead.

---

### Purchases & Payments

#### `listSavedPaymentMethods()`

Lists the user's saved payment methods. Returns card brand, last 4 digits, expiration, default status, and `externalId` needed for `purchaseLabTest`. If empty, use the checkout flow.

**Returns:** JSON

#### `purchaseLabTest(labTestObjectKey, paymentMethodExternalId, promotionCode?)`

Purchases a lab test using a saved payment method. Always verify required profile fields and confirm with the user before calling. Charged immediately.

**Returns:** JSON

#### `purchaseLabTestWithCheckout(labTestObjectKey, successUrl, cancelUrl, promotionCode?)`

Generates a Stripe Checkout payment link for users without saved payment methods. Share the complete `checkoutUrl` — never truncate it. Order is created automatically after payment via webhook.

**Returns:** JSON

---

### Lab Order Management

#### `initializeLabOrder(labOrderExternalId)`

Initializes a lab order in "Paid" status, submitting it to the lab for processing. Requires complete user profile.

**Returns:** JSON

#### `searchLabServiceCenters(zipCode, labOrderExternalId)`

Searches for blood draw locations (Patient Service Centers) near a ZIP code. Use after an order reaches "Requisition Created" status.

**Returns:** JSON

#### `getServiceCenterSlots(siteCode, labOrderExternalId, timezone, startDate?, rangeDays?)`

Gets available appointment time slots at a specific service center. Returns `bookingKey` needed to book.

**Returns:** JSON

#### `bookLabAppointment(labOrderExternalId, bookingKey, timezone)`

Books a blood draw appointment. Use for "Requisition Created" or "Appointment Cancelled" orders. Do NOT use to reschedule — use `rescheduleLabAppointment` instead.

**Returns:** JSON

#### `rescheduleLabAppointment(labOrderExternalId, bookingKey, timezone)`

Reschedules an existing appointment. Only works for "Appointment Scheduled" status. Previous appointment is cancelled automatically.

**Returns:** JSON

#### `cancelLabAppointment(labOrderExternalId, reasonId?)`

Cancels a blood draw appointment. Call without `reasonId` first to get cancellation reasons, then call again with the chosen `reasonId`.

**Returns:** JSON

---

## Order Status Reference

Every lab order returned by `getUserLabData` includes a status. Here's what each means and what to do next.

| Status | Description | Action |
|--------|-------------|--------|
| **Paid** | Payment received, not yet submitted | Complete profile → `initializeLabOrder` |
| **Order Submitted** | Awaiting lab processing | Wait for requisition |
| **Requisition Created** | Lab requisition ready | `searchLabServiceCenters` → `getServiceCenterSlots` → `bookLabAppointment` |
| **Appointment Pending** | Being confirmed | Wait for confirmation |
| **Appointment Scheduled** | Blood draw booked | User visits lab. Can reschedule or cancel |
| **Appointment Cancelled** | Was cancelled | Book new with `bookLabAppointment` |
| **Redraw Available** | New sample needed | Schedule new appointment |
| **Partial Results** | Some results available | View with `searchBiomarkers`, wait for rest |
| **Completed** | All results available | `searchBiomarkers` + `getBiologicalAge` |
| **Failed** | Error occurred | Contact support or reorder |
| **Cancelled** | Order cancelled | Order new test |

---

## Common Flows

### "Buy a Lab Test" — Full 7-Step Lifecycle

1. **Ensure profile complete** → `getUserContactData` → `updateUserContactData` if needed
2. **Browse tests** → `listAvailableLabTests`
3. **Pay** → `listSavedPaymentMethods` → `purchaseLabTest` OR `purchaseLabTestWithCheckout`
4. **Initialize if needed** → `getUserLabData` → `initializeLabOrder`
5. **Schedule** → `searchLabServiceCenters` → `getServiceCenterSlots` → `bookLabAppointment`
6. **Manage** → `rescheduleLabAppointment` / `cancelLabAppointment`
7. **View results** → `searchBiomarkers` + `getBiologicalAge`

### "How am I doing?" — Health Overview

1. `getUserContactData()` — Identify the user
2. `listConnectedDevices()` — See available data sources
3. `getVitals` / `getSleepData` / `getActivityData` — Pull wearable data
4. `searchBiomarkers()` — Check recent lab results
5. `getBiologicalAge()` — Summarize with biological age trend

---

## Developer Tips

- **Check devices first.** If a health data tool returns empty, call `listConnectedDevices` to see if the user has a relevant wearable.
- **Pass the user's timezone** via `zoneId` so daily aggregations align with their local day.
- **Use 7-30 day ranges** for health data. Very large ranges return a lot of data.
- **Start with the profile.** Call `getUserContactData` first to personalize the conversation.
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
