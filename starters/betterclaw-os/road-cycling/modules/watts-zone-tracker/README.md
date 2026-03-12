# Module: Watts & Zone Tracker

Tracks FTP trend, current power zones, zone distribution across recent rides, and W/kg progression.

## When Active
Always shown in the workspace home view, below the ride readiness card.

## Data Sources
- Betterness MCP: `getActivityData` (ride power data, NP, TSS)
- Betterness Graph: FTP trend (8/12 week), zone drift detection, W/kg trajectory
- Local memory: current FTP, zones, last test date, body weight

## Output
Current FTP with trend direction, zone table, recent ride zone distribution vs plan, and W/kg. Flags when zones may need updating.
