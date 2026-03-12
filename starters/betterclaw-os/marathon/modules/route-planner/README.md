# Module: Route Planner

Plans run routes with distance confirmation, elevation profile, and practical logistics like water stops and terrain notes.

## When Active

Shown when the runner requests a route for an upcoming run, when exploring a new area, or when race course analysis is needed. Not auto-shown daily — activated on demand or when the long run planner needs a route.

## Data Sources

- Betterness MCP: `getWearableData` (GPS data from previous runs, preferred running areas)
- Betterness Graph: route history, elevation tolerance, pace-to-terrain correlations, preferred surfaces
- Local memory: home address or typical starting point, known routes, terrain preferences (road vs trail vs track)
- External: maps integration for route generation, elevation data, weather conditions

## What It Plans

- **Distance-confirmed route** — verified mileage matching the training plan requirement
- **Elevation profile** — total gain/loss, major hills, flat sections
- **Terrain type** — road, trail, mixed, track
- **Water and fuel points** — public water fountains, stores, or points to stash a bottle
- **Safety notes** — sidewalk availability, traffic crossings, lighting (for early/late runs)
- **Out-and-back vs loop** — format recommendation based on distance and logistics

## Output

### Example — long run route

```
Route | 18-mile Long Run — Saturday

Type: Out-and-back on lakefront path
Start: Home (usual starting point)
Distance: 18.1 miles (verified)
Elevation: +180 ft / -180 ft (essentially flat)

Water: Fountains at mile 3.2, 6.5, 9.0 (turnaround)
Surface: Paved multi-use path, good condition
Traffic: Minimal — separated path for 16 of 18 miles

Notes: North section (miles 7-9) is exposed with no shade.
If Saturday is warm, start early or carry extra water for
that stretch.
```

### Example — race course preview

```
Course Preview | Chicago Marathon

Distance: 26.2 miles (certified)
Elevation: +260 ft total — mostly flat with gentle rollers
Surface: Road, fully closed to traffic

Key sections:
  Miles 1-5: Downtown, fast start energy — stay patient
  Miles 8-13: South side, flat and open — settle into pace
  Miles 14-18: Pilsen to Chinatown — slight rollers
  Miles 19-21: Back north — this is where it gets hard
  Miles 22-26: Near north side — crowd support picks up
  Mile 26: Turn onto Michigan Ave — you can see the finish

Aid stations every mile. Gatorade at even miles, water at all.
Your gel schedule maps to: mile 6, 12, 18, 22 (between stations).
```

### Example — hill training route

```
Route | Hill Repeats — Wednesday

Location: Prospect Hill, 0.3 mi from home
Hill specs: 0.25 mi, 6% grade, paved
Session: 6x hill repeats. Jog down recovery.

Warm-up route: Easy 1 mile from home to hill base.
Cool-down: Reverse the warm-up, easy pace.
Total distance: ~5 miles including warm-up/cool-down.

Surface: Paved residential road, low traffic before 7 AM.
```

## Rules

- Distance must be confirmed — "approximately 18 miles" is not acceptable for a training plan
- Elevation profile is always included, even if flat (runners want to know)
- Water access is noted for any route over 8 miles
- Terrain and surface type are explicit — trail runners and road runners plan differently
- Race course previews include pacing strategy notes tied to course features
- Do not plan routes through unsafe areas or high-traffic roads without sidewalks
- Keep route descriptions under 100 words for training runs, more for race course previews
