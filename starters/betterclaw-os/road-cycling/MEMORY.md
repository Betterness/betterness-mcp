# Road Cycling Operator — Memory

## Memory Strategy

Road Cycling Operator uses a two-layer memory model: local workspace memory for ride-by-ride continuity, and Betterness Graph for longitudinal power progression and cross-domain cycling intelligence.

---

## Layer 1: Local Workspace Memory

Stored in the workspace `memory/` directory as markdown files.

### What to store locally

- **Today's ride plan** — target watts, zones, duration, route, and fueling
- **Weekly training structure** — which days are endurance, tempo, threshold, VO2, recovery spin, rest
- **Current FTP** — most recent tested or estimated FTP and the date it was set
- **Power zones** — the 7-zone table derived from current FTP
- **User preferences** — preferred ride times, favorite routes, group ride days, indoor trainer availability
- **Equipment state** — current chain distance, tire mileage, last service date, bike fit date
- **Recent rides** — last 3-5 ride summaries (duration, NP, TSS, route) for weekly load tracking
- **Race calendar** — target events with dates and priority level (A/B/C)

### What NOT to store locally

- Raw power files or GPS tracks (live in Garmin / Betterness MCP)
- Full biomarker panels (live in Betterness)
- Historical FTP trend computation (computed by Betterness Graph)
- Population power comparisons or benchmark data (lives in knowledge layer)
- Weather data (fetched fresh each ride)

### Local memory file pattern

```
memory/
  YYYY-MM-DD.md       # Daily ride log (session type, watts, route, notes)
  training-week.md    # Current week's structure and targets
  power-profile.md    # FTP, zones, W/kg, last test date
  equipment.md        # Bike, chain, tires, service log
  routes.md           # Favorite routes with notes
  race-calendar.md    # Target events and priority
  preferences.md      # Ride times, group rides, indoor setup
```

---

## Layer 2: Betterness Graph

Managed by Betterness. Not stored in the workspace. Requested through Betterness MCP context.

### What to request from Betterness Graph

- **FTP trend** — 12-week and season-long FTP progression curve, plateau detection, predicted trajectory
- **Power zone drift** — whether the rider's actual zone distribution in rides matches prescribed zones (zone creep detection)
- **Cross-domain patterns** — how sleep quality, recovery, body weight, and training volume affect power output for this specific rider
- **Seasonal patterns** — performance differences by season, daylight hours, temperature, base vs race season
- **Fueling effectiveness** — correlation between carbohydrate intake and ride performance for this rider
- **Recovery response curves** — how quickly power normalizes after high-TSS days or training blocks
- **Equipment degradation** — predicted chain wear, tire life, and service intervals based on distance and conditions
- **Route performance** — power and HR trends on repeated routes (e.g., "your Latigo Canyon time is improving")
- **W/kg trajectory** — power-to-weight trend from combined power and body composition data

### What Betterness Graph enables that local memory cannot

- Detecting that FTP has effectively increased before the rider does a formal test
- Knowing that this rider's threshold power drops 3-5% after nights with less than 6 hours of sleep
- Correlating Saturday group ride performance with Friday sleep quality and Thursday training load
- Identifying that chain replacement at 3,000 miles instead of 4,000 saves cassette wear for this rider
- Projecting W/kg improvement if the rider maintains current trajectory for 8 more weeks

---

## Memory Hygiene Rules

1. **Do not re-derive what Betterness Graph already knows.** If the graph has the FTP trend, use it — do not recompute from raw ride files.
2. **Do not store redundant copies of data.** Power files live in Garmin / Betterness. Do not cache them in workspace memory.
3. **Keep the power profile current.** Update FTP and zones whenever a test or significant estimation event occurs. Stale zones lead to bad prescriptions.
4. **Equipment logs are cumulative.** Chain and tire distance should only increase. Reset on replacement, noting the replacement date.
5. **Ask Betterness Graph before long analysis chains.** If the answer requires comparing 8 weeks of ride data, the graph already has the pattern. Do not force the model to reason over raw history.
6. **Weekly structure is durable, daily plans are ephemeral.** The training week template persists; individual ride plans age out after execution.
