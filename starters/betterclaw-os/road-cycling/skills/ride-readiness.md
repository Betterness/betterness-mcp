# Skill: Ride Readiness

## Trigger

This skill activates every morning (via heartbeat) and whenever the rider asks about today's ride, their readiness, or whether they should do a planned session.

Example triggers:
- "What's my ride today?"
- "Am I ready to ride?"
- "Should I do the intervals?"
- "Can I handle threshold today?"
- Morning heartbeat (automatic)

---

## Execution

### Step 1: Gather recovery signals

Call Betterness MCP `getWearableData` for:
- HRV (heart rate variability)
- Resting heart rate
- Recovery or readiness score (device-native)
- Sleep quality from last night
- Strain or training load from yesterday

### Step 2: Request context from Betterness Graph

- Personal HRV baseline (30-day)
- Personal resting HR baseline
- Recent training load trend (7-day TSS)
- Current FTP and power zones
- Weekly training structure (what is today supposed to be?)
- Recovery response after similar load patterns

### Step 3: Compute readiness

Score readiness as **green**, **amber**, or **red**:

**Green — Ride Ready**
- HRV at or above baseline
- Resting HR at or below baseline
- Sleep quality adequate
- Yesterday's load was not exceptionally high (or sufficient rest since)
- Action: planned session is a go at target watts

**Amber — Adjust Intensity**
- HRV slightly below baseline OR resting HR slightly elevated
- OR poor sleep (deep sleep <50% of baseline)
- OR 2+ consecutive high-TSS days without recovery
- Action: swap hard session to endurance (Zone 2), reduce interval watts by 5-10W, or shorten the ride

**Red — Rest or Recovery Spin**
- HRV significantly below baseline (>20% drop)
- AND/OR resting HR elevated >5 bpm
- AND/OR 3+ days of declining trend with accumulated fatigue
- Action: full rest day or recovery spin under 60% FTP

### Step 4: Build the ride prescription

For the computed readiness level, generate:
- Session type (endurance / tempo / threshold / VO2 / recovery spin / rest)
- Target watts and zone
- Duration
- Route recommendation (if available)
- Weather summary
- Fueling needs (if ride > 90 min)

### Step 5: Deliver the briefing

Format:

```
Ride: [emoji] [Session Type]

FTP [X]W. [One sentence: readiness + key driver].
Today: [session] @ [watts] ([zone]).
Route: [route if applicable]. Weather: [temp, wind].
Fuel: [plan if ride > 90 min].
```

---

## Rules

- Always reference FTP and power zones — never prescribe intensity without watts
- Include weather and route context when applicable
- When amber, always specify the alternative (e.g., "swap to Z2 endurance")
- When in doubt between amber and green, lean amber on days before key sessions
- Post-ride, acknowledge what was done and flag recovery implications
- Keep the briefing under 80 words unless the rider asks for more detail
