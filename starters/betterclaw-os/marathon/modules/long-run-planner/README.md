# Module: Long Run Planner

Plans the next long run with distance, target pace, fueling protocol, hydration plan, and optional route.

## When Active

Shown 48 hours before the scheduled long run day. Also available on demand when the runner asks about their upcoming long run.

## Data Sources

- Betterness MCP: `getWearableData` (recent pace data, recovery status, heart rate zones)
- Betterness Graph: long run history, pace-to-effort correlations, fueling effectiveness data, recovery response after previous long runs
- Local memory: preferred long run day, fueling brand preferences, hydration habits, course familiarity

## What It Plans

- **Distance** — based on the training phase and week (e.g., 18 miles in Build Week 6)
- **Target pace** — typically marathon goal pace + 30-60 sec/mi, adjusted for terrain and conditions
- **Fueling protocol** — when to take gels (by mile marker), calorie targets, brand if known
- **Hydration plan** — water/electrolyte intake frequency based on distance and expected conditions
- **Route** — if route planner is active, includes distance-confirmed route with elevation profile
- **Recovery preview** — what recovery will look like post-run and when the next quality session is

## Output

### Example — standard long run brief

```
Long Run | Saturday — 18 miles

Pace: 8:45/mi (marathon goal + 45 sec)
Recovery: green — no reason to hold back.

Fueling:
  Mile 6: gel + water
  Mile 12: gel + electrolytes
  Mile 16: gel + water

Hydration: water every 3 miles. Electrolytes at 12 and 18.
Route: Lakefront out-and-back. Flat, 2 water fountains.

Post-run: 600 cal within 45 min. Easy day Sunday.
Next quality session: Tuesday tempo.
```

### Example — conditions adjustment

```
Long Run | Saturday — 18 miles

Pace: 8:55/mi (adjusted +10 sec for 78F forecast)
Recovery: green, but heat will tax you more than usual.

Fueling: same gel schedule, but add an extra electrolyte
serving at mile 9. Start hydrating aggressively tonight.

Consider starting 30 min earlier to beat the worst heat.
```

## Rules

- Pace is always personalized to the runner's current fitness and the phase goal
- Fueling protocol is specific: mile markers, not "every 30-45 minutes"
- Always note post-run recovery expectations and the next key session
- Adjust pace for heat (add 10-20 sec/mi per 10F above 60F), elevation, and wind
- Keep the brief under 120 words. Details available on request.
