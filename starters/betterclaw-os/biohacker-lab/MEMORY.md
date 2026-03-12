# Biohacker Lab — Memory

## Memory Strategy

Biohacker Lab uses a two-layer memory model: local workspace memory for session continuity and protocol state, and Betterness Graph for longitudinal biomarker intelligence and cross-domain reasoning.

---

## Layer 1: Local Workspace Memory

Stored in the workspace `memory/` directory as markdown files.

### What to store locally

- **Active protocols** — current supplements, diet interventions, lifestyle changes, with start dates and target biomarkers
- **Supplement stack** — full inventory with brands, doses, timing, and cost
- **Retest schedule** — what is due, what is overdue, what is next
- **User preferences** — preferred lab providers, budget constraints, panel preferences, communication style
- **Recent conversations** — questions asked, decisions made, protocol adjustments discussed
- **Lab ordering state** — pending orders, upcoming appointments, results awaiting review

### What NOT to store locally

- Raw biomarker values (lives in Betterness MCP via `getUserLabRecords`)
- Historical trend computations (computed by Betterness Graph)
- PhenoAge calculations (computed by Betterness via `getBiologicalAge`)
- Reference ranges or population data (lives in knowledge layer)
- Evidence-base citations (retrieved via `knowledgeSearch`)

### Local memory file pattern

```
memory/
  protocols.md        # Active interventions with start dates and targets
  supplements.md      # Full stack inventory
  retest-schedule.md  # Upcoming and overdue retests
  preferences.md      # User's lab and communication preferences
  YYYY-MM-DD.md       # Session logs (panel reviews, decisions, adjustments)
```

---

## Layer 2: Betterness Graph

Managed by Betterness. Not stored in the workspace. Requested through Betterness MCP context.

### What to request from Betterness Graph

- **Biomarker trajectories** — direction and velocity across all draws for each marker
- **PhenoAge trend** — biological age across draws with per-biomarker contribution breakdown
- **Cross-domain correlations** — how sleep, HRV, training load, glucose, or supplement changes correlate with biomarker movements for this specific user
- **Staleness map** — which biomarkers are stale, how stale, and which are due for retest based on velocity and clinical relevance
- **Protocol effectiveness** — which interventions have moved which markers, and by how much, over what timeframe
- **Pattern detection** — seasonal variations, dose-response relationships, cofactor interactions

### What Betterness Graph enables that local memory cannot

- Detecting that ferritin has been declining across three draws before the user notices
- Connecting a vitamin D improvement to the specific protocol change made 4 months ago
- Knowing that this user's hsCRP always rises in winter, so a January spike is seasonal, not alarming
- Ranking which supplements in the stack are actually correlated with biomarker improvements vs which are inert
- Calculating that the user's PhenoAge improvement is driven primarily by two markers (hsCRP and HbA1c)

---

## Memory Hygiene Rules

1. **Do not re-derive what Betterness Graph already knows.** If the graph has biomarker trajectories, use them — do not recompute from raw data.
2. **Protocols are the most important local state.** Every protocol adjustment must be logged with a date and reason. Without protocol awareness, biomarker interpretation is blind.
3. **Summarize, don't accumulate.** If a supplement has been in the stack unchanged for 6 months, a single line is sufficient. Do not maintain a daily log of "still taking magnesium."
4. **Retest schedule is a living document.** Update it after every panel review. Mark completed retests, add new ones, adjust timing based on results.
5. **Ask Betterness Graph before long reasoning chains.** If the question involves comparing markers across draws, the graph already has it. Do not force the model to reason over panel PDFs.
