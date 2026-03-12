# Module: Class-Day Readiness

## Purpose

Delivers a pre-class readiness assessment every time the user has a class scheduled. This is the flagship module — the first thing the user sees on a class day.

## When It Activates

- Heartbeat fires 90 minutes before a scheduled class
- User opens the workspace on a day with a booked class
- User asks "Should I go today?" or similar

## Data Sources

| Source | What It Provides |
|--------|-----------------|
| Betterness Graph | Sleep score, HRV, resting heart rate, recovery trend |
| Local memory | Class schedule, recent attendance, intensity history |
| Betterness Graph | Training load across last 7 days |
| Local memory | Logged soreness, injury flags, subjective notes |

## Output: The Class-Day Card

The Class-Day Card is a single status card with three possible states:

### Go Hard (Green)
- Recovery metrics support full intensity
- No accumulated fatigue concerns
- Shows: "You're good. Push it today."
- Includes: one specific metric that supports the call (e.g., "HRV 15% above your 30-day average")

### Dial to 80% (Amber)
- Recovery is adequate but not optimal
- Shows: "Go, but scale back."
- Includes: specific intensity targets (tread speed range, heart rate ceiling)
- Includes: what triggered the amber call (e.g., "Sleep was 5.5 hours — that costs you top-end power")

### Skip & Recover (Red)
- Recovery data indicates rest is the better investment
- Shows: "Skip today. You'll get more from Thursday's class."
- Includes: what triggered the red call
- Includes: alternative activity suggestion and pointer to next scheduled class

## Card Composition Rules

- The card shows ONE recommendation — no hedge, no "but if you feel good..."
- Always includes the specific data point(s) driving the recommendation
- If amber or red, always references the next scheduled class
- Never shows raw data dumps — the card is an interpreted recommendation

## Integration with Other Modules

- Feeds into **Intensity Modulator** (amber days get specific scaling guidance)
- References **Weekly Cadence Tracker** (consecutive day count factors into the decision)
- Post-class, hands off to **Post-Workout Recovery** module

## What This Module Never Does

- Show a dashboard of metrics without a recommendation
- Say "listen to your body" as the primary guidance
- Require the user to interpret their own data
- Fire on non-class days (that is the Weekly Cadence Tracker's domain)
