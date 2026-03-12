# Marathon — Heartbeat

## Overview

The heartbeat is the Marathon's proactive intelligence loop. It runs on schedule without the runner asking, delivering training intelligence at the moments it matters most.

Marathon training is time-sensitive. A training verdict is useless after the runner has already laced up. A fueling reminder is useless after they have already bonked. The heartbeat ensures the right information arrives before the decision point.

---

## Morning Heartbeat

**Trigger:** Daily, 30 minutes before typical run time (learned from training patterns) or 15 minutes after typical wake time on rest days

**Purpose:** Deliver the training verdict before the runner starts their session.

### What it does

1. Pull overnight recovery data from Betterness MCP (`getWearableData`)
2. Request personal baselines and training load trend from Betterness Graph
3. Check today's scheduled session against the training plan
4. Assess whether recovery supports the planned session
5. Generate phase-aware training brief with one action recommendation
6. Deliver via preferred channel (in-workspace, Telegram, notification)

### Morning output — quality day, green

```
Build Week 6 | Thursday

Recovery: green. HRV above baseline, sleep clean.
Today: Tempo — 6 mi @ 7:50/mi.
Stay controlled through mile 2, then settle into rhythm.

Saturday's 18-miler is the week's priority.
Fuel normally today.
```

### Morning output — quality day, amber

```
Peak Week 2 | Tuesday

Recovery: amber. Deep sleep short, resting HR up 4 bpm.
Planned: 8x800m intervals.
Recommendation: Swap to easy 5 miles.

You are 3 weeks from race day. Protecting your legs
matters more than one speed session. Sleep early tonight.
```

### Morning output — rest day

```
Build Week 6 | Monday

Rest day. Recovery moderate — exactly why today is off.
If you need to move: easy 20-min walk or light stretching.
Hydrate well. Tomorrow's easy 5 will feel better for it.
```

### Morning output — race week

```
Race Week | Wednesday (Race in 4 days)

Easy 3 miles, whatever pace feels comfortable.
Do not chase pace. This is a shakeout, not a workout.
Lay out your race kit tonight: shoes, bib, gels, body glide.
Weather forecast: 52F, dry, 8mph wind from the west.
```

---

## Post-Run Heartbeat

**Trigger:** 2 hours after a detected training session ends (from wearable data)

**Purpose:** Confirm the session, check execution against plan, and set up recovery for the next session.

### What it does

1. Pull completed session data from Betterness MCP (distance, pace, heart rate, duration)
2. Compare execution to the planned session
3. Calculate immediate recovery needs (fueling window, hydration, sleep priority)
4. Flag anything notable (pace drift, HR elevation, early cutoff)
5. Preview the next session and what recovery needs to support it

### Post-run output — long run completed

```
Long Run Complete | 18.2 mi @ 8:42/mi avg

Execution: on target. Pace held well through mile 16,
slight drift miles 17-18 (8:58, 9:05) — normal for this
distance.

Recovery priority: 600 cal within 45 min (carbs + protein).
Rehydrate aggressively today. Easy day tomorrow.
Next quality session: Tuesday tempo.
```

### Post-run output — session modified

```
Tempo Complete | 4 mi @ 7:55/mi (planned: 6 mi @ 7:50)

You cut it short — smart call given this morning's amber
recovery. 4 miles at pace is still valuable stimulus.
No need to make it up. Focus on Saturday's long run.

Eat well tonight, lights out early.
```

---

## Weekly Heartbeat

**Trigger:** Sunday evening or Monday morning (user configurable)

**Purpose:** Summarize the training week, assess phase progression, and preview the coming week.

### What it does

1. Request 7-day training data from Betterness Graph (volume, intensity, recovery trend)
2. Compare actual volume and intensity to the training plan target
3. Assess recovery trajectory across the week
4. Check phase progression — is the runner on track for the current phase?
5. Preview next week's key sessions and volume target
6. Flag any emerging concerns (volume spikes, recovery decline, missed key sessions)

### Weekly output format

```
Week 6 Summary | Build Phase

Volume: 44.3 mi of 48 mi target (92%)
Key sessions: Tempo 6 mi (done), Long run 18 mi (done)
Missed: Wednesday easy 5 (rest day — good call, recovery was low)

Recovery trend: stable. HRV averaging 54ms (baseline 52ms).
Best recovery day: Tuesday. Worst: Sunday post-long-run.

Week 7 Preview:
  Mon: Rest
  Tue: Easy 5
  Wed: Intervals — 6x1000m @ 7:15/mi
  Thu: Easy 4
  Fri: Easy 3
  Sat: Long run 20 mi @ 8:45
  Sun: Rest or easy 3

Volume target: 52 mi. Biggest long run of the cycle.
Prioritize sleep and fueling all week.
```

---

## Heartbeat Configuration

### Timing
- Morning: auto-detected from training patterns, or manually set
- Post-run: 2 hours after session detected, or manually triggered
- Weekly: Sunday evening (default) or Monday morning

### Channels
- In-workspace (default)
- Telegram
- Notification push (if supported by OpenClaw environment)

### Sensitivity
- **Normal:** daily training briefs, post-run summaries, weekly recaps
- **Verbose:** includes detailed metrics and trend data in every message
- **Minimal:** only amber/red recovery alerts and weekly summaries, skips routine green days

Default: Normal.

---

## What the Heartbeat Never Does

- Send a wall of training metrics without interpretation or phase context
- Wake the runner up with notifications before their alarm
- Congratulate or use motivational language for routine training sessions
- Use alarming language for normal post-workout fatigue
- Recommend medical interventions or diagnose injuries
