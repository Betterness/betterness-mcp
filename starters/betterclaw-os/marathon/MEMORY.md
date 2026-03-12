# Marathon Operator — Memory

## Memory Strategy

Marathon Operator uses a two-layer memory model: local workspace memory for training continuity and session context, and Betterness Graph for longitudinal training intelligence and periodization patterns.

---

## Layer 1: Local Workspace Memory

Stored in the workspace `memory/` directory as markdown files.

### What to store locally

- **Race target** — race name, date, goal time, goal pace, course profile
- **Current training phase** — base / build / peak / taper / race week, week number, total weeks
- **This week's plan** — scheduled sessions, long run details, rest days, key workouts
- **Today's verdict** — push / moderate / rest and the key reason
- **User preferences** — preferred long run day, easy pace range, fueling brand preferences, hydration habits
- **Recent conversations** — questions asked, plan adjustments, decisions made this session
- **Device configuration** — which wearables are connected, which data streams are active
- **Race history** — previous marathon times, what went well, what went wrong

### What NOT to store locally

- Raw wearable data (lives in Betterness MCP)
- Full training load history (lives in Betterness Graph)
- Historical trend computations (computed by Betterness Graph)
- Pace zone calculations from VO2max data (computed on request)
- Population pace or recovery benchmarks (lives in knowledge layer)

### Local memory file pattern

```
memory/
  race.md             # Target race details: name, date, goal, course
  training-plan.md    # Current phase, week structure, key sessions
  YYYY-MM-DD.md       # Daily training log (session, verdict, fueling notes)
  preferences.md      # Long run day, pace preferences, fueling brands
  devices.md          # Connected devices and data quality notes
  race-history.md     # Previous race results and lessons
```

---

## Layer 2: Betterness Graph

Managed by Betterness. Not stored in the workspace. Requested through Betterness MCP context.

### What to request from Betterness Graph

- **Training load trends** — weekly volume, intensity distribution, acute:chronic workload ratio over 4-8 week windows
- **Personal baselines** — normal HRV range, typical resting HR, usual deep sleep duration, recovery response curves
- **Pace-to-recovery correlations** — how specific workout types affect this runner's next-day recovery
- **Taper response patterns** — how this runner historically responds to volume reduction (some runners recover fast, some need longer tapers)
- **Fueling effectiveness** — which race nutrition has worked for this runner at what distances and conditions
- **Seasonal patterns** — how heat, cold, altitude, or travel affect this runner's performance and recovery
- **Injury precursors** — training load spikes or recovery patterns that preceded previous injuries

### What Betterness Graph enables that local memory cannot

- Detecting that weekly volume has increased 18% faster than the training plan intended
- Knowing that this runner's HRV always drops after back-to-back quality sessions
- Recognizing that the runner's taper anxiety pattern matches their last two training cycles
- Connecting a performance plateau to iron depletion visible in lab trends
- Predicting race-day pacing based on long run splits, temperature, and elevation profile
- Ranking which recovery interventions have historically worked fastest for this runner after long runs

---

## Memory Hygiene Rules

1. **Do not re-derive what Betterness Graph already knows.** If the graph has the runner's training load trend, use it — do not recompute from daily logs.
2. **Do not store redundant copies of data.** Wearable data and run files live in Betterness. Do not cache them in workspace memory.
3. **Summarize, don't accumulate.** Weekly training summaries are more useful than seven daily logs saying the same thing. Consolidate weekly.
4. **Race details are durable. Daily verdicts are ephemeral.** Keep the race target and training plan current. Let daily verdicts age out naturally.
5. **Ask Betterness Graph before long reasoning chains.** If the answer requires comparing 6 weeks of training load progression, the graph already has it. Do not force the model to reason over raw history.
