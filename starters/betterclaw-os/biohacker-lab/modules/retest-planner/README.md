# Module: Retest Planner

Determines what to retest, when, and why — based on staleness, velocity of change, and protocol timing.

## When Active
Shown when retests are due or overdue, or when the user asks what to test next.

## Data Sources
- Local memory: retest schedule, active protocols with start dates
- Betterness Graph: biomarker staleness, velocity, protocol timelines

## Output
Prioritized retest list with reasoning. Each entry includes: marker name, last value, days since last draw, reason for retesting (staleness, velocity, protocol milestone), and recommended panel.

## Priority Framework
1. **Overdue** — past the recommended retest window
2. **Protocol milestone** — a supplement or intervention has been running long enough to show results (typically 8-12 weeks)
3. **Velocity concern** — a marker is changing fast enough to warrant earlier confirmation
4. **Routine** — standard retest cadence for stable markers (every 3-6 months)
