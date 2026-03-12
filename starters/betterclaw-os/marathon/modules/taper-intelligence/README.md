# Module: Taper Intelligence

Auto-detects the taper phase, manages volume reduction expectations, and provides psychological support during the hardest mental phase of marathon training.

## When Active

Shown during the taper phase — typically the final 2-3 weeks before race day. Activates automatically when the training plan transitions from peak to taper, or when the runner asks about tapering.

## Data Sources

- Betterness MCP: `getWearableData` (current training load, recovery metrics, sleep quality)
- Betterness Graph: taper response history (how this runner has responded to previous tapers), training load decay curve, recovery rebound patterns
- Local memory: race date, current training phase, peak volume achieved

## What It Does

- **Volume management** — shows expected weekly mileage for each taper week vs peak
- **Normalizes taper feelings** — sluggish legs, phantom niggles, restlessness, and anxiety are all expected
- **Monitors recovery rebound** — tracks HRV and sleep improvement as training load decreases
- **Prevents taper sabotage** — detects and flags if the runner is sneaking in extra miles or intensity
- **Connects to fueling** — triggers carb loading protocol at the right time

## Output

### Example — Taper Week 1

```
Taper Intelligence | Week 1 of 2

Peak volume was 56 mi. This week: 42 mi (25% reduction).
You will feel like you should be doing more. You should not.

Recovery is already responding — HRV up 6% from last week.
This is the taper working.

Key session: Tuesday tempo, 4 mi at race pace (not longer).
Long run Saturday: 12 mi easy. Last one before race day.

What is normal to feel this week:
- Heavy legs on easy runs
- Random aches that were not there before
- Restlessness and irritability
- Doubt about whether you trained enough

All normal. Your fitness is locked in.
```

### Example — Taper Week 2

```
Taper Intelligence | Week 2 (Race Week is next)

Volume: 28 mi (50% of peak). Most of it easy.
Recovery: HRV trending up. Sleep quality improving.
Your body is sharpening.

Wednesday: Last speed touch — 4x400m at 5K pace.
Short, sharp, done. Not a workout — a wake-up call
for your legs.

Carb loading starts Thursday. Details in Fueling Calculator.
Race week protocol activates Sunday.
```

## Rules

- Never encourage adding volume or intensity during taper — the work is done
- Normalize the psychological difficulty of taper explicitly — runners need to hear it
- Track recovery rebound as evidence that the taper is working
- Flag taper sabotage gently: "You ran 8 miles today — the plan said 5. I know it feels good, but save those legs."
- Always connect taper to the race week protocol that follows
- Keep taper messaging calm and reassuring, not clinical
