# Connecting Betterness MCP to Clawbot / OpenClaw

Clawbot is a persistent AI workspace built on [OpenClaw](https://openclaw.ai). Unlike chat-based interfaces, Clawbot provides a mission-control environment where your health data, tools, and workflows live across sessions.

## Recommended: BetterClaw OS Install

The fastest way to get started with Betterness on OpenClaw is the one-command installer:

```bash
claw workspace install betterness/recovery
```

This authenticates, pulls your health data, personalizes your workspace, and starts the daily heartbeat — all automatically. See the [BetterClaw OS docs](../../starters/betterclaw-os/START-HERE.md) for details.

The sections below cover manual MCP setup for users who want to build custom workspaces from scratch.

---

## What Clawbot Provides

- **Persistent workspace**: Your health context survives across sessions. No re-explaining your goals each time.
- **Multi-tool orchestration**: Clawbot can call multiple MCP tools in sequence to build complex health reports.
- **Scheduled execution**: Set up recurring health briefs, lab reminders, and readiness checks.
- **Skill composition**: Load Betterness skills and persona overlays to customize your health agent's behavior.
- **Mission structure**: Organize health goals into missions with progress tracking.

## Prerequisites

1. **Betterness account** at [betterness.ai](https://betterness.ai)
2. **MCP API key** — get one at [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys), or via the CLI:
   ```bash
   npm install -g @betterness/cli
   betterness auth login
   ```
3. **Clawbot account** at [openclaw.ai](https://openclaw.ai)

## Manual MCP Setup

In Clawbot's MCP connection settings, configure:

| Field | Value |
|-------|-------|
| **Endpoint** | `https://api.betterness.ai/mcp` |
| **Transport** | Streamable HTTP |
| **Authentication** | Bearer Token |
| **Token** | Your Betterness API key (`bk_*`) |

### Steps

1. Open Clawbot and navigate to **Settings > MCP Servers**
2. Click **Add Server**
3. Enter the connection details from the table above
4. Click **Test Connection** to verify
5. Save the configuration

## Workspace Patterns

### Pattern 1: BetterClaw OS Package (Recommended)

Use the pre-built workspace packages:

```bash
claw workspace install betterness/recovery    # Sleep, stress, recovery
claw workspace install betterness/marathon     # Race training (coming soon)
claw workspace install betterness/biohacker-lab # Labs, protocols (coming soon)
```

Each package includes workspace files, skills, modules, heartbeat configuration, and the magic moment installer.

### Pattern 2: Mission Control (Custom)

For users who want full control, use the mission control starter:

```
betterness-workspace/
├── missions/
│   ├── daily-brief.md
│   ├── lab-tracking.md
│   └── sleep-optimization.md
├── skills/
│   └── active-skills.json
├── dashboards/
│   ├── vitals.md
│   ├── biomarkers.md
│   └── readiness.md
└── logs/
    └── health-journal.md
```

See `starters/openclaw-mission-control/` for the full template.

### Pattern 3: Private Clinic

For concierge practices and longevity clinics managing multiple patients.

**Skills to load:** biomarker-trend-reviewer, lab-gap-detector, pre-visit-summarizer, population-health-scanner

**Missions:**
- Pre-visit patient summaries (triggered before appointments)
- Population biomarker dashboard (daily refresh)
- Lab gap detection for all patients (weekly)
- Critical value alerts (real-time)

## Smoke Tests

After setup, verify with these prompts:

| Test | Prompt | Expected |
|------|--------|----------|
| Device check | "List all my connected health devices" | Returns linked wearables |
| Data pull | "Show me last night's sleep data with stage breakdowns" | Sleep duration, stages, quality |
| Multi-tool | "Give me a full health readiness assessment" | Synthesized readiness score |
| Lab integration | "What biomarkers am I missing?" | Identifies gaps, recommends panels |

## Tips

- **Pin your most-used skills** to the workspace sidebar for quick access
- **Use BetterClaw OS packages** as starting points, then customize
- **Layer persona overlays** to shift the agent's reasoning style without changing underlying skills
- **Review the health journal** weekly — Clawbot logs insights that are easy to miss in real-time
