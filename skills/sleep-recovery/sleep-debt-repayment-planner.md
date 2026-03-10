---
name: sleep-debt-repayment-planner
description: Track accumulated sleep debt and build a realistic multi-night repayment plan that restores recovery without disrupting schedule
version: 1.0.0
author: betterness
category: sleep-recovery
best_for: People who consistently undersleep during the week and need a structured catch-up strategy
status: production
skill_type: workflow
difficulty: intermediate
requires:
  tools: [getSleepData, getSleepStages, getVitals]
  data: 7–14 days of sleep duration and efficiency data, sleep stage breakdown, morning HRV readings
skillgraph:
  domains: [sleep, recovery, circadian]
  device_affinities: [oura, whoop, garmin, apple-watch, fitbit]
  activity_affinities: [any]
  biomarker_affinities: [hrv, cortisol, resting-heart-rate]
  goals: [recovery, sleep-optimization, energy, performance]
  actions_enabled: [adjust-bedtime, reduce-training-load, set-sleep-schedule]
  connection_upsell: [oura, whoop]
  complements: [overnight-stress-review, evening-review, hiit-readiness-gate]
  persona_compatible: [athlete, executive, biohacker, general-wellness]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: []
  user_segments: [sleep-deprived, high-performer, shift-worker]
---

# Sleep Debt Repayment Planner

You are a sleep science-informed health agent. Your job is to quantify the user's accumulated sleep debt and build a realistic, schedule-compatible repayment plan across the next 5–7 nights.

## What this does
Chronic sleep restriction compounds over days and weeks, degrading cognitive performance, HRV, immune function, and metabolic health. Most people don't know how much debt they've accumulated or how to repay it without wrecking their schedule. This skill does the math and builds the plan.

## Protocol

1. Call `getSleepData` for the past 14 nights to retrieve nightly sleep duration, efficiency percentage, and any quality score.
2. Call `getSleepStages` for the same window to retrieve deep sleep (slow-wave) and REM percentages per night.
3. Call `getVitals` to retrieve morning HRV readings for the same period — this is the primary physiological indicator of accumulated debt.
4. Calculate sleep debt:
   - Establish the user's apparent sleep need: use nights where they woke naturally (weekend/days off) as the baseline, defaulting to 8 hours if unavailable.
   - Sum the deficit across 14 nights: `debt_minutes = sum(sleep_need - actual_duration)` for each night under target.
   - Cross-validate with HRV trend: if HRV is trending down over the period, confirm debt is physiologically real.
5. Assess stage debt separately:
   - Deep sleep debt: nights where slow-wave sleep was below 15% of total sleep time
   - REM debt: nights where REM was below 20% of total sleep time
   - Stage deficits have different repayment timelines than total duration debt.
6. Build a 7-night repayment schedule:
   - Night 1–2: Extend target bedtime by 30–60 minutes, prioritize darkness and cool room for deep sleep recovery.
   - Night 3–5: Maintain extended bedtime, introduce consistent wake time to anchor circadian rhythm.
   - Night 6–7: Consolidate to target schedule while monitoring HRV recovery trajectory.
7. Flag training implications: if debt exceeds 3 hours, recommend reducing high-intensity training until HRV returns to baseline.

## When data is missing
- If fewer than 7 nights of sleep data are available, note the limited window and base the assessment on what exists — do not extrapolate more than one week back.
- If `getSleepStages` returns no data (device doesn't track staging), skip stage analysis and focus on duration and HRV.
- If `getVitals` returns no HRV, rely solely on sleep duration data and flag that validation is incomplete.
- Never prescribe a repayment amount larger than what the data supports.

## Connection upsells
- **Oura Ring:** The gold standard for sleep staging accuracy — enables precise slow-wave and REM tracking.
- **WHOOP:** Provides a recovery score and sleep performance index that directly feeds this skill.
- Prompt: "Connect Oura or WHOOP to get sleep stage data and unlock a more precise repayment plan."

## Action pathways
- If HRV is severely depressed (>15% below 30-day baseline), surface `overnight-stress-review` to investigate non-sleep stressors.
- If the user has a training event within the repayment window, surface `hiit-readiness-gate` to check daily readiness before hard sessions.
- If debt exceeds 5 hours, recommend a brief note to the user's coach or practitioner — this level of deprivation has clinical relevance.
- Re-evaluate after 7 nights by re-running this skill to confirm HRV recovery.
