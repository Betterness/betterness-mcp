# Betterness CLI (`@betterness/cli`)

**The fast terminal interface to the Betterness platform.**

Use Betterness CLI when you want lower-token local workflows, scriptable automation, cron-friendly health ops, or a fast command surface for OpenClaw, Codex, Claude Code, and terminal-native users.

## Install

```bash
npm install -g @betterness/cli
```

## Quick Start

```bash
betterness auth login                          # Save your API key
betterness workflow daily-brief                # Morning health summary
betterness sleep get --from 2026-03-10         # Last week's sleep data
betterness biomarkers search --name "vitamin d" # Search lab results
betterness connected-devices list              # Your wearables
```

## Relationship to MCP and BetterClaw OS

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

- **Betterness MCP** is the universal remote integration surface (AI agents, Claude, ChatGPT)
- **Betterness CLI** is the fast local and operator surface (terminal, scripts, cron)
- **BetterClaw OS** is the autonomous workspace surface (OpenClaw, always-on health intelligence)

All three access the same health data through the same backend.

## Global Options

| Option | Description |
|--------|-------------|
| `-V, --version` | Output the version number |
| `--api-key <key>` | API key (overrides env and stored credentials) |
| `--api-url <url>` | Backend API URL (default: `https://api.betterness.com`) |
| `--json` | Output as JSON |
| `--markdown` | Output as Markdown |
| `--quiet` | Suppress output (exit code only) |

## Command Reference

### auth — Authentication

```bash
betterness auth login              # Save API key (prompts if not provided)
betterness auth login --key bk_... # Save API key directly
betterness auth logout             # Remove stored credentials
betterness auth whoami             # Show authenticated user
```

### profile — User Profile

```bash
betterness profile get             # Name, email, phone, gender, DOB, address
betterness profile update --first-name "Jane" --birth-date 1994-07-15
betterness profile update --address "123 Main St" --city "SF" --state "CA" --zip-code "94102"
betterness profile update --dry-run  # Preview without applying
```

### biomarkers — Lab Results & LOINC Codes

```bash
betterness biomarkers search                           # All biomarkers
betterness biomarkers search --name "vitamin d"        # Filter by name
betterness biomarkers search --range OUT_OF_RANGE      # Only flagged
betterness biomarkers search --categories "vitamins,hormones" --limit 50
betterness biomarkers loinc-codes                      # List all LOINC codes
```

### biological-age — Bio Age History

```bash
betterness biological-age get            # Last 10 calculations
betterness biological-age get --limit 50 # Extended history
```

### activity — Workouts & Movement

```bash
betterness activity get                                    # Today's activity
betterness activity get --from 2026-03-01 --to 2026-03-15 # Date range
betterness activity get --timezone "America/New_York"      # Specific timezone
```

### sleep — Sleep Data

```bash
betterness sleep get                            # Recent sleep
betterness sleep get --from 2026-03-10          # From specific date
betterness sleep stages --from 2026-03-14       # Minute-by-minute stages (Deep, Core, REM, Awake)
```

### vitals — Heart Rate, HRV, SpO2

```bash
betterness vitals get                           # Recent vitals
betterness vitals get --from 2026-03-01         # Date range
```

### body-composition — Weight, Body Fat, BMI

```bash
betterness body-composition get                 # Recent data
betterness body-composition get --from 2026-01-01
```

### connected-devices — Wearable Management

```bash
betterness connected-devices list                              # All connected devices
betterness connected-devices available                         # What you can connect
betterness connected-devices link --integration-key OURA       # Generate Oura link
betterness connected-devices apple-health-code                 # Apple Health via Junction
betterness connected-devices disconnect --integration-key OURA # Disconnect
```

Supported integrations: `GARMIN`, `OURA`, `WITHINGS`, `PELOTON`, `WAHOO`, `EIGHT_SLEEP`

Apple Health uses a separate code-based flow via the Junction app.

### lab-tests — Browse Available Tests

```bash
betterness lab-tests list                       # Full catalog
betterness lab-tests list --query "thyroid"     # Search
betterness lab-tests list --popular             # Popular tests only
```

### lab-records — Results & Orders

```bash
betterness lab-records list                            # All records
betterness lab-records detail --record-id "abc-123"    # Full detail
```

### lab-orders — Scheduling & Appointments

```bash
# Full booking flow
betterness lab-orders initialize --order-id "abc-123"
betterness lab-orders service-centers --zip-code 94102 --order-id "abc-123"
betterness lab-orders slots --site-code "QST-001" --order-id "abc-123" --timezone "America/Los_Angeles"
betterness lab-orders book --order-id "abc-123" --booking-key "slot-key" --timezone "America/Los_Angeles"

# Reschedule / Cancel
betterness lab-orders reschedule --order-id "abc-123" --booking-key "new-slot" --timezone "America/Los_Angeles"
betterness lab-orders cancel --order-id "abc-123"                  # List reasons
betterness lab-orders cancel --order-id "abc-123" --reason-id 3    # Cancel with reason
```

### lab-results — Result Management

```bash
betterness lab-results update-status --result-id "xyz" --action APPROVE
betterness lab-results update-biomarker --biomarker-id "bio-1" --result 5.2 --unit "ng/mL"
betterness lab-results update-metadata --result-id "xyz" --patient-name "Jane Doe" --fasting
betterness lab-results upload-link                     # Get PDF upload URL
```

### purchases — Payments & Checkout

```bash
betterness purchases payment-methods                                     # Saved cards
betterness purchases buy --test-key "comp-meta" --payment-method-id "pm-1"
betterness purchases checkout --test-key "comp-meta" --success-url "https://..." --cancel-url "https://..."
```

### smart-listings — Provider Directory

```bash
betterness smart-listings search --query "functional medicine"
betterness smart-listings search --lat 37.7749 --lng -122.4194 --radius 10
betterness smart-listings detail --id "listing-123"
```

### workflow — Composite Commands

```bash
betterness workflow daily-brief                # Morning health summary (profile + bio age + markers + devices)
betterness workflow next-actions               # AI-recommended next steps
```

### schema — Discovery

```bash
betterness schema                              # All commands, options, response formats
```

## Output Formats

Every command supports three output modes:

```bash
betterness sleep get                  # Human-readable table (default)
betterness sleep get --json           # Machine-readable JSON
betterness sleep get --markdown       # Markdown table (great for agents)
```

Use `--quiet` for scripting (exit code only, no output).

## Authentication

The CLI stores credentials at `~/.config/betterness/token`. This is also one of the locations the BetterClaw OS installer checks when bootstrapping a workspace.

```bash
betterness auth login --key bk_your_api_key    # Save directly
betterness auth login                          # Interactive prompt
betterness auth whoami                         # Verify
betterness auth logout                         # Remove
```

You can also pass `--api-key` to any command for one-off use without storing credentials.
