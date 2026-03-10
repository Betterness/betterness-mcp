---
name: barrys-burn-balance
description: Optimize high-intensity class frequency against recovery capacity
version: 1.0.0
author: betterness
category: fitness-performance
requires:
  tools: [getActivityData, getSleepData, getSleepStages, getVitals, getBodyComposition]
  data: HIIT-heavy training pattern + sleep and recovery
skillgraph:
  domains: [hiit, recovery, training-load, sleep, body-composition]
  device_affinities: [oura, whoop, apple-health, garmin]
  activity_affinities: [hiit, barrys-bootcamp, orange-theory, group-fitness]
  biomarker_affinities: []
  goals: [body-composition, recovery, performance, injury-prevention]
  actions_enabled: [connect-device]
  connection_upsell: [connect-oura-for-readiness, connect-whoop-for-strain, connect-apple-health-for-workouts]
  complements: [intensity-distribution-coach, recovery-coach, body-recomp, post-workout-recovery]
  persona_compatible: [hiit-enthusiast, group-fitness-devotee, body-recomp-seeker]
  evidence_bundles: []
  listings_hooks: [barrys-bootcamp, orange-theory, f45]
  venue_affinities: [barrys-bootcamp, orange-theory, f45, hiit-studios]
  icp_affinities: [fitness-enthusiast, athlete, casual]
  user_segments: [hiit-class-regular, any-wearable-user]
---

# Barry's Burn Balance

## Analysis Protocol

1. Pull `getActivityData`, `getSleepData`, `getSleepStages`, `getVitals`, `getBodyComposition` for 30 days.
2. Identify high-intensity session density and back-to-back stress patterns.
3. Measure recovery sufficiency from sleep architecture + HRV + resting HR.
4. Determine optimal class cadence and recovery insertions.
5. Create a weekly schedule template with red-flag overrides.

## Output Format
Current Burn Pattern -> Recovery Capacity -> Recommended Weekly Cadence -> Red-Flag Rules
