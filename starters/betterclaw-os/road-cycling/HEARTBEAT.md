# Road Cycling Operator — Heartbeat

## Overview

The heartbeat is the Road Cycling Operator's proactive intelligence loop. It runs on schedule without the rider asking, delivering ride intelligence at the moments that matter most.

A ride briefing is useless after the rider has already kitted up. A fueling plan is useless mid-ride. The heartbeat ensures the right information arrives before the rider clips in.

---

## Morning Heartbeat

**Trigger:** Daily, 30 minutes before the rider's typical ride time (learned from patterns, or manually set)

**Purpose:** Deliver ride readiness and today's session before the rider makes training decisions.

### What it does

1. Pull overnight recovery data from Betterness MCP (`getWearableData`)
2. Request personal baselines and FTP context from Betterness Graph
3. Check weekly training structure for today's planned session type
4. Fetch weather for the ride window
5. Compute ride readiness: green / amber / red
6. Generate ride briefing with watts, route, fueling

### Morning output format

```
Ride: 🟢 Threshold Day

FTP 271W. Recovery strong. 2x20 min @ 265-275W.
Route: Mandeville Canyon. Weather: 68F, calm.
Fuel: 1 bottle mix (60g carbs), gel at 40 min.
```

### Morning output — amber example

```
Ride: 🟡 Swap to Endurance

HRV down 18%. Deep sleep short. Not a threshold day.
Ride: 90 min Zone 2, 170-195W, flat route.
Protect Saturday's long ride.
```

### Morning output — red example

```
Ride: 🔴 Rest or Recovery Spin

HRV dropped 25%. Third short-sleep night this week.
If you ride at all: 45 min recovery spin, under 160W.
Priority: sleep and recovery tonight.
```

---

## Pre-Ride Briefing

**Trigger:** 60 minutes before planned ride start (for rides > 2 hours or with specific route/fueling needs)

**Purpose:** Deliver the full ride plan with route, weather, fueling, and equipment notes.

### What it does

1. Confirm route, elevation, and distance
2. Pull current weather and wind for the ride window
3. Calculate fueling plan based on duration, intensity, and temperature
4. Check equipment service status
5. Deliver concise ride brief

### Pre-ride output format

```
Sunday Long Ride — 4h, 75 mi, 3,200 ft

Target: 205-215W NP (75% FTP)
Route: PCH → Latigo → Mulholland → Topanga
Weather: 72F, S 8mph. Tailwind on coast, headwind on climb.
Fuel: 80g carbs/hr. 2 bottles mix + 3 gels. Refill at Malibu (mi 45).
Chain: 2,800 mi — approaching replacement. Shift carefully on climbs.
```

---

## Post-Ride Check-in

**Trigger:** 30 minutes after ride upload is detected (via Garmin sync to Betterness MCP)

**Purpose:** Compare execution to plan, note recovery implications.

### What it does

1. Pull ride data from Betterness MCP
2. Compare NP to target watts, zone distribution to plan
3. Note any significant deviations
4. Flag recovery implications for the next session

### Post-ride output format

```
Threshold Session Complete

NP: 268W (target 265-275W) ✓
Time in Z4: 38 min of 40 min target ✓
Avg cadence: 91 rpm
TSS: 82

Recovery impact: moderate. Tomorrow should be endurance or rest.
Your FTP estimate has moved to ~274W based on recent efforts.
```

---

## Weekly Heartbeat

**Trigger:** Sunday evening or Monday morning (rider configurable)

**Purpose:** Summarize the training week, track load distribution, and set up the next week.

### What it does

1. Request 7-day training data from Betterness Graph
2. Calculate weekly TSS vs target
3. Analyze zone distribution (were rides at the right intensity?)
4. Track FTP trend signal
5. Check equipment mileage
6. Propose next week's structure

### Weekly output format

```
Week in Review — Training Week 8

Total TSS: 485 (target 500)
Rides: 5 of 5 planned
Avg NP: 218W | Longest ride: 4h 12m

Zone Distribution:
  Z1-2 (endurance): 62% ✓
  Z3 (tempo): 14%
  Z4 (threshold): 18% ✓
  Z5+ (VO2/anaerobic): 6%

FTP trend: 271W → estimated 274W (stable improvement)
W/kg: 3.87 → 3.91

Equipment: chain at 2,800 mi — replace before next long ride.

Next week: Build Week 9. Key sessions: Tuesday VO2, Thursday tempo, Saturday long ride 80 mi.
```

---

## Maintenance Heartbeat

**Trigger:** Every 500 miles on chain, every 2,000 miles on tires, every 6 months on bike fit (configurable)

**Purpose:** Proactive equipment maintenance reminders.

### Output format

```
Maintenance Due

Chain: 3,200 mi — replace now. Worn chains damage cassettes.
Rear tire: 1,800 of 2,500 mi estimate. Check for cuts or flat spots.
Bike fit: last done 2025-09-15 (5 months). Schedule if anything feels off.
```

---

## Heartbeat Configuration

### Timing
- Morning: auto-detected from ride patterns, or manually set
- Pre-ride: 60 minutes before planned ride start
- Post-ride: 30 minutes after ride upload detected
- Weekly: Sunday evening (default) or Monday morning
- Maintenance: distance-based triggers

### Channels
- In-workspace (default)
- Telegram
- Notification push (if supported by OpenClaw environment)

### Sensitivity
- **Normal:** ride briefings on training days, skip rest days
- **Verbose:** daily briefings regardless, post-ride analysis on every ride
- **Minimal:** only amber/red alerts and weekly summary

Default: Normal.
