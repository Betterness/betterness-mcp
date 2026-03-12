# Barry's / Studio Operator — Memory

## Memory Strategy

Studio Operator uses a two-layer memory model: local workspace memory for session continuity and class-day state, and Betterness Graph for longitudinal studio habit intelligence.

---

## Layer 1: Local Workspace Memory

Stored in the workspace `memory/` directory as markdown files.

### What to store locally

- **Today's readiness call** — green/amber/red and the intensity recommendation
- **Class schedule** — upcoming classes this week, preferred days and times
- **Studio preferences** — preferred studio location, class types, favorite instructors
- **Post-class notes** — how the user felt after class, what they ate, recovery actions taken
- **Weekly cadence target** — how many sessions per week the user is aiming for
- **Nearby food preferences** — dietary restrictions, favorite spots, budget range

### What NOT to store locally

- Raw wearable data (lives in Betterness MCP)
- Historical body composition data (lives in Betterness)
- Long-term attendance patterns (computed by Betterness Graph)
- Recovery response curves (computed by Betterness Graph)

### Local memory file pattern

```
memory/
  YYYY-MM-DD.md       # Class day log (readiness call, class taken, post-class notes)
  schedule.md         # This week's class schedule and plan
  preferences.md      # Studio, food, and training preferences
  cadence.md          # Weekly cadence target and current streak
```

---

## Layer 2: Betterness Graph

Managed by Betterness. Not stored in the workspace. Requested through Betterness MCP context.

### What to request from Betterness Graph

- **Personal recovery baselines** — HRV range, typical deep sleep, resting heart rate corridor
- **Recovery response curves** — how quickly this user bounces back from a HIIT session vs rest day
- **Attendance patterns** — weekly cadence over time, consistency streaks, dropout risks
- **Optimal cadence** — the weekly class frequency that maximizes this user's recovery and results
- **Body composition trajectory** — how lean mass, body fat, and weight are trending with the studio habit
- **Cross-domain signals** — how sleep, nutrition timing, and class frequency interact for this user

### What Betterness Graph enables that local memory cannot

- Knowing that this user recovers from Barry's in 36 hours but needs 48 hours after a double
- Detecting that attendance drops when the user trains 5x/week (overreach → dropout pattern)
- Connecting body composition improvements to the specific cadence that produced them
- Identifying that post-class nutrition quality predicts next-day recovery better than sleep alone
- Surfacing that this user's best class performances happen on Tuesday and Thursday (2 rest days prior)

---

## Memory Hygiene Rules

1. **Do not re-derive what Betterness Graph already knows.** If the graph has attendance patterns and recovery curves, use them.
2. **Class day logs are ephemeral. Preferences are durable.** Keep preferences updated. Let daily logs age out naturally.
3. **The schedule is a living document.** Update it at the start of each week. Adjust when plans change.
4. **Summarize, don't accumulate.** If the user has been going 3x/week for 2 months, one line captures it. Do not maintain 60 daily logs.
5. **Ask Betterness Graph before long reasoning chains.** If the question involves comparing weeks of data, the graph has it. Do not force the model to reason over daily logs.
