# Module: Readiness Gate

Determines whether today is a push day, moderate day, or rest day based on recovery status and training context.

## When Active
Shown on training days or when the user asks "should I train today?"

## Data Sources
- Recovery verdict (green/amber/red)
- Betterness MCP: `getWearableData` (training load, strain)
- Betterness Graph: training patterns, recovery response curves

## Output
Clear train/moderate/rest recommendation with one-sentence reasoning.
