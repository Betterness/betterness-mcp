# Recovery Operator — Workspace

## Home View

The Recovery Operator workspace opens to a single "today" view. Not a dashboard. Not tabs. One cohesive surface that answers the morning question: **How did I recover, and what should I do today?**

### The Recovery Card

The first thing the user sees is a recovery verdict card:

```
┌─────────────────────────────────────────┐
│  🟢  Recovery Strong                    │
│                                         │
│  HRV trending up (3rd day). Deep sleep  │
│  above baseline. Good window for        │
│  intensity.                             │
│                                         │
│  → Train hard today                     │
│  → Wind down by 10:30 tonight           │
└─────────────────────────────────────────┘
```

Verdict states:
- **Green** — recovery strong, intensity available
- **Amber** — recovery moderate, adjust intensity or protect sleep tonight
- **Red** — recovery low, rest day recommended

The verdict is always one sentence on what happened and one sentence on what to do.

### Below the Verdict

After the recovery card, the workspace shows contextual modules based on what is relevant today:

1. **Sleep Architecture** (always shown) — deep sleep, REM, awakenings, time in bed vs actual sleep
2. **HRV Trend** (always shown) — 7-day directional trend with personal baseline reference
3. **Readiness Gate** (shown on training days) — should you train, and at what intensity?
4. **Bedtime Optimizer** (shown in evening) — recommended wind-down and lights-out time
5. **Rest Day Planner** (shown on red/amber days) — restorative activity suggestions

### What Is NOT on the Home View

- A grid of 6+ metric tiles with no interpretation
- A navigation bar with 5 tabs
- A "status report" that reads like a log file
- A multi-agent visualization
- A settings page as the first experience

---

## Workspace Composition Rules

### Always visible
- Recovery verdict card
- Sleep architecture summary
- HRV trend

### Conditionally visible
- Readiness gate — when training data or schedule exists
- Bedtime optimizer — in evening hours or when sleep debt is accumulating
- Rest day planner — on amber/red recovery days
- Biomarker overlay — when lab data is connected and relevant
- Supplement timing — when user has a recovery supplement stack

### Never auto-shown
- Raw data exports
- Historical data tables
- Device configuration UI
- Multi-agent routing visualization

---

## Interaction Model

The user interacts with Recovery Operator primarily through natural conversation, not through clicking dashboard widgets.

### Common interactions

- **Morning check-in:** "How did I sleep?" → verdict + sleep summary
- **Training decision:** "Should I train today?" → readiness gate with reasoning
- **Evening wind-down:** "When should I go to bed?" → bedtime recommendation
- **Trend question:** "How's my recovery this week?" → 7-day trend with context
- **Deep dive:** "Why is my HRV low?" → cross-domain analysis via Betterness Graph
- **Action request:** "Find me a recovery studio nearby" → provider search via Betterness MCP

### Conversation principles

1. Answer the question first, then offer to go deeper
2. Always include an action — what to do, not just what happened
3. Use the verdict framework (green/amber/red) consistently
4. Reference personal baselines, not population averages
5. Keep responses concise — expand only when asked

---

## OpenClaw-Native Integration

Recovery Operator uses OpenClaw workspace primitives:

- **Workspace files** — AGENTS.md, SOUL.md, etc. define behavior
- **Skills** — sleep-analysis and recovery-verdict as workspace skills
- **Heartbeat** — morning and evening automated check-ins
- **Cron** — weekly trend summaries
- **Channels** — recovery context persists across conversation sessions
- **Memory** — daily logs in `memory/YYYY-MM-DD.md`

The workspace should feel like OpenClaw made dramatically better for recovery — not a foreign framework attached to it.
