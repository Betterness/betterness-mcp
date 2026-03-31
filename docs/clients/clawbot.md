# Connecting Betterness MCP to Clawbot / OpenClaw

Clawbot is a persistent AI workspace built on [OpenClaw](https://openclaw.ai). Unlike chat-based interfaces, Clawbot provides a mission-control environment where your health data, tools, and workflows live across sessions. It is the recommended client for users who want always-on health intelligence.

## What Clawbot Provides

- **Persistent workspace**: Your health context survives across sessions. No re-explaining your goals each time.
- **Multi-tool orchestration**: Clawbot can call multiple MCP tools in sequence to build complex health reports.
- **Scheduled execution**: Set up recurring health briefs, lab reminders, and readiness checks.
- **Skill composition**: Load Betterness skills and persona overlays to customize your health agent's behavior.
- **Mission structure**: Organize health goals into missions with progress tracking.

## Prerequisites

1. **Betterness account** at [betterness.ai](https://betterness.ai)
2. **MCP API key** from [betterness.ai/mcp/keys](https://betterness.ai/mcp/keys)
3. **Clawbot account** at [openclaw.ai](https://openclaw.ai)

## Auth Setup

In Clawbot's MCP connection settings, configure:

| Field | Value |
|-------|-------|
| **Endpoint** | `https://api.betterness.ai/mcp` |
| **Transport** | Streamable HTTP |
| **Authentication** | Bearer Token |
| **Token** | Your Betterness API key |

### Steps

1. Open Clawbot and navigate to **Settings > MCP Servers**
2. Click **Add Server**
3. Enter the connection details from the table above
4. Click **Test Connection** to verify
5. Save the configuration

## Workspace Structure

The recommended workspace layout follows the structure in `starters/openclaw-mission-control/`. This gives you a health-focused mission control with pre-configured panels:

```
betterness-workspace/
├── missions/
│   ├── daily-brief.md          # Morning health readiness check
│   ├── lab-tracking.md         # Biomarker trend monitoring
│   └── sleep-optimization.md   # Sleep quality improvement protocol
├── skills/
│   ├── active-skills.json      # Currently loaded Betterness skills
│   └── persona-config.json     # Active persona overlay
├── dashboards/
│   ├── vitals.md               # Real-time vitals dashboard
│   ├── biomarkers.md           # Lab result trends
│   └── readiness.md            # Training readiness score
└── logs/
    └── health-journal.md       # AI-assisted health journal
```

## Install Order

Follow these 10 steps to set up a complete Betterness health workspace in Clawbot:

1. **Create workspace** — New workspace named "Betterness Health"
2. **Connect MCP** — Add the Betterness MCP server (see Auth Setup above)
3. **Verify tools** — Run `listConnectedDevices` to confirm the connection works
4. **Load core skills** — Import skills from `skills/health-data/` (sleep analysis, biomarker review, vitals monitoring)
5. **Set persona** — Choose a persona overlay (e.g., `sports-medicine-overlay` for athletes, `longevity-overlay` for biohackers)
6. **Create daily brief mission** — Set up a recurring morning health readiness check using `getSleepData`, `getVitals`, and `getActivityData`
7. **Create lab tracking mission** — Configure biomarker monitoring with alerts for out-of-range values
8. **Build dashboards** — Set up vitals, biomarkers, and readiness dashboard panels
9. **Configure notifications** — Set up Telegram or email alerts for critical health events
10. **Run initial health audit** — Execute a full health data review to establish your baseline

## Installation Patterns

### Pattern 1: Personal Health Dashboard

For individuals tracking their own health.

**Skills to load:**
- `sleep-quality-analyzer`
- `biomarker-trend-reviewer`
- `training-readiness-evaluator`
- `morning-brief-composer`

**Persona overlay:** `longevity-overlay` or `sports-medicine-overlay`

**Missions:**
- Daily morning brief (scheduled, 6:00 AM)
- Weekly biomarker review (scheduled, Sunday evening)
- On-demand training readiness checks

**Configuration:**
```json
{
  "workspace": "personal-health",
  "skills": [
    "sleep-quality-analyzer",
    "biomarker-trend-reviewer",
    "training-readiness-evaluator",
    "morning-brief-composer"
  ],
  "persona": "longevity-overlay",
  "schedules": [
    { "mission": "daily-brief", "cron": "0 6 * * *" },
    { "mission": "weekly-biomarker-review", "cron": "0 18 * * 0" }
  ]
}
```

### Pattern 2: Private Clinic

For concierge practices and longevity clinics managing multiple patients.

**Skills to load:**
- `biomarker-trend-reviewer`
- `lab-gap-detector`
- `pre-visit-summarizer`
- `population-health-scanner`

**Persona overlay:** `clinical-overlay`

**Missions:**
- Pre-visit patient summaries (triggered before appointments)
- Population biomarker dashboard (daily refresh)
- Lab gap detection for all patients (weekly)
- Critical value alerts (real-time)

**Configuration:**
```json
{
  "workspace": "clinic-ops",
  "skills": [
    "biomarker-trend-reviewer",
    "lab-gap-detector",
    "pre-visit-summarizer",
    "population-health-scanner"
  ],
  "persona": "clinical-overlay",
  "schedules": [
    { "mission": "population-dashboard", "cron": "0 5 * * *" },
    { "mission": "lab-gap-scan", "cron": "0 8 * * 1" }
  ],
  "alerts": {
    "critical-values": true,
    "channel": "telegram"
  }
}
```

### Pattern 3: Business Operator (Betterness One)

For wellness businesses using BETT-i as an operating system.

**Skills to load:**
- `morning-brief-composer`
- `biomarker-trend-reviewer`
- `content-performance-analyzer`
- `audience-health-profiler`

**Persona overlay:** `business-overlay`

**Missions:**
- Daily business + health brief (scheduled)
- Content performance tied to health topics (weekly)
- Audience health interest profiling (weekly)
- Client health milestone tracking (ongoing)

**Configuration:**
```json
{
  "workspace": "betterness-one",
  "skills": [
    "morning-brief-composer",
    "biomarker-trend-reviewer",
    "content-performance-analyzer",
    "audience-health-profiler"
  ],
  "persona": "business-overlay",
  "schedules": [
    { "mission": "daily-brief", "cron": "0 6 * * *" },
    { "mission": "content-review", "cron": "0 9 * * 1" },
    { "mission": "audience-profiling", "cron": "0 10 * * 1" }
  ]
}
```

## Smoke Tests

After completing the install, verify with these commands in your Clawbot workspace:

### 1. Device check
```
List all my connected health devices.
```
Expected: Returns your linked wearables and data sources.

### 2. Data pull
```
Show me last night's sleep data with stage breakdowns.
```
Expected: Returns sleep duration, stages (deep, REM, light, awake), and quality metrics.

### 3. Multi-tool composition
```
Give me a full health readiness assessment for today.
```
Expected: Clawbot calls `getSleepData`, `getVitals`, `getActivityData`, and `getBodyComposition`, then synthesizes a readiness score with narrative explanation.

### 4. Lab integration
```
What biomarkers am I missing data for? Suggest labs to order.
```
Expected: Calls `getUserLabRecords` and `listAvailableLabTests`, identifies gaps, and recommends specific panels.

### 5. Scheduled mission
Trigger your daily brief mission manually and confirm it executes the full skill chain and delivers results.

## Tips

- **Pin your most-used skills** to the workspace sidebar for quick access.
- **Use mission templates** from `starters/openclaw-mission-control/` as starting points, then customize.
- **Layer persona overlays** to shift the agent's reasoning style without changing the underlying skills.
- **Review the health journal** weekly — Clawbot logs insights that are easy to miss in real-time.
