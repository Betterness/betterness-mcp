# Module: Intensity Modulator

## Purpose

Translates recovery data into specific intensity targets for today's class. When Class-Day Readiness returns an amber signal, this module tells the user exactly how to scale back — with numbers, not vibes.

## When It Activates

- Class-Day Readiness returns amber (Dial to 80%)
- User asks "How hard should I push today?"
- User asks for specific pace, weight, or heart rate targets

## Data Sources

| Source | What It Provides |
|--------|-----------------|
| Betterness Graph | HRV, sleep score, recovery percentage |
| Local memory | Usual tread speeds, weight ranges, heart rate zones |
| Local memory | Class type (Floor & Tread, Lift, Run, Double Floor) |
| Class-Day Readiness | Today's readiness signal and triggering factors |

## Modulation Rules

### Tread Targets (Floor & Tread, Run)
Based on the user's known speed ranges from local memory:

| Readiness | Push Pace | All-Out | Base/Jog |
|-----------|-----------|---------|----------|
| Green | 100% | 100% | Normal |
| Amber (mild) | 90% | 85% | Normal |
| Amber (moderate) | 80% | Skip or 75% | Normal |

Example output: "Your usual push is 9.0 mph — today, cap at 7.5. Skip all-outs or jog them at 7.0. Base pace stays the same."

### Floor Targets (Lift, Double Floor)
Based on known weight ranges:

| Readiness | Working Weight | Volume |
|-----------|---------------|--------|
| Green | 100% | Full sets |
| Amber (mild) | 90% | Full sets |
| Amber (moderate) | 80% | Drop last set if fatigued |

Example output: "Your usual dumbbell row is 40 lbs — use 30–35 today. Full sets, but if form breaks on the last round, stop there."

### Heart Rate Guidance
If the user wears a heart rate monitor in class:
- Green: normal zone targets
- Amber (mild): cap at Zone 4, minimize Zone 5
- Amber (moderate): stay in Zone 3, brief Zone 4 only

### What Triggers Modulation Levels

**Amber (mild):**
- Sleep 60–74 or HRV 10–15% below baseline
- Second consecutive training day
- Minor soreness logged

**Amber (moderate):**
- Sleep 55–64 or HRV 15–20% below baseline
- Third consecutive training day
- Multiple soreness flags

## Output Format

Keep it to 3–4 lines. The user is about to walk into class — they need targets they can remember.

```
Amber day — dial to 80%.
Tread: cap push pace at 7.5 (your usual is 9.0). Skip all-outs.
Floor: drop to 35 lb dumbbells (your usual is 40). Full sets.
Reason: 5.5 hours sleep + second day in a row.
```

## What This Module Never Does

- Give vague advice like "take it easy" or "go by feel"
- Provide targets without referencing the user's actual numbers
- Activate on green days (green = go hard, no modulation needed)
- Suggest skipping class (that is Class-Day Readiness's call, not this module's)
- Override the user if they decide to push anyway — note the risk, respect the choice
