# Module: Studio Habit Tracker

## Purpose

Tracks the behavioral patterns that make studio training sustainable: class consistency, recovery compliance, nutrition habits, and schedule adherence. This is not a streak counter — it is a sustainability monitor.

## When It Activates

- Weekly summary heartbeat includes habit context
- User asks "Am I being consistent?" or "What's my pattern?"
- Monthly review conversations
- When recommending cadence changes

## Data Sources

| Source | What It Provides |
|--------|-----------------|
| Local memory | Class attendance, cancellations, schedule changes |
| Local memory | Post-workout nutrition compliance, recovery actions taken |
| Betterness Graph | Recovery quality trends, adaptation signals |
| Local memory | Class booking patterns, preferred times, preferred class types |

## What It Tracks

### Attendance Pattern
- Classes per week (4-week rolling average)
- Preferred days and times (e.g., "You train Mon/Wed/Fri mornings 85% of the time")
- Cancellation rate and reasons (if logged)
- Booking-to-attendance ratio

### Recovery Compliance
- How often the user follows amber/red recommendations
- Post-workout nutrition timing (did they eat within the recommended window?)
- Rest day adherence (do they actually rest on rest days?)

### Schedule Consistency
- How stable is their weekly pattern?
- Do they front-load or back-load their week?
- Are rest days consistent or random?

### Sustainability Signals
Via Betterness Graph:
- Is HRV trending up, flat, or down over 4+ weeks at current cadence?
- Is sleep quality maintaining at current training volume?
- Are recovery scores stable week-over-week?

## Output: Habit Summary

Delivered as part of weekly or monthly summaries:

```
4-week pattern: 3.5 classes/week, mostly Mon-Wed-Fri.
You've hit your target 3 of 4 weeks. One light week (travel).

Recovery compliance: you followed amber recommendations 4/5 times.
The one time you pushed through, your Thursday HRV dropped 18%.

Nutrition: post-workout meal within 60 min on 80% of class days.
Morning classes are the gap — you skip breakfast after 6am sessions.

Sustainability: HRV trend is flat-to-positive at this volume.
Current cadence is working. No need to change.
```

## What This Module Never Does

- Count streaks or display streak-breaking warnings
- Gamify attendance with badges, points, or levels
- Guilt the user for missed classes or light weeks
- Recommend increasing volume unless recovery data supports it
- Track metrics that do not connect back to sustainability or performance
- Compare the user to averages or other users
