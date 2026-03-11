# Betterness MCP

[![Tools: 32](https://img.shields.io/badge/tools-32-75FA79)](https://betterness.ai/mcp)
[![License: MIT](https://img.shields.io/badge/license-MIT-F5C648)](LICENSE)
[![Status: Beta](https://img.shields.io/badge/status-Beta-EF93F8)](https://betterness.ai)

**The health action layer for AI agents.** 32 tools on Streamable HTTP. Connect any AI to wearable data, biomarkers, lab ordering, and health intelligence.

---

## Tools

### User Profile

| Tool | Description |
|------|-------------|
| `getUserContactData` | Retrieve the authenticated user's contact and demographic information |
| `updateUserContactData` | Update user contact details, preferences, or demographic fields |

### Connected Devices

| Tool | Description |
|------|-------------|
| `listConnectedDevices` | List all wearable devices and health platforms currently linked to the user |
| `getAvailableIntegrations` | Return supported device and platform integrations (Oura, Whoop, Apple Health, etc.) |
| `generateUserLinkToken` | Generate a short-lived token to initiate a device or platform OAuth connection |
| `disconnectIntegration` | Revoke access and unlink a connected device or platform |

### Health Data

| Tool | Description |
|------|-------------|
| `getActivityData` | Fetch steps, calories, distance, and active minutes for a date range |
| `getVitals` | Retrieve heart rate, HRV, SpO2, respiratory rate, and other vitals |
| `getSleepData` | Get sleep duration, efficiency, and quality scores |
| `getSleepStages` | Return detailed sleep stage breakdowns (deep, REM, light, awake) |
| `getBodyComposition` | Fetch weight, body fat percentage, muscle mass, and related metrics |

### Biomarkers & Labs

| Tool | Description |
|------|-------------|
| `searchBiomarkers` | Search the biomarker database by name, category, or clinical relevance |
| `getLoincCodes` | Look up LOINC codes for standardized lab test identification |
| `getBiologicalAge` | Calculate biological age from available biomarker and wearable data |

### Lab Ordering

| Tool | Description |
|------|-------------|
| `listAvailableLabTests` | Browse the catalog of orderable lab tests with pricing and turnaround times |
| `getUserLabData` | Retrieve historical lab results for the authenticated user |
| `getLabOrderStatus` | Check the current status of a lab order |

### Payments

| Tool | Description |
|------|-------------|
| `listSavedPaymentMethods` | List the user's saved payment methods for lab purchases |
| `purchaseLabTest` | Purchase a lab test using a saved payment method |
| `purchaseLabTestWithCheckout` | Purchase a lab test via a hosted checkout session |

### Scheduling

| Tool | Description |
|------|-------------|
| `initializeLabOrder` | Create a lab order and prepare it for scheduling |
| `searchLabServiceCenters` | Search for nearby lab draw sites by location or zip code |
| `getServiceCenterSlots` | Retrieve available appointment slots at a specific service center |
| `bookLabAppointment` | Book a lab draw appointment at a selected service center and time |
| `rescheduleLabAppointment` | Move an existing lab appointment to a new date, time, or location |
| `cancelLabAppointment` | Cancel a scheduled lab appointment |

### Records

| Tool | Description |
|------|-------------|
| `getUserLabRecords` | Retrieve the user's historical lab records and results |
| `getLabRecordDetail` | Get detailed information for a specific lab record |
| `getLabResultUploadLink` | Generate a signed upload URL for submitting lab result documents |

### Knowledge

| Tool | Description |
|------|-------------|
| `knowledgeSearch` | Search the health knowledge base for articles, guides, and clinical references |
| `getPartnerDetail` | Get detailed information about a specific health partner or provider |

### Smart Listings

| Tool | Description |
|------|-------------|
| `searchPartners` | Search for health partners and providers by specialty, location, or rating |

---

## Quick Start

### Claude Desktop

Add the following to your Claude Desktop MCP configuration:

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_KEY" }
    }
  }
}
```

Replace `YOUR_KEY` with your Betterness API key. Get one at [betterness.ai/builders](https://betterness.ai/builders).

### ChatGPT Actions

ChatGPT Actions require an HTTP proxy to bridge the MCP transport. See [docs/clients/chatgpt-actions.md](docs/clients/chatgpt-actions.md) for the full setup guide, including the OpenAPI spec and proxy configuration.

### Clawbot / OpenClaw

Clawbot is an OpenClaw agent that connects to Betterness MCP natively. Register your bot at [betterness.ai/builders](https://betterness.ai/builders), link it to your Betterness workspace, and the 32 health tools are available immediately -- no additional configuration required. Clawbot's SKILLS architecture routes tool calls through the SkillGraph for intelligent multi-step health workflows.

---

## Skills Library

The [`skills/`](skills/) directory contains **119 pre-built skills** across **17 categories** that compose Betterness MCP tools into higher-level health workflows. Skills are declarative YAML definitions that the SkillGraph engine resolves at runtime, handling dependency ordering, parallel execution, and context passing between tools.

Browse the full catalog at [betterness.ai/skills](https://betterness.ai/skills).

---

## Starter Kits

The [`starters/`](starters/) directory provides ready-to-run example projects demonstrating common integration patterns: wearable dashboards, biomarker tracking agents, lab ordering flows, and more. Each starter includes a working configuration, sample prompts, and step-by-step instructions.

---

## Links

| Resource | URL |
|----------|-----|
| Website | [betterness.ai](https://betterness.ai) |
| MCP Guide | [betterness.ai/mcp](https://betterness.ai/mcp) |
| Skills Catalog | [betterness.ai/skills](https://betterness.ai/skills) |
| Builders Portal | [betterness.ai/builders](https://betterness.ai/builders) |

---

## License

MIT -- see [LICENSE](LICENSE) for details.
