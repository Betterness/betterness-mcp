# Module: Weekly Load Distribution

Tracks TSS distribution across the week and compares actual zone time to the planned training structure.

## When Active
Always shown in the workspace home view, below the watts & zone tracker.

## Data Sources
- Betterness MCP: `getActivityData` (daily TSS, ride durations)
- Betterness Graph: weekly TSS targets, zone distribution patterns, fatigue accumulation
- Local memory: training week template (which days are endurance/tempo/threshold/VO2/rest)

## Output
Weekly TSS total vs target, daily breakdown, and zone distribution pie (endurance vs tempo vs threshold vs VO2 vs rest). Flags under- or over-training relative to the plan.
