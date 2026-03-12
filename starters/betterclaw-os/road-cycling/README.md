# Road Cycling

**Every watt, every ride, every decision.**

A BetterClaw OS package for road cyclists who train with power and want every ride decision informed by their actual data.

Powered by [Betterness Graph](https://betterness.ai) and [Betterness MCP](https://github.com/Betterness/betterness-mcp).

---

## What It Does

Road Cycling Operator turns your power data, recovery signals, and route context into daily ride intelligence:

- **Ride readiness** — green / amber / red with today's session, watts, and route
- **Power tracking** — FTP trend, zone distribution, W/kg progression
- **Route planning** — maps, elevation, weather, wind direction, fueling stops
- **Fueling calculator** — carbohydrate and hydration targets scaled to duration, intensity, and temperature
- **Recovery gating** — should you push threshold today, or swap to endurance?
- **Weekly load** — TSS distribution across endurance, tempo, threshold, VO2, and rest
- **Equipment tracking** — chain wear, tire mileage, service intervals, bike fit reminders
- **Lab overlay** — biomarker context when connected (ferritin, cortisol, testosterone)

## Quick Start

### 1. Set up your OpenClaw workspace

Copy this package into your OpenClaw workspace:

```bash
cp -r starters/betterclaw-os/road-cycling/ ~/your-workspace/
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

Link your cycling devices through your Betterness account:
- Garmin Edge or Forerunner (power, routes, training load)
- WHOOP (recovery, HRV, strain)
- Oura Ring (sleep, readiness)
- Withings (body composition for W/kg)

### 4. Set your FTP

Tell the workspace your current FTP:

> "My FTP is 271 watts, tested last week."

Road Cycling Operator will compute your zones and start building context.

### 5. Ride

Ask: **"What's my ride today?"**

Road Cycling Operator handles the rest.

---

## Package Structure

```
road-cycling/
  AGENTS.md           # Agent behavior and specialist activation
  SOUL.md             # Voice, tone, and communication style
  IDENTITY.md         # Who this is for and what makes it different
  MEMORY.md           # Local memory + Betterness Graph strategy
  WORKSPACE.md        # Home view, modules, and interaction model
  HEARTBEAT.md        # Morning, pre-ride, post-ride, weekly, maintenance loops
  PLANNING-MODE.md    # Deep reasoning for training plans and power questions
  ANTI-PATTERNS.md    # What this package must never become
  README.md           # This file
  skills/
    ride-readiness.md     # Daily readiness scoring and ride prescription
    power-analysis.md     # FTP tracking, zone management, and power trends
    route-planner.md      # Route building with maps, elevation, and weather
  modules/
    ride-planner/         # Daily ride prescription with watts and route
    watts-zone-tracker/   # FTP trend, zones, and power distribution
    route-builder/        # Maps, elevation, weather, and segment targets
    fueling-calculator/   # Carbohydrate and hydration planning
    recovery-gate/        # Intensity gating based on recovery status
    weekly-load/          # TSS distribution and training balance
    equipment-tracker/    # Chain, tires, fit, and service intervals
```

---

## Supported Devices

| Device | What It Provides |
|--------|-----------------|
| Garmin Edge / Forerunner | Power, cadence, HR, GPS, training load, VO2max |
| WHOOP | HRV, recovery score, strain, respiratory rate |
| Oura Ring | Sleep stages, readiness, temperature, HRV |
| Withings | Body composition, weight (W/kg tracking) |
| Power meter (any) | Watt data via head unit |
| Apple Watch | Heart rate, sleep (if no dedicated device) |

## Optional: Lab Biomarkers

When lab data is connected through Betterness, Road Cycling Operator layers biomarker context into training intelligence:
- Ferritin, iron panel (endurance athletes are chronically iron-depleted)
- Cortisol (overtraining and recovery stress)
- Testosterone, free T (anabolic recovery)
- CRP (inflammation from high training loads)
- Vitamin D, magnesium (muscle function and recovery)

---

## Design Principles

1. **Power is primary.** Every ride prescription includes watts and zones. Never "ride hard" without numbers.
2. **Rides happen outside.** Route, weather, wind, and elevation are part of every plan.
3. **FTP is alive.** It changes. The workspace tracks it and adjusts zones automatically.
4. **Recovery gates intensity.** Hard sessions only proceed when recovery supports them.
5. **The bike is part of the system.** Equipment wear matters and is tracked.
6. **Specific, not motivational.** "2x20 at 265-275W on Mandeville Canyon" — not "great ride today!"

---

## Part of BetterClaw OS

Road Cycling Operator is a [BetterClaw OS](https://github.com/Betterness/betterness-mcp/tree/main/starters/betterclaw-os) package — the Betterness-powered health workspace system for OpenClaw.

Other BetterClaw OS packages:
- Recovery Operator
- Marathon Operator
- HYROX Operator
- Biohacker Lab Operator
- And more at [github.com/Betterness/betterness-mcp](https://github.com/Betterness/betterness-mcp)

---

*Powered by Betterness*
