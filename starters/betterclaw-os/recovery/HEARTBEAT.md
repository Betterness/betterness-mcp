# Recovery — Heartbeat

## Overview

The heartbeat is the Recovery's proactive intelligence loop. It runs on schedule without the user asking, delivering recovery insights at the moments they matter most.

Recovery is time-sensitive. A morning verdict is useless at noon. A bedtime recommendation is useless at 6 AM. The heartbeat ensures the right information arrives at the right time.

---

## Morning Heartbeat

**Trigger:** Daily, 15 minutes after typical wake time (learned from sleep data)

**Purpose:** Deliver the recovery verdict before the user makes training or scheduling decisions.

### What it does

1. Pull overnight data from Betterness MCP (`getWearableData`)
2. Request personal baselines from Betterness Graph
3. Compute verdict: green / amber / red
4. Generate one-sentence summary + one action recommendation
5. Deliver via preferred channel (in-workspace, Telegram, notification)

### Morning output format

```
Recovery: 🟢 Strong

HRV 58ms (above your 52ms baseline). Deep sleep 1h 24m.
Good day for intensity. Wind down by 10:30 tonight.
```

### Morning output — amber example

```
Recovery: 🟡 Moderate

Deep sleep short (42 min vs 72 min baseline). Resting HR slightly elevated.
Keep intensity moderate today. Prioritize an early bedtime.
```

### Morning output — red example

```
Recovery: 🔴 Low

HRV dropped 24% from your baseline. Third consecutive night of poor deep sleep.
Rest day recommended. Walk, stretch, or restorative yoga. Lights out by 10.
```

---

## Evening Heartbeat

**Trigger:** Daily, 2 hours before target bedtime

**Purpose:** Set up the best possible night of sleep.

### What it does

1. Check current recovery trajectory and sleep debt
2. Calculate optimal bedtime based on circadian pattern and next-day demands
3. Suggest wind-down actions
4. Flag anything that might disrupt sleep (late caffeine, late exercise, screen time)

### Evening output format

```
Bedtime target: 10:30 PM

Your recovery has been trending down this week. Tonight matters.
Start winding down now — dim lights, no screens after 10.
Tomorrow: easy morning, no alarm pressure.
```

---

## Weekly Heartbeat

**Trigger:** Sunday evening or Monday morning (user configurable)

**Purpose:** Summarize the recovery week and surface meaningful trends.

### What it does

1. Request 7-day trend data from Betterness Graph
2. Compare this week to the 30-day baseline
3. Identify the best and worst recovery nights
4. Surface any emerging patterns (e.g., "recovery consistently drops after Thursday training")
5. Suggest one adjustment for the coming week

### Weekly output format

```
Week in Recovery

Best night: Tuesday (HRV 64ms, deep sleep 1h 38m)
Worst night: Saturday (HRV 38ms, deep sleep 32m — late dinner + alcohol)

7-day HRV average: 51ms (↓ from 55ms last week)
Deep sleep average: 58 min (stable)

Pattern: Your Saturday recovery has been low for 3 consecutive weeks.
Consider moving your Friday social dinner earlier or cutting alcohol.

Focus this week: Protect Friday and Saturday sleep.
```

---

## Heartbeat Configuration

### Timing
- Morning: auto-detected from wake patterns, or manually set
- Evening: 2 hours before target bedtime, or manually set
- Weekly: Sunday evening (default) or Monday morning

### Channels
- In-workspace (default)
- Telegram
- Notification push (if supported by OpenClaw environment)

### Sensitivity
- **Normal:** verdicts on meaningful changes only
- **Verbose:** daily details regardless of change
- **Minimal:** only amber/red alerts, skip green days

Default: Normal.

---

## What the Heartbeat Never Does

- Send a wall of numbers without interpretation
- Wake the user up with notifications
- Report when nothing meaningful changed (unless set to verbose)
- Use alarming language for normal fluctuations
- Recommend medical interventions or diagnoses
