# Skill: Recovery Verdict

## Trigger

This skill activates at the start of each day (via heartbeat) and whenever the user asks about their recovery status or readiness.

Example triggers:
- "How's my recovery?"
- "Am I recovered?"
- "Should I train today?"
- "What's my readiness?"
- "Give me the verdict"
- Morning heartbeat (automatic)

---

## Execution

### Step 1: Gather recovery signals

Call Betterness MCP `getWearableData` for:
- HRV (heart rate variability)
- Resting heart rate
- Recovery or readiness score (device-native)
- Sleep quality from last night (via sleep-analysis skill data)
- Respiratory rate
- Skin temperature deviation (if available)
- SpO2 (if available)

### Step 2: Request context from Betterness Graph

- Personal HRV baseline (30-day)
- Personal resting HR baseline
- Recent HRV trend (7-day direction)
- Recent training load (if available)
- Known recovery patterns for this user
- Any active flags (illness, travel, alcohol, high strain)

### Step 3: Compute verdict

Score recovery as **green**, **amber**, or **red** using this framework:

**Green — Recovery Strong**
- HRV at or above personal baseline
- Resting HR at or below personal baseline
- Sleep quality adequate (deep sleep near baseline)
- No red flags from trend data
- Action: intensity available, normal training

**Amber — Recovery Moderate**
- HRV slightly below baseline OR resting HR slightly elevated
- OR deep sleep notably below baseline
- OR 2+ consecutive days of declining trend
- Action: moderate intensity, protect tonight's sleep

**Red — Recovery Low**
- HRV significantly below baseline (>20% drop)
- AND/OR resting HR elevated >5 bpm above baseline
- AND/OR 3+ days of declining HRV trend
- AND/OR very poor sleep (deep sleep <50% of baseline)
- Action: rest day recommended, restorative activities only

### Step 4: Identify the key driver

Pick the single most important factor explaining today's verdict:
- "Deep sleep was short"
- "HRV has been declining for 3 days"
- "Resting HR elevated — likely from yesterday's high strain"
- "Strong sleep, HRV rebounding"

### Step 5: Deliver the verdict

Format:

```
Recovery: [emoji] [Green/Amber/Red]

[One sentence: key driver]
[One sentence: recommended action]
```

Examples:

```
Recovery: 🟢 Strong
HRV trending up for the third day. Deep sleep above baseline.
Good window for intensity. Wind down by 10:30 tonight.
```

```
Recovery: 🟡 Moderate
Deep sleep short last night (48 min vs your 72 min baseline).
Keep intensity moderate. Prioritize an earlier bedtime tonight.
```

```
Recovery: 🔴 Low
HRV dropped 22% from your baseline. Resting HR up 8 bpm.
Rest day. Walk, stretch, or restorative yoga. Lights out by 10.
```

---

## Rules

- The verdict is always 2-4 lines. Not a paragraph. Not a data table.
- Always reference the user's personal baseline, not generic thresholds
- Always include one action recommendation
- Never say "your recovery score is X" without explaining what it means for today
- If multiple signals conflict (e.g., good HRV but poor sleep), acknowledge the mixed signal and err on the conservative side
- The morning heartbeat version should be even shorter than the conversational version
