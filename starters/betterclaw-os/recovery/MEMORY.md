# Recovery Operator — Memory

## Memory Strategy

Recovery Operator uses a two-layer memory model: local workspace memory for session continuity, and Betterness Graph for longitudinal recovery intelligence.

---

## Layer 1: Local Workspace Memory

Stored in the workspace `memory/` directory as markdown files.

### What to store locally

- **Today's verdict** — green/amber/red and the key reason
- **Active recovery plan** — what the user is doing today based on this morning's data
- **User preferences** — preferred wake time, bedtime target, training days, rest day activities
- **Recent conversations** — questions asked, decisions made, context from this session
- **Device configuration** — which wearables are connected, which data streams are active
- **Supplement stack** — what recovery-related supplements the user takes and when

### What NOT to store locally

- Raw wearable data (lives in Betterness MCP)
- Full biomarker panels (lives in Betterness)
- Historical trend computations (computed by Betterness Graph)
- Population comparisons or reference ranges (lives in knowledge layer)

### Local memory file pattern

```
memory/
  YYYY-MM-DD.md       # Daily recovery log (verdict, actions taken, notes)
  preferences.md      # User's recovery preferences and schedule
  devices.md          # Connected devices and data quality notes
  supplements.md      # Recovery supplement stack
```

---

## Layer 2: Betterness Graph

Managed by Betterness. Not stored in the workspace. Requested through Betterness MCP context.

### What to request from Betterness Graph

- **Personal baselines** — the user's normal HRV range, typical deep sleep duration, resting heart rate corridor
- **Trend signals** — 7-day and 30-day directional changes in recovery metrics
- **Cross-domain patterns** — how training load, travel, alcohol, late meals, or stress correlate with recovery outcomes for this specific user
- **Seasonal patterns** — recovery differences by season, daylight hours, temperature
- **Recovery response curves** — how quickly this user bounces back from high strain vs low sleep vs illness
- **Biomarker overlays** — when lab data exists, how cortisol/thyroid/inflammation markers relate to recovery quality

### What Betterness Graph enables that local memory cannot

- Comparing today's recovery to the user's 90-day personal trend
- Detecting that recovery has been declining for 2 weeks before the user notices
- Knowing that this user's HRV always dips on Monday after weekend training
- Connecting a sleep quality drop to a supplement change made 10 days ago
- Ranking which recovery action has historically worked best for this user

---

## Memory Hygiene Rules

1. **Do not re-derive what Betterness Graph already knows.** If the graph has the user's HRV baseline, use it — do not recompute from scratch.
2. **Do not store redundant copies of data.** Wearable data lives in Betterness. Do not cache it in workspace memory.
3. **Summarize, don't accumulate.** Daily logs should be concise. If a week of logs says the same thing, consolidate into a trend note.
4. **Preferences are durable. Verdicts are ephemeral.** Keep preferences updated. Let daily verdicts age out naturally.
5. **Ask Betterness Graph before long reasoning chains.** If the answer requires comparing multiple weeks of data, the graph already has it. Do not force the model to reason over raw history.
