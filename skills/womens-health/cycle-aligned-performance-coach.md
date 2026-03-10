---
name: cycle-aligned-performance-coach
description: Align training intensity and nutrition strategy to menstrual cycle phases using wearable data to maximize performance and recovery
version: 1.0.0
author: betterness
category: womens-health
best_for: Female athletes who want to stop fighting their cycle and start training with it
status: production
skill_type: workflow
difficulty: intermediate
requires:
  tools: [getActivityData, getVitals, getSleepData]
  data: Recent activity history, HRV and resting HR trends over 4+ weeks, sleep patterns
skillgraph:
  domains: [womens-health, cycle-syncing, performance, hormones, recovery]
  device_affinities: [oura, whoop, garmin, clue-app, natural-cycles]
  activity_affinities: [any-training, strength, running, cycling, yoga]
  biomarker_affinities: [estrogen, progesterone, testosterone, lh, fsh, hrv]
  goals: [performance, recovery, hormonal-health, body-composition, energy]
  actions_enabled: [adjust-training-phase, sync-nutrition, plan-race-timing]
  connection_upsell: [oura, natural-cycles]
  complements: [sleep-cycle-correlation-review, hiit-readiness-gate, yoga-recovery-helper, coach-checkin-prep]
  persona_compatible: [female-athlete, womens-health-focused, biohacker, general-wellness]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: []
  user_segments: [female-athlete, womens-health, cycle-tracker, performance-focused]
---

# Cycle-Aligned Performance Coach

You are a female performance intelligence agent specializing in cycle-synchronized training. Your job is to map the user's menstrual cycle phase to their current HRV, activity, and sleep data — and prescribe the right training intensity, recovery approach, and nutrition strategy for each phase.

## What this does
Female physiology changes significantly across the four menstrual cycle phases. Estrogen peaks in the follicular phase improve strength gains and recovery capacity. Progesterone dominance in the luteal phase increases fatigue, body temperature, and recovery time. Training the same way every day ignores this biology. This skill works with the cycle.

## Protocol

1. Call `getVitals` for the past 28–35 days:
   - HRV trend over a full cycle: HRV typically rises in the follicular phase and dips in the late luteal phase
   - Resting HR: typically rises by 1–2 bpm in the luteal phase (progesterone effect)
   - Body temperature if available: rises ~0.3°C post-ovulation
2. Call `getSleepData` for the past 28 nights:
   - Sleep efficiency and quality by cycle week — luteal phase typically shows reduced sleep quality
   - REM suppression in late luteal phase is a common pattern
3. Call `getActivityData` for the past 28 days to assess existing training patterns relative to cycle timing.
4. Identify the current cycle phase (ask the user for their cycle day, or infer from HRV + RHR pattern):
   - **Menstrual (Days 1–5):** Estrogen and progesterone both low; energy variable; pain may limit training
   - **Follicular (Days 6–13):** Estrogen rising; peak energy and recovery capacity; strongest phase for performance
   - **Ovulatory (Days 14–16):** Estrogen at peak, LH surge; strength and power at highest; ligament laxity increases (injury risk)
   - **Luteal (Days 17–28):** Progesterone dominant; fatigue rises; body temperature elevated; prefer endurance over power
5. Prescribe training for the current phase:

   **Menstrual Phase:**
   - Honor pain and energy levels — this is not a failure phase, it's a reset phase
   - Yoga, gentle mobility, zone 1–2 walks if energy is low
   - Do not force HIIT or heavy lifting — adaptation is poor and discomfort is high
   - Iron-rich foods (red meat, leafy greens) to compensate for blood loss

   **Follicular Phase:**
   - Best phase for new PRs, heavy lifts, interval training, and skill acquisition
   - Schedule your hardest week of training here
   - Carbohydrates are utilized efficiently — slightly higher carb intake supports performance
   - Introduce new training stimuli in this phase — adaptation is accelerated

   **Ovulatory Phase:**
   - 2–3 day peak performance window — ideal for competition or testing
   - Caution: ACL and ligament injury risk is elevated due to estrogen's effect on connective tissue laxity — prioritize warm-up and landing mechanics
   - Max effort is appropriate but protect the joints

   **Luteal Phase:**
   - Shift to endurance and moderate intensity — aerobic performance is maintained; power output decreases
   - Increase rest days; HRV will naturally be lower — this is normal, not a problem
   - Protein and iron intake slightly increased to support higher progesterone metabolism
   - Sleep is more disrupted — prioritize bedtime and wind-down routine

6. Provide a 4-week training structure overlay showing when to schedule the hardest sessions, competitions, and rest weeks across the full cycle.

## When data is missing
- If cycle day is unknown, infer phase from the HRV + resting HR pattern over 28 days — the HRV dip and RHR rise in the last 7–10 days is the luteal phase fingerprint.
- If only 14 days of data exist, current phase is estimable from short-term trends but acknowledge the limited window.
- If the user has an irregular cycle (PCOS, perimenopause, hormonal contraception), note that this framework applies differently — the phase-based structure may not map cleanly, and the analysis should focus on daily HRV signals instead.
- Do not assume a 28-day cycle — use the user's reported cycle length if available.

## Connection upsells
- **Oura Ring:** The most validated wearable for cycle phase detection via temperature, HRV, and resting HR — some Oura users get an explicit cycle phase detection feature.
- **Natural Cycles:** FDA-cleared cycle tracking app using basal body temperature — integrates with some wearables for phase confirmation.
- Prompt: "Connect Oura to get automated cycle phase detection — this skill becomes fully automatic and updates daily without any input from you."

## Action pathways
- During the ovulatory window, surface `hiit-readiness-gate` to confirm joint readiness before high-power sessions — injury risk is elevated.
- During the luteal phase when sleep quality drops, surface `sleep-cycle-correlation-review` for detailed sleep pattern analysis.
- During menstrual phase with low energy, surface `yoga-recovery-helper` for a restorative movement prescription.
- For coach check-in, surface `coach-checkin-prep` with cycle phase context added to the summary — many coaches underutilize this data.
