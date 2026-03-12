# Skill: Training Status

## Trigger

This skill activates when the runner asks about their daily training readiness, current training status, or what they should do today within the context of their training phase.

Example triggers:
- "What's my training today?"
- "Should I train today?"
- "How's my training going?"
- "Am I ready for today's workout?"
- "What's the plan?"
- Morning heartbeat (automatic)

---

## Execution

### Step 1: Determine the training phase and scheduled session

Check local workspace memory for:
- Current training phase (base / build / peak / taper / race week)
- Week number within the phase
- Today's scheduled session from the training plan
- This week's key sessions and volume target

### Step 2: Retrieve recovery signals

Call Betterness MCP `getWearableData` for:
- HRV (heart rate variability)
- Resting heart rate
- Sleep quality and deep sleep duration
- Recovery or readiness score (device-native)
- Training load from yesterday's session (if any)

### Step 3: Request context from Betterness Graph

- Personal HRV baseline (30-day)
- Personal resting HR baseline
- Recent recovery trend (7-day direction)
- Training load progression (weekly volume trend)
- Known recovery patterns for this runner after similar sessions

### Step 4: Compute the recovery gate

Score readiness as **green**, **amber**, or **red**:

**Green — proceed as planned**
- HRV at or above baseline, resting HR stable, sleep adequate
- Training load sustainable, no fatigue flags
- Action: do the planned session

**Amber — modify the session**
- HRV slightly below or resting HR slightly up, or poor sleep
- OR cumulative fatigue building from the week
- Action: reduce volume or intensity, swap for easy miles

**Red — rest**
- HRV significantly below baseline, resting HR elevated, poor sleep trend
- Action: skip the session, walk or rest, protect sleep tonight

### Step 5: Deliver the training status

Format:

```
[Phase] Week [X] | [Day of week]

Recovery: [green/amber/red]. [One sentence: key driver]
Today: [Session description with pace/distance]
[One sentence: action or modification]

[One sentence: what matters most this week]
```

### Examples

```
Build Week 6 | Thursday

Recovery: green. HRV above baseline, sleep clean.
Today: Tempo — 6 mi @ 7:50/mi.
Stay controlled through mile 2, then settle in.

Saturday's 18-miler is the week's priority.
```

```
Peak Week 2 | Tuesday

Recovery: amber. Deep sleep was short last night.
Planned: 8x800m intervals.
Recommendation: Swap to easy 5 miles. Protect your legs.

You are 3 weeks from race day.
```

```
Taper Week 1 | Wednesday

Recovery: green. Your body is responding to the reduced load.
Today: Easy 4 miles at conversational pace.
Do not add speed work. The fitness is locked in.

Long run Saturday is 12 miles — your last before race day.
```

### Step 6: Offer to go deeper

If something notable emerged:
- "Your HRV has been climbing for 4 days — the taper is working. Want to see the trend?"
- "Your training load this week is 12% above target. Want me to adjust the remaining sessions?"
- "Recovery has been amber for 3 days. Want me to look at what might be driving it?"

---

## Rules

- Always frame the status within the current training phase — phase context is mandatory
- Lead with the recovery gate verdict and the one most important factor
- Include the specific session (distance, pace) — not just "you have a workout today"
- Keep the status under 80 words unless the user asks for more detail
- When amber or red, always name the modification or alternative
- Reference what matters most this week (the key session worth protecting)
- Do not present raw metrics without explaining what they mean for today's training
