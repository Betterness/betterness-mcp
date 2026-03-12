# Skill: Power Analysis

## Trigger

This skill activates when the rider asks about their FTP, power zones, power trends, W/kg, or post-ride power data analysis.

Example triggers:
- "How's my FTP trending?"
- "What are my zones?"
- "Should I update my FTP?"
- "How was that ride?"
- "Analyze my power from today's ride"
- "What's my W/kg?"

---

## Execution

### Step 1: Determine the question type

Power analysis covers several sub-questions:
- **FTP status:** current FTP, when it was set, whether it needs updating
- **FTP trend:** 8/12-week trajectory, plateau detection, improvement rate
- **Zone check:** current zone table, whether zones match recent ride data
- **Ride analysis:** post-ride NP, zone distribution, execution vs plan
- **W/kg tracking:** power-to-weight ratio and its trend

### Step 2: Retrieve data

For **FTP/zone questions:**
- Local memory: current FTP, zones, last test date
- Betterness Graph: FTP trend curve, plateau detection, estimated current FTP

For **ride analysis:**
- Betterness MCP `getActivityData`: ride power data, NP, TSS, zone distribution
- Local memory: today's ride plan (target watts, zones, route)
- Betterness Graph: comparison to similar ride efforts in history

For **W/kg:**
- Local memory: current FTP
- Betterness MCP `getWearableData`: body composition / weight
- Betterness Graph: W/kg trend over time

### Step 3: Analyze and compare

- Compare current FTP to 8-week and 12-week historical values
- For rides: compare NP to target, zone time to plan, identify drift or fade
- For zones: check if prescribed zones still match rider's actual power distribution
- Flag if FTP has likely moved (rides consistently above zone targets = FTP has increased)

### Step 4: Deliver the analysis

**FTP trend format:**

```
FTP Trend — Last 12 Weeks

Current: 271W (set 2026-02-28)
8 weeks ago: 258W
12 weeks ago: 249W
Trend: steady improvement, +22W over 3 months

Estimated current FTP: ~274W based on recent threshold efforts.
Recommend a formal test or 20-min effort within 2 weeks to confirm.
W/kg: 3.87 → estimated 3.91 (weight stable at 70kg)
```

**Post-ride format:**

```
Threshold Ride — Analysis

NP: 268W (target 265-275W) ✓
Time in Z4: 38 min of 40 min target ✓
Time in Z5+: 2 min (acceptable overshoot on climbs)
Avg cadence: 91 rpm
VI: 1.04 (well-paced)
TSS: 82

Execution: clean. Stayed in zone, paced well, no fade.
Recovery impact: moderate. Easy ride or rest tomorrow.
FTP signal: consistent Z4 efforts at 268W suggest FTP may be closer to 275W.
```

### Step 5: Recommend next action

- If FTP has likely moved: recommend zone update or formal test
- If plateau detected: suggest training structure change (more Z4/Z5 work, or recovery block)
- If ride deviated from plan: explain why and adjust future prescriptions

---

## Rules

- Always express power relative to FTP percentage and zones, not just raw watts
- Include W/kg when body composition data is available
- Flag stale FTP (>6 weeks since last test) proactively
- When estimating FTP from ride data, be conservative — under-estimate by 2-3% vs formal test
- Never compare to other riders or population benchmarks — only to the rider's own history
- Keep analysis concise — the rider wants the insight and the decision, not a lab report
