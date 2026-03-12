# Marathon

**A BetterClaw OS package for marathon training, race preparation, and periodized running intelligence.**

Powered by [Betterness Graph](https://betterness.ai) and [Betterness MCP](https://github.com/Betterness/betterness-mcp).

---

## What It Does

Marathon Operator turns your wearable data and training history into periodized marathon intelligence:

- **Training phase awareness** — knows whether you are in base, build, peak, taper, or race week and adjusts everything accordingly
- **Long run planning** — distance, pace, fueling plan, and route for your next long run
- **Recovery gating** — should you push, moderate, or rest today based on recovery and training load
- **Taper intelligence** — auto-detects taper phase, manages the volume reduction, and keeps you from panicking
- **Fueling calculator** — calorie and hydration targets that scale with training volume and race-day conditions
- **Race-week protocol** — 7-day countdown with daily guidance from final long run through gun time

## Quick Start

### 1. Set up your OpenClaw workspace

Copy this package into your OpenClaw workspace:

```bash
cp -r starters/betterclaw-os/marathon/ ~/your-workspace/
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
        "token": "bk_YOUR_KEY"
      }
    }
  }
}
```

### 3. Connect your devices

Link at least one wearable through your Betterness account:
- Garmin (training load, VO2max, Body Battery, sleep, HRV)
- WHOOP (strain, recovery, HRV, respiratory rate)
- Oura Ring (sleep stages, HRV, readiness, temperature)
- Apple Watch (sleep, heart rate, VO2max estimate, running metrics)
- COROS (training load, threshold pace, sleep, HRV)
- Polar (running index, training load, recovery)

### 4. Start

Open your workspace and ask: **"What's my training look like this week?"**

Marathon Operator handles the rest.

---

## Package Structure

```
marathon/
  AGENTS.md           # Agent behavior and specialist activation
  SOUL.md             # Voice, tone, and communication style
  IDENTITY.md         # Who this is for and what makes it different
  MEMORY.md           # Local memory + Betterness Graph strategy
  WORKSPACE.md        # Home view, modules, and interaction model
  HEARTBEAT.md        # Morning, post-run, and weekly automated loops
  PLANNING-MODE.md    # Deep reasoning for complex training questions
  ANTI-PATTERNS.md    # What this package must never become
  README.md           # This file
  skills/
    training-status.md    # Daily training readiness with phase context
    race-prep.md          # Race week planning and execution
  modules/
    training-load/        # Weekly mileage, intensity, training stress
    long-run-planner/     # Next long run: distance, pace, fueling, route
    taper-intelligence/   # Auto-detected taper with volume management
    race-week-protocol/   # 7-day race countdown with daily guidance
    fueling-calculator/   # Calorie and hydration targets
    route-planner/        # Maps integration for run routes
    recovery-gate/        # Push / moderate / rest decision
```

---

## Supported Devices

| Device | What It Provides |
|--------|-----------------|
| Garmin | Training load, VO2max, Body Battery, sleep, HRV, pace zones, cadence |
| WHOOP | Strain, recovery score, HRV, respiratory rate, sleep |
| Oura Ring | Sleep stages, HRV, readiness, temperature, SpO2 |
| Apple Watch | Sleep, heart rate, VO2max estimate, running power |
| COROS | Training load, threshold pace, sleep, HRV, running dynamics |
| Polar | Running index, training load, recovery status, sleep |

## Optional: Race and Route Data

When additional data is connected through Betterness, Marathon Operator deepens its intelligence:
- **Strava / TrainingPeaks** — historical run data, pace trends, elevation profiles
- **Lab biomarkers** — ferritin (iron stores), vitamin D, testosterone, cortisol, CRP (inflammation)
- **Weather APIs** — race-day temperature, humidity, and wind for fueling adjustments
- **Course maps** — elevation profiles for pacing strategy and route rehearsal
- **Body composition** — race weight tracking for performance estimation

---

## Design Principles

1. **Phase-first, not metric-first.** Every insight is framed by where you are in your training cycle.
2. **Action over observation.** Every data point answers: "So what do I do today?"
3. **Periodization is the structure.** Base, build, peak, taper, race week — the phases drive everything.
4. **Personal, not generic.** Your paces, your recovery patterns, your fueling needs — not a cookie-cutter plan.
5. **Calm coaching, not hype.** Marathon training is months of discipline. The voice matches the distance.

---

## Part of BetterClaw OS

Marathon Operator is a [BetterClaw OS](https://github.com/Betterness/betterness-mcp/tree/main/starters/betterclaw-os) package — the Betterness-powered health workspace system for OpenClaw.

Other BetterClaw OS packages:
- Recovery Operator
- Road Cycling Operator
- HYROX Operator
- Biohacker Lab Operator
- And more at [github.com/Betterness/betterness-mcp](https://github.com/Betterness/betterness-mcp)

---

*Powered by Betterness*
