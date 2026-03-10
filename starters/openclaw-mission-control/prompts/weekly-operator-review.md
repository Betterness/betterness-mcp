# Weekly Operator Review Prompt

Run this every Sunday (or your chosen day) for a comprehensive coordination check. Takes 10–15 minutes.

## Prompt (Copy & Paste Into Clawbot)

```
You are the Chief of Staff running this health mission control.

Conduct a full weekly health operations coordination review:

1. Collect baseline data:
   - Call: getUserProfile (remind self of user goals)
   - Call: listConnectedDevices (verify all devices are connected and syncing)
   - Call: getUserHealthData (get this week's wearable metrics)
   - Call: getUserLabData (check lab order status, panel results)

2. Assess trends:
   - Compare this week vs last week: sleep, HRV, activity, recovery
   - Flag anything that improved or drifted significantly
   - Note if devices are giving conflicting signals

3. Review pending actions:
   - Any lab orders in progress? (Check status in MEMORY.md)
   - Any protocols started? Are they showing early results?
   - Any specialists who need follow-up?
   - Any escalation items from the week?

4. Identify the highest-leverage next move:
   - Is a protocol not working? Escalate to specialist.
   - Is lab data critical to a decision? Order the next panel.
   - Is a device not syncing? Fix device connectivity.
   - Is something going well? Plan to double down.

5. Output format:

   WEEKLY HEALTH OPERATIONS REVIEW [DATE]
   =====================================

   WHAT IMPROVED THIS WEEK:
   - [Metric]: [trend] (e.g., "Sleep: +45 min, now at 7.2h avg")
   - [Metric]: [trend]

   WHAT DRIFTED:
   - [Metric]: [trend] (e.g., "HRV: -8%, recovering from illness")
   - [Metric]: [trend]

   DEVICE & DATA STATUS:
   - All devices syncing: [Yes/No]
   - Last lab complete: [date]
   - Lab results reviewed: [Yes/No]
   - Outstanding orders: [None / list with status]

   ACTIVE PROTOCOLS & RESULTS:
   - [Protocol]: Started [date], status [working/unclear/needs adjustment]
   - [Protocol]: Started [date], status [working/unclear/needs adjustment]

   PENDING SPECIALIST ACTIONS:
   - [Specialist]: Waiting on [item] due [date]
   - [Specialist]: Waiting on [item] due [date]

   HIGHEST-LEVERAGE NEXT MOVE:
   [One clear action that will have the biggest impact]

   DELEGATION:
   - Escalate to [specialist] for [specific task]
   - Order [specific test] with Lab Coordinator
   - Schedule follow-up with [specialist] for [date]
```

## Expected Output

```
WEEKLY HEALTH OPERATIONS REVIEW — March 9, 2026
===============================================

WHAT IMPROVED THIS WEEK:
- Sleep quality: +12% (magnesium protocol working)
- HRV: +4.2 ms (recovery improving)
- Morning resting HR: -2 bpm

WHAT DRIFTED:
- Weekly training volume: -8% (sickness impact)
- Red meat intake: +2x (normal post-travel)

DEVICE & DATA STATUS:
- All devices syncing: Yes (Whoop, Oura, Apple Watch)
- Last lab complete: 2026-03-08 (Longevity Panel)
- Lab results reviewed: Yes, by Biomarker Analyst
- Outstanding orders: None

ACTIVE PROTOCOLS & RESULTS:
- Magnesium glycinate 2g/night: Started Feb 22, working (HRV up, sleep improved)
- Cold exposure (5 min showers): Started Feb 28, unclear (only 2 data points)

PENDING SPECIALIST ACTIONS:
- Longevity Strategist: Final aging protocol review due March 15
- Lab Coordinator: Standing order for lipid panel (cost check pending)

HIGHEST-LEVERAGE NEXT MOVE:
Order lipid panel to validate cholesterol trend + support heart aging protocol. Timeline: This week.

DELEGATION:
- Lab Coordinator: Confirm cost with CLAWBOT20, schedule collection for Saturday
- Longevity Strategist: Review magnesium + HRV correlation, finalize Q2 protocol
- Performance Coach: Assess if training volume should stay low another week or ramp up
```

## When to Run

- **Weekly**: Every Sunday evening or Monday morning
- **Ad-hoc**: After major life event (illness, travel, big training block)

## Cadence

- Run once per week minimum
- Store output in persistent memory
- Use to brief the team on direction

## Following Actions

After each review:
- Update MEMORY.md with current status
- Assign tasks to specialists with due dates
- Schedule next week's priorities
- Note what's working (vs. what needs adjustment)
