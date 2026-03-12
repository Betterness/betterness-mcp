# Recovery

**A BetterClaw OS package for sleep, stress, and nervous system recovery.**

Powered by [Betterness Graph](https://betterness.ai) and [Betterness MCP](https://github.com/Betterness/betterness-mcp).

---

## What It Does

Recovery Operator turns your wearable data into daily recovery intelligence:

- **Morning verdict** — green / amber / red with one action
- **Training gate** — should you push, moderate, or rest today?
- **Bedtime optimizer** — when to wind down based on your patterns
- **Trend tracking** — 7-day and 30-day recovery trajectories
- **Rest day planning** — restorative activities when recovery is low
- **Lab overlay** — biomarker context when connected (cortisol, thyroid, inflammation)

## Quick Start

### 1. Set up your OpenClaw workspace

Copy this package into your OpenClaw workspace:

```bash
cp -r starters/betterclaw-os/recovery/ ~/your-workspace/
```

### 2. Connect Betterness MCP

Add Betterness MCP to your OpenClaw MCP configuration:

```json
{
  "mcpServers": {
    "betterness": {
      "url": "https://api.betterness.ai/mcp",
      "auth": {
        "type": "bearer",
        "token": "YOUR_BETTERNESS_API_KEY"
      }
    }
  }
}
```

### 3. Connect your devices

Link at least one wearable through your Betterness account:
- Oura Ring
- WHOOP
- Eight Sleep
- Apple Watch
- Garmin
- Withings

### 4. Start

Open your workspace and ask: **"How did I sleep?"**

Recovery Operator handles the rest.

---

## Package Structure

```
recovery/
  AGENTS.md           # Agent behavior and specialist activation
  SOUL.md             # Voice, tone, and communication style
  IDENTITY.md         # Who this is for and what makes it different
  MEMORY.md           # Local memory + Betterness Graph strategy
  WORKSPACE.md        # Home view, modules, and interaction model
  HEARTBEAT.md        # Morning, evening, and weekly automated loops
  PLANNING-MODE.md    # Deep reasoning for complex recovery questions
  ANTI-PATTERNS.md    # What this package must never become
  README.md           # This file
  skills/
    sleep-analysis.md     # Overnight sleep data interpretation
    recovery-verdict.md   # Daily recovery scoring and action
  modules/
    sleep-architecture/   # Deep sleep, REM, awakenings analysis
    hrv-trend/            # HRV trajectory and baseline comparison
    readiness-gate/       # Train / moderate / rest decision
    rest-day-planner/     # Restorative activity suggestions
    bedtime-optimizer/    # Optimal sleep timing
```

---

## Supported Devices

| Device | What It Provides |
|--------|-----------------|
| Oura Ring | Sleep stages, HRV, readiness, temperature, SpO2 |
| WHOOP | Recovery score, strain, HRV, respiratory rate |
| Eight Sleep | Sleep tracking, temperature regulation |
| Apple Watch | Sleep, heart rate, respiratory rate |
| Garmin | Sleep, Body Battery, HRV, stress, training load |
| Withings | Sleep, breathing disturbances, heart rate |

## Optional: Lab Biomarkers

When lab data is connected through Betterness, Recovery Operator layers biomarker context into recovery reasoning:
- Cortisol, DHEA-S (stress axis)
- Testosterone, free T (anabolic recovery)
- TSH, fT3, fT4 (thyroid / energy)
- CRP, ferritin (inflammation)
- Vitamin D, magnesium (sleep cofactors)

---

## Design Principles

1. **One home, not many tabs.** The workspace opens to a single recovery verdict.
2. **Action over observation.** Every insight includes what to do next.
3. **Signal over noise.** Lead with what changed and why it matters.
4. **Personal, not generic.** Baselines are yours, not population averages.
5. **Calm authority.** Recovery is a long game, not a daily crisis.

---

## Part of BetterClaw OS

Recovery Operator is a [BetterClaw OS](https://github.com/Betterness/betterness-mcp/tree/main/starters/betterclaw-os) package — the Betterness-powered health workspace system for OpenClaw.

Other BetterClaw OS packages:
- Marathon Operator
- Road Cycling Operator
- HYROX Operator
- Biohacker Lab Operator
- And more at [github.com/Betterness/betterness-mcp](https://github.com/Betterness/betterness-mcp)

---

*Powered by Betterness*
