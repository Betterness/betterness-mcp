# Biohacker Lab

**Your biomarkers deserve an operating system.**

Powered by [Betterness Graph](https://betterness.ai) and [Betterness MCP](https://github.com/Betterness/betterness-mcp).

---

## What It Does

Biohacker Lab turns your lab results, supplements, and wearable data into a unified optimization system:

- **Biomarker review** — ranked "what changed" and "what matters" after every panel
- **Retest planning** — when to retest what, based on staleness, velocity, and protocol timing
- **Protocol tracking** — current interventions mapped to the biomarkers they target
- **Supplement stack** — full inventory with dosing, timing, quality validation, and biomarker correlation
- **Biological age trend** — PhenoAge tracked across draws with per-biomarker contribution breakdown
- **Lab store** — browse, compare, and order panels through Betterness MCP

## Quick Start

### 1. Set up your OpenClaw workspace

Copy this package into your OpenClaw workspace:

```bash
cp -r starters/betterclaw-os/biohacker-lab/ ~/your-workspace/
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

### 3. Upload your labs

Upload at least one lab panel through your Betterness account. The more draws you have, the better the trend analysis.

### 4. Start

Open your workspace and ask: **"What changed on my last panel?"**

Biohacker Lab handles the rest.

---

## Package Structure

```
biohacker-lab/
  AGENTS.md           # Agent behavior and specialist activation
  SOUL.md             # Voice, tone, and communication style
  IDENTITY.md         # Who this is for and what makes it different
  MEMORY.md           # Local memory + Betterness Graph strategy
  WORKSPACE.md        # Home view, modules, and interaction model
  HEARTBEAT.md        # Morning context, weekly summaries, retest reminders
  PLANNING-MODE.md    # Deep reasoning for complex biomarker questions
  ANTI-PATTERNS.md    # What this package must never become
  README.md           # This file
  skills/
    biomarker-interpretation.md   # Panel interpretation with personal context
    retest-decision.md            # Retest timing and priority decisions
  modules/
    biomarker-review/         # Latest panel analysis with trend context
    retest-planner/           # Staleness tracking and retest scheduling
    protocol-tracker/         # Active interventions and target mapping
    supplement-stack/         # Full stack inventory with quality validation
    lab-store/                # Panel browsing and ordering
    biological-age-trend/     # PhenoAge tracking across draws
    product-quality-checker/  # Supplement brand and quality validation
```

---

## Primary Data Sources

| Source | What It Provides |
|--------|-----------------|
| Lab panels (via Betterness) | Biomarker values, trends, velocity, draw dates |
| Betterness Bio Age | PhenoAge from clinical biomarkers (albumin, creatinine, glucose, CRP, lymphocyte%, MCV, RDW, ALP, WBC) |
| Oura Ring | Sleep, HRV, readiness, temperature — recovery context for biomarker interpretation |
| WHOOP | Recovery score, strain, HRV — training load context |
| CGM (Dexcom, Levels) | Real-time glucose — metabolic context between draws |
| Supplement tracking | Stack inventory, dosing, timing, brands |

## Optional: Wearable Context

When wearable data is connected through Betterness, Biohacker Lab layers physiological context into biomarker reasoning:
- Sleep architecture and HRV trends (recovery state)
- Training load and strain (metabolic demand)
- Body composition trends (from Withings, InBody)
- Glucose variability (from CGM)
- Temperature deviations (early illness detection)

---

## Design Principles

1. **Trajectory over snapshot.** One draw is a data point. Three draws is a direction. Interpret accordingly.
2. **Protocol-aware.** Before interpreting a result, consider what intervention is active and when it started.
3. **Clinically relevant, not statistically interesting.** A 2-point change in vitamin D is noise. A 30-point change is signal.
4. **Action-oriented.** Every review ends with what to do — retest, adjust, add, remove, or hold.
5. **Respect the experimenter.** The user is running a serious N-of-1 project. Take it as seriously as they do.

---

## Part of BetterClaw OS

Biohacker Lab is a [BetterClaw OS](https://github.com/Betterness/betterness-mcp/tree/main/starters/betterclaw-os) package — the Betterness-powered health workspace system for OpenClaw.

Other BetterClaw OS packages:
- Recovery
- Marathon
- Road Cycling
- And more at [github.com/Betterness/betterness-mcp](https://github.com/Betterness/betterness-mcp)

---

*Powered by Betterness*
