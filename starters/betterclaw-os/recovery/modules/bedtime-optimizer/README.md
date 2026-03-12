# Module: Bedtime Optimizer

Recommends optimal wind-down and lights-out times based on circadian patterns and next-day demands.

## When Active
Shown in evening hours or when sleep debt is accumulating.

## Data Sources
- Betterness MCP: `getWearableData` (sleep timing patterns)
- Betterness Graph: circadian rhythm model, sleep debt tracking, next-day schedule awareness
- Local memory: user's target wake time, schedule preferences

## Output
Specific bedtime recommendation with wind-down timing and any relevant warnings (e.g., late caffeine, screen exposure).
