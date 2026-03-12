# Module: Recovery Gate

Determines whether today's planned intensity session should proceed, be modified, or be replaced with endurance or rest.

## When Active
Shown on days with threshold, VO2max, or race-effort sessions planned.

## Data Sources
- Recovery verdict from ride-readiness skill (green/amber/red)
- Betterness MCP: `getWearableData` (HRV, recovery score, sleep)
- Betterness Graph: recovery response curves after similar training loads, multi-day fatigue accumulation patterns

## Output
Clear go/modify/rest decision with one-sentence reasoning. When modifying, specifies the alternative (e.g., "Swap to 90 min Z2 at 175-195W" instead of "2x20 threshold").
