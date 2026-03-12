# Barry's

**Your studio membership, supercharged.**

Powered by [Betterness Graph](https://betterness.ai) and [Betterness MCP](https://github.com/Betterness/betterness-mcp).

---

## What It Does

Barry's wraps around your boutique fitness experience — what happens before and after class is where the real gains live:

- **Class-day readiness** — should you go hard today, dial it to 80%, or skip and recover?
- **Post-workout recovery** — hydration, protein timing, cooldown plan based on how your body responded
- **Nearby nutrition** — healthy food options near your studio via maps, ready when you walk out
- **Weekly cadence** — are you going too often? Not enough? Finding the right rhythm
- **Intensity modulation** — matching class intensity to your recovery state across the week
- **Studio habit tracker** — attendance patterns, streaks, and the consistency that actually drives results

## Quick Start

### 1. Set up your OpenClaw workspace

Copy this package into your OpenClaw workspace:

```bash
cp -r starters/betterclaw-os/barrys-studio/ ~/your-workspace/
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
- WHOOP
- Oura Ring
- Apple Watch
- Garmin
- Withings (for body composition)

### 4. Start

Open your workspace and ask: **"I have class today — am I ready?"**

Barry's handles the rest.

---

## Package Structure

```
barrys-studio/
  AGENTS.md           # Agent behavior and specialist activation
  SOUL.md             # Voice, tone, and communication style
  IDENTITY.md         # Who this is for and what makes it different
  MEMORY.md           # Local memory + Betterness Graph strategy
  WORKSPACE.md        # Home view, modules, and interaction model
  HEARTBEAT.md        # Pre-class, post-class, and weekly automated loops
  PLANNING-MODE.md    # Deep reasoning for training balance questions
  ANTI-PATTERNS.md    # What this package must never become
  README.md           # This file
  skills/
    class-readiness.md    # Pre-class readiness assessment
    post-class-plan.md    # Post-workout recovery and nutrition plan
  modules/
    class-day-readiness/      # Go hard / dial back / skip decision
    post-workout-recovery/    # Recovery plan after class
    nearby-nutrition/         # Healthy food near your studio via maps
    weekly-cadence-tracker/   # Attendance rhythm and balance
    intensity-modulator/      # Match class effort to recovery state
    studio-habit-tracker/     # Streaks, consistency, attendance patterns
```

---

## Supported Devices

| Device | What It Provides |
|--------|-----------------|
| WHOOP | Recovery score, strain, HRV, sleep quality |
| Oura Ring | Sleep stages, HRV, readiness, temperature |
| Apple Watch | Heart rate, activity, sleep, workout detection |
| Garmin | Body Battery, HRV, stress, training load |
| Withings | Body composition, weight trends |

## Optional: Lab Biomarkers

When lab data is connected through Betterness, Barry's layers biomarker context into readiness reasoning:
- Cortisol, DHEA-S (stress axis — are you overtrained?)
- CRP, ferritin (inflammation — is your body recovering between sessions?)
- Testosterone, free T (anabolic capacity)
- Vitamin D, magnesium (performance cofactors)

---

## Design Principles

1. **Wrap around the studio, don't replace it.** The class is the experience. We make everything around it smarter.
2. **Before and after, not during.** Readiness before you walk in. Recovery after you walk out.
3. **Consistency over intensity.** The best training plan is the one you actually maintain.
4. **Action at the door.** Every insight is useful in the moment — walking in, walking out, planning the week.
5. **Warm authority.** Like a coach at the front desk who checked your recovery data before you arrived.

---

## Part of BetterClaw OS

Barry's is a [BetterClaw OS](https://github.com/Betterness/betterness-mcp/tree/main/starters/betterclaw-os) package — the Betterness-powered health workspace system for OpenClaw.

Other BetterClaw OS packages:
- Recovery
- Marathon
- Biohacker Lab
- And more at [github.com/Betterness/betterness-mcp](https://github.com/Betterness/betterness-mcp)

---

*Powered by Betterness*
