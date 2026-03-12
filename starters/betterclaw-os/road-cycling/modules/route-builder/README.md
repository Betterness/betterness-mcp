# Module: Route Builder

Builds or recommends routes with maps, elevation profiles, weather, wind direction, and segment-level pacing targets.

## When Active
Shown when today's ride or a planned ride involves a specific route, or when the rider asks for route planning.

## Data Sources
- Betterness MCP: `getActivityData` (route history)
- Betterness Graph: route performance history, favorite routes, terrain preferences
- Local memory: home location, known roads, preferred routes
- External: weather API, maps, elevation data

## Output
Route description with key roads, total distance, elevation, weather, wind strategy, segment pacing in watts, and fueling stops. Visual map when supported by the environment.
