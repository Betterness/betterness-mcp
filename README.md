# Betterness MCP

[![Tools: 42](https://img.shields.io/badge/tools-42-75FA79)](https://betterness.ai/mcp)
[![License: MIT](https://img.shields.io/badge/license-MIT-F5C648)](LICENSE)
[![Status: Beta](https://img.shields.io/badge/status-Beta-EF93F8)](https://betterness.ai)

**The health action layer for AI agents.** 42 tools on Streamable HTTP. Connect any AI to wearable data, biomarkers, lab ordering, health intelligence, and premium OpenClaw workspaces through BetterClaw OS.

---

## Start Here

Choose the path that matches what you want to do:

- **Universal AI integration** → use Betterness MCP
- **Fast local and terminal workflows** → see `docs/cli/`
- **OpenClaw health workspace** → start with [BetterClaw OS Recovery](starters/betterclaw-os/recovery/)
- **OpenClaw mission-control baseline** → use [openclaw-mission-control](starters/openclaw-mission-control/)

If this is your first BetterClaw install, start with **Recovery**. It is the easiest package to understand and the best template for the rest.

---

## Tools

### User Profile

| Tool | Description |
|------|-------------|
| `getUserContactData` | Retrieve the authenticated user's contact and demographic information |
| `updateUserContactData` | Update user contact details, preferences, or demographic fields |
| `getProfile` | Retrieve the user's profile (alias for getUserContactData) |
| `updateProfile` | Update the user's profile (alias for updateUserContactData) |

### Connected Devices

| Tool | Description |
|------|-------------|
| `listConnectedDevices` | List all wearable devices and health platforms currently linked to the user |
| `listAvailableIntegrations` | Return supported device and platform integrations (Oura, Whoop, Apple Health, etc.) |
| `generateLinkToken` | Generate a short-lived token to initiate a device or platform OAuth connection |
| `generateAppleHealthCode` | Generate a connection code for Apple HealthKit via the Junction app |
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

### Lab Tests

| Tool | Description |
|------|-------------|
| `listAvailableLabTests` | Browse the catalog of orderable lab tests with pricing and turnaround times |

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

### Lab Records & Results

| Tool | Description |
|------|-------------|
| `getUserLabRecords` | Retrieve the user's historical lab records and results |
| `getLabRecordDetail` | Get detailed information for a specific lab record |
| `getLabResultUploadLink` | Generate a platform link for manual lab result upload |
| `getLabResultFileUploadEndpoint` | Get the multipart upload URL for direct PDF upload |
| `updateLabResultStatus` | Approve, rollback, or reprocess an uploaded lab result |
| `updateLabResultBiomarker` | Modify or delete an individual biomarker value on a lab result |
| `updateLabResultMetadata` | Update patient info, lab name, or collection date on a lab result |

### Health Profile

| Tool | Description |
|------|-------------|
| `getHealthProfileSchema` | List all health profile sections and question IDs with types and examples |
| `getHealthProfile` | Retrieve all answered health profile questions |
| `getHealthProfileSection` | Get answers for a specific health profile section |
| `updateHealthProfile` | Patch health profile answers (only provided fields change) |
| `resetHealthProfileSection` | Clear all answers in a health profile section |

### Knowledge & Smart Listings

| Tool | Description |
|------|-------------|
| `searchKnowledge` | Search the health knowledge base for articles, guides, and videos |
| `searchSmartListings` | Search for wellness providers by name, location, or rating |
| `getSmartListingDetail` | Get detailed information about a specific wellness provider |

---

## Quick Start

### Auto-install via CLI (recommended)

```bash
npm install -g @betterness/cli
betterness auth login
betterness mcp install claude          # Claude Desktop
betterness mcp install claude-code     # Claude Code
betterness mcp install cursor          # Cursor
betterness mcp install windsurf        # Windsurf
```

The CLI reads your stored credentials, backs up the client's config file, and merges the Betterness MCP server entry. See [betterness-cli](https://github.com/Betterness/betterness-cli) for the full CLI reference.

### Manual configuration

Add the following to your MCP client config:

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

| Client | Config path |
|--------|-------------|
| Claude Desktop | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Claude Code (global) | `~/.claude/settings.json` |
| Claude Code (project) | `.mcp.json` |
| Cursor | `.cursor/mcp.json` |
| Windsurf | `~/.codeium/windsurf/mcp_config.json` |

### ChatGPT Actions

ChatGPT Actions require an HTTP proxy to bridge the MCP transport. See [docs/clients/chatgpt-actions.md](docs/clients/chatgpt-actions.md) for the full setup guide, including the OpenAPI spec and proxy configuration.

### Clawbot / OpenClaw

Clawbot is an OpenClaw agent that connects to Betterness MCP natively. Register your bot at [betterness.ai/builders](https://betterness.ai/builders), link it to your Betterness workspace, and the 42 health tools are available immediately -- no additional configuration required. Clawbot's SKILLS architecture routes tool calls through the SkillGraph for intelligent multi-step health workflows.

If you want a premium OpenClaw workspace rather than a basic MCP connection, start with [BetterClaw OS](starters/betterclaw-os/README.md) and use the [Recovery package](starters/betterclaw-os/recovery/README.md) as the first install.

---

## Skills Library

The [`skills/`](skills/) directory contains **119 pre-built skills** across **17 categories** that compose Betterness MCP tools into higher-level health workflows. Skills are declarative YAML definitions that the SkillGraph engine resolves at runtime, handling dependency ordering, parallel execution, and context passing between tools.

Browse the full catalog at [betterness.ai/skills](https://betterness.ai/skills).

---

## Starter Kits

The [`starters/`](starters/) directory provides ready-to-run example projects demonstrating common integration patterns: wearable dashboards, biomarker tracking agents, lab ordering flows, and more. Each starter includes a working configuration, sample prompts, and step-by-step instructions.

### BetterClaw OS

[`starters/betterclaw-os/`](starters/betterclaw-os/) contains the premium OpenClaw workspace system for Betterness.

Flagship packages:

- [Recovery](starters/betterclaw-os/recovery/README.md)
- [Marathon](starters/betterclaw-os/marathon/README.md)
- [Biohacker Lab](starters/betterclaw-os/biohacker-lab/README.md)
- [Road Cycling](starters/betterclaw-os/road-cycling/README.md)
- [Barry's](starters/betterclaw-os/barrys-studio/README.md)

Start with [Recovery](starters/betterclaw-os/recovery/README.md) if you want the fastest path with the least confusion.

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
