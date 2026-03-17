# Betterness MCP

[![Tools: 32](https://img.shields.io/badge/tools-32-75FA79)](https://betterness.ai/mcp)
[![License: MIT](https://img.shields.io/badge/license-MIT-F5C648)](LICENSE)
[![Status: Beta](https://img.shields.io/badge/status-Beta-EF93F8)](https://betterness.ai)

**The health action layer for AI agents.** 32 tools on Streamable HTTP. Connect any AI to wearable data, biomarkers, lab ordering, health intelligence, and premium OpenClaw workspaces through BetterClaw OS.

---

## Start Here

Choose the path that matches what you want to do:

| Path | Best For | Get Started |
|------|----------|-------------|
| **BetterClaw OS** | Autonomous health workspace with AI agents | `claw workspace install betterness/recovery` |
| **Betterness MCP** | Universal AI integration (Claude, ChatGPT, Cursor) | [Quick Start](#quick-start) |
| **Betterness CLI** | Terminal power users, scripts, cron jobs | `npm i -g @betterness/cli` |

If this is your first time, start with **BetterClaw OS Recovery** — one command installs a fully personalized health workspace with your real data.

---

## BetterClaw OS — One Command, Full Health Workspace

```bash
claw workspace install betterness/recovery
```

The installer connects your Betterness account, pulls 7 data sources in parallel (profile, devices, health metrics, labs, bio age, flagged markers), personalizes your workspace files, and reveals an animated health card — the product's signature "magic moment."

### What You Get

```
recovery/
├── AGENTS.md              # AI specialists activated based on YOUR devices and data
├── SOUL.md                # Voice and communication style
├── IDENTITY.md            # Personalized with your name, goals, health context
├── HEARTBEAT.md           # Morning/evening crons customized from your sleep patterns
├── skills/
│   ├── install.md         # Magic moment installer (runs once)
│   ├── refresh.md         # Daily data refresh (heartbeat-triggered)
│   ├── recovery-verdict.md # Morning recovery scoring
│   └── sleep-analysis.md  # Overnight sleep interpretation
├── memory/                # Your devices, health snapshot, preferences
├── modules/               # Sleep architecture, HRV trend, readiness gate, rest day, bedtime
├── tests/fixtures/        # 14 MCP response fixtures for testing
└── .betterness/           # Token + birth certificate (gitignored)
```

### Packages

| Package | Description |
|---------|-------------|
| [**Recovery**](starters/betterclaw-os/recovery/) | Sleep, stress, nervous system recovery — morning verdicts, training gates, bedtime optimizer |
| [Marathon](starters/betterclaw-os/marathon/) | Training cycles, taper workflows, race-day prep, post-race recovery |
| [Biohacker Lab](starters/betterclaw-os/biohacker-lab/) | Biomarker tracking, protocol experiments, N-of-1 design |
| [Road Cycling](starters/betterclaw-os/road-cycling/) | Power zones, recovery between rides, event prep |
| [Barry's Studio](starters/betterclaw-os/barrys-studio/) | Custom studio operator for Barry's Bootcamp |

### Partner Cloning

Create custom workspaces for new partners:

```bash
./bin/clone-workspace.sh my-studio --config partners/my-studio.yaml
```

See [START-HERE.md](starters/betterclaw-os/START-HERE.md) for the full onboarding guide.

---

## Betterness CLI

**`npm install -g @betterness/cli`**

The fast terminal interface — 16 command groups covering every MCP capability.

```bash
betterness auth login                          # Save your API key
betterness workflow daily-brief                # Morning health summary
betterness sleep get --from 2026-03-10         # Sleep data
betterness biomarkers search --name "vitamin d" --range OUT_OF_RANGE
betterness connected-devices list              # Your wearables
betterness lab-orders service-centers --zip-code 94102 --order-id "abc"
```

| Group | Commands |
|-------|----------|
| `auth` | `login`, `logout`, `whoami` |
| `profile` | `get`, `update` |
| `biomarkers` | `search`, `loinc-codes` |
| `biological-age` | `get` |
| `activity` | `get` |
| `sleep` | `get`, `stages` |
| `vitals` | `get` |
| `body-composition` | `get` |
| `connected-devices` | `list`, `available`, `link`, `apple-health-code`, `disconnect` |
| `lab-tests` | `list` |
| `lab-records` | `list`, `detail` |
| `lab-orders` | `initialize`, `service-centers`, `slots`, `book`, `reschedule`, `cancel` |
| `lab-results` | `update-status`, `update-biomarker`, `update-metadata`, `upload-link` |
| `purchases` | `payment-methods`, `buy`, `checkout` |
| `smart-listings` | `search`, `detail` |
| `workflow` | `daily-brief`, `next-actions` |

Every command supports `--json`, `--markdown`, and `--quiet` output modes.

Full reference: [docs/cli/README.md](docs/cli/README.md)

---

## Three Access Paths, One Platform

```
@betterness/cli                    MCP Server                        BetterClaw OS
(terminal power users)             (AI agents)                       (autonomous workspaces)
─────────────────────              ──────────                        ─────────────
betterness sleep get               tools/call: getSleepData          "How did I sleep?"
betterness workflow daily-brief    tools/call: getProfileStats       Morning heartbeat auto-runs
betterness biomarkers search       tools/call: searchBiomarkers      Flagged in health snapshot

Install:                           Connect:                          Install:
npm i -g @betterness/cli          Add to MCP config                 claw workspace install
betterness auth login              Authorization: Bearer bk_*        betterness/recovery
```

---

## MCP Tools (32)

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

Get your API key at [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys).

### ChatGPT Actions

See [docs/clients/chatgpt-actions.md](docs/clients/chatgpt-actions.md) for the proxy setup guide.

### OpenClaw / Clawbot

For a basic MCP connection, register your bot at [betterness.ai/builders](https://betterness.ai/builders).

For a premium autonomous workspace, use BetterClaw OS:

```bash
claw workspace install betterness/recovery
```

---

## Skills Library

The [`skills/`](skills/) directory contains **119 pre-built skills** across **17 categories** that compose Betterness MCP tools into higher-level health workflows.

Browse the full catalog at [betterness.ai/skills](https://betterness.ai/skills).

---

## Links

| Resource | URL |
|----------|-----|
| Website | [betterness.ai](https://betterness.ai) |
| MCP Guide | [betterness.ai/mcp](https://betterness.ai/mcp) |
| CLI Reference | [docs/cli/](docs/cli/README.md) |
| BetterClaw OS | [starters/betterclaw-os/](starters/betterclaw-os/START-HERE.md) |
| Skills Catalog | [betterness.ai/skills](https://betterness.ai/skills) |
| Builders Portal | [betterness.ai/builders](https://betterness.ai/builders) |

---

## License

MIT — see [LICENSE](LICENSE) for details.
