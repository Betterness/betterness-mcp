# Morning Review Prompt

Run this daily (ideally at the same time each morning). Takes 3–5 minutes.

## Prompt (Copy & Paste Into Clawbot)

```
You are the Chief of Staff running this user's health mission control.

Run a morning health operations review:

1. Fetch yesterday's wearable data:
   - Call: getUserHealthData
   - Look for: sleep duration, sleep quality, HRV, resting HR, recovery score
   - Format: [metric]: [value] [status: OK/caution/alert]

2. Verify devices are syncing:
   - Call: listConnectedDevices
   - Report: Each device name + last sync time + status
   - Flag any device syncing > 6 hours ago as CAUTION

3. Check if any biomarkers are pending or stale:
   - Call: getUserLabData (just get the most recent panel)
   - Report the panel name, date collected, and status
   - If panel was > 90 days ago, note "STALE"

4. Output format:

   MORNING OPERATIONS BRIEF [DATE]
   ============================

   READINESS:
   - Sleep: [value] hours ([status])
   - HRV: [value] [status]
   - Recovery: [status]
   → Readiness for training: [GO / CAUTION / REST RECOMMENDED]

   DEVICE STATUS:
   - [Device 1]: [last sync], [status]
   - [Device 2]: [last sync], [status]

   BIOMARKER STATUS:
   - Last panel: [name], [date]
   - Status: [Complete / Pending / Stale]

   TODAY'S ACTION ITEM:
   [One clear next step based on readiness, devices, or lab status]

   If anything is ALERT or CAUTION, escalate to Performance Coach or Biomarker Analyst.
```

## Expected Output

```
MORNING OPERATIONS BRIEF — March 9, 2026
========================================

READINESS:
- Sleep: 6.8 hours (CAUTION — below 7.5h target)
- HRV: 42 ms (OK — baseline 48 ms, 1% decline)
- Recovery: 71/100 (OK)
→ Readiness for training: CAUTION — good for easy run, skip hard intervals today

DEVICE STATUS:
- Whoop Band: Last sync 08:14 UTC (OK)
- Oura Ring: Last sync 06:47 UTC (OK)
- Apple Watch: Last sync 09:02 UTC (OK)

BIOMARKER STATUS:
- Last panel: Longevity Panel, March 8, 2026
- Status: Complete

TODAY'S ACTION ITEM:
Run easy 5 miles at conversational pace. Plan a full rest day tomorrow to boost HRV.
```

## Customization

- **For athletes**: Add training intensity guidance based on HRV and recovery
- **For longevity optimizers**: Flag any biomarkers trending down
- **For sleep optimizers**: Lead with sleep quality and HRV as primary metrics
- **For clinics**: Add patient name and reference their health goals at the top

## Schedule

Set this to run daily at:
- Your typical wake-up time (e.g., 7:00 AM)
- Or trigger manually each morning

## Notes

- If any device hasn't synced in 12+ hours, note it: "Whoop requires manual sync"
- If a biomarker is critically old (> 180 days), escalate to Lab Coordinator to order new panel
- Keep the output visible all day so you can reference it during decision-making
