# Barry's / Studio Operator — Heartbeat

## Overview

The heartbeat is Studio Operator's proactive intelligence loop. It runs on schedule without the user asking, delivering class-day intelligence at the moments that matter — before you walk in and after you walk out.

Studio training is time-sensitive. A readiness check at noon is useless for a 6:30 AM class. A recovery plan tomorrow morning is too late when you're hungry at 7:30 AM. The heartbeat ensures the right information arrives at the right time.

---

## Pre-Class Heartbeat

**Trigger:** 90 minutes before scheduled class time (or at wake time on class mornings)

**Purpose:** Deliver the readiness call before the user decides whether to go and how hard to push.

### What it does

1. Pull overnight data from Betterness MCP (sleep, HRV, resting HR)
2. Request recovery response curve from Betterness Graph (how recovered since last session)
3. Check weekly cadence (how many sessions so far this week)
4. Compute readiness: go hard / dial to 80% / skip
5. Deliver via preferred channel

### Pre-class output — green

```
Class day: 🟢 Go Hard

Recovery solid. HRV 56ms (above your 52ms baseline). Sleep 7h 18m with good deep sleep.
Full intensity today. Hydrate 20oz before class.
Post-class plan will be ready when you're done.
```

### Pre-class output — amber

```
Class day: 🟡 Dial to 80%

Recovery moderate — deep sleep was short (40 min vs your 68 min baseline).
Go to class, but keep effort around 80%. Stay in zone 3-4, skip bonus rounds.
Prioritize sleep tonight — early bedtime.
```

### Pre-class output — red

```
Class day: 🔴 Skip & Recover

Recovery low. This would be your 4th session in 5 days and your HRV has dropped 18%.
Best move: walk, stretch, or light yoga instead. One rest day now prevents a week of feeling flat.
Next class: Thursday, and you'll feel the difference.
```

---

## Post-Class Heartbeat

**Trigger:** 30 minutes after class ends (detected via wearable strain spike or user confirmation)

**Purpose:** Deliver the recovery plan while the user is still at or near the studio.

### What it does

1. Detect that a workout occurred (elevated strain, heart rate spike, or user says "just finished")
2. Estimate session intensity from wearable data
3. Build recovery plan: hydration, protein, food, cooldown
4. Search nearby healthy food options via maps (based on studio location)
5. Deliver recovery plan and food options

### Post-class output

```
Nice session. Here's your recovery plan:

Hydration: 32oz water in the next hour (you burned ~480 cal)
Protein: 25-30g within 45 min — shake, Greek yogurt, or chicken
Cooldown: 5 min stretch focusing on hamstrings and hip flexors

Nearby food (within 5 min walk):
  🥗 Sweetgreen — 0.2 mi — build a protein bowl
  🥤 Juice Press — 0.3 mi — recovery smoothie
  🍗 Dig Inn — 0.4 mi — grilled chicken + greens

Tonight: wind down by 10:30. Your body needs quality sleep to absorb today's work.
```

---

## Weekly Heartbeat

**Trigger:** Sunday evening or Monday morning (user configurable)

**Purpose:** Summarize the training week and set up the next one.

### What it does

1. Request weekly attendance and strain data from Betterness Graph
2. Compare this week's cadence to the user's target and optimal rhythm
3. Check recovery trend across the week
4. Surface any patterns (e.g., "you always tank on Friday after training Mon-Wed-Thu")
5. Suggest a class plan for next week

### Weekly output

```
Week in Review

Classes: 3 (target: 3) ✓
Best session: Tuesday (recovery green, high output)
Toughest recovery: Thursday → Friday (HRV dropped 15% overnight)

Pattern: Your Friday recovery is consistently low when you train 3 consecutive days.
Consider a rest day between Wednesday and Friday classes.

Next week plan: Mon, Wed, Fri — with a rest day between each session.
```

---

## Heartbeat Configuration

### Timing
- Pre-class: 90 min before scheduled class, or auto-detect from wake time on class days
- Post-class: 30 min after workout detection, or on user confirmation
- Weekly: Sunday evening (default) or Monday morning

### Channels
- In-workspace (default)
- Telegram
- Notification push (if supported by OpenClaw environment)

### Sensitivity
- **Normal:** pre-class on class days, post-class after sessions, weekly summary
- **Minimal:** pre-class only on amber/red days, weekly summary only
- **Verbose:** daily readiness regardless of class schedule, full recovery breakdowns

Default: Normal.

---

## What the Heartbeat Never Does

- Interrupt a class or send notifications during a workout
- Deliver a wall of metrics without a clear call
- Nag about missed classes (consistency should feel encouraging, not punishing)
- Use alarming language for normal post-workout fatigue
- Recommend medical interventions or diagnose conditions
