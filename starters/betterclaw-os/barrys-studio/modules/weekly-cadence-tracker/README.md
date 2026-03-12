# Module: Weekly Cadence Tracker

## Purpose

Tracks the user's weekly class attendance pattern and ensures sustainable training cadence. Monitors rest-to-training ratio, flags overtraining risks, and confirms the week is on track.

## When It Activates

- Weekly summary heartbeat (Sunday evening or Monday morning)
- User asks "How's my week looking?" or "Am I on track?"
- Class-Day Readiness module queries consecutive training days
- User books a new class that would create 4+ consecutive days

## Data Sources

| Source | What It Provides |
|--------|-----------------|
| Local memory | Class schedule, attendance history, planned classes |
| Betterness Graph | Recovery trends across the week, HRV trajectory |
| Local memory | User's target cadence (e.g., 4x/week) |

## Core Tracking

### Weekly View
- Classes completed this week
- Classes remaining (booked)
- Rest days taken vs needed
- Consecutive training days (current streak)

### Cadence Health
Compare actual attendance against the user's target:
- **On track** — attendance matches target, rest days are distributed well
- **Light week** — fewer classes than target, note it without judgment
- **Heavy week** — more classes than target or insufficient rest days, flag recovery concern
- **Stacking risk** — 3+ consecutive days with another booked tomorrow

### Trend Context
Via Betterness Graph, show 4-week rolling average:
- Average classes per week
- Average rest days between classes
- Recovery quality trend (are they recovering well at this cadence?)

## Output: Weekly Summary

Delivered via heartbeat on the configured summary day:

```
This week: 3 of 4 classes done (Floor & Tread Mon, Lift Wed, Run Thu).
Friday Lift closes the week. Rest days: Tue, Sun.

4-week average: 3.5 classes/week. Recovery holding steady —
HRV trend flat, which is good at this volume.

Next week: Consider spacing Mon-Wed-Fri if you're booking 3 again.
Back-to-back Wed-Thu worked but your Thursday HRV was 8% below baseline.
```

## What This Module Never Does

- Guilt the user for a light week — life happens
- Push the user to add more classes if they're recovering well at their current cadence
- Ignore the difference between class types (a Lift + Run back-to-back is different from two Floor & Tread sessions)
- Show attendance data without recovery context
- Track streaks or gamify attendance — this is not a fitness app badge system
