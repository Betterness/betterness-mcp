# Module: Ride Planner

Generates today's ride prescription with session type, target watts, zones, duration, and route.

## When Active
Always shown in the workspace home view as the ride readiness card.

## Data Sources
- Betterness MCP: `getWearableData` (recovery, HRV), `getActivityData` (recent rides)
- Betterness Graph: FTP, power zones, weekly training structure, recovery patterns
- Local memory: training week template, preferred routes, ride schedule

## Output
Ride readiness verdict (green/amber/red) with session type, target watts and zone, duration, route, weather, and fueling. One card, one decision.
