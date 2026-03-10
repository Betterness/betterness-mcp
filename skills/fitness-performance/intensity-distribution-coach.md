---
name: intensity-distribution-coach
description: Optimize high/low intensity balance to improve adaptation and reduce burnout
version: 1.0.0
author: betterness
category: fitness-performance
requires:
  tools: [getActivityData, getVitals, getSleepData]
  data: workout intensity history + recovery metrics
skillgraph:
  domains: [training-load, intensity, recovery, adaptation]
  device_affinities: [garmin, whoop, oura, apple-health]
  activity_affinities: [running, cycling, crossfit, hiit, endurance, strength]
  biomarker_affinities: []
  goals: [performance, recovery, injury-prevention, adaptation]
  actions_enabled: [connect-device]
  connection_upsell: [connect-garmin-for-hr-zones, connect-whoop-for-strain-score, connect-oura-for-readiness]
  complements: [cardio-load-readiness-gate, endurance-optimizer, athlete-overtraining-detector, recovery-coach]
  persona_compatible: [endurance-performance-coach, crossfit-athlete, runner]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: [crossfit-boxes, running-clubs, cycling-studios]
  icp_affinities: [athlete, endurance-athlete, fitness-enthusiast]
  user_segments: [garmin-user, active-athlete, any-wearable-user]
---

# Intensity Distribution Coach

## Analysis Protocol

1. Pull `getActivityData`, `getVitals`, and `getSleepData` for 4 weeks.
2. Estimate intensity distribution (easy/moderate/hard) from available workout data.
3. Correlate distribution with HRV trend and sleep-stage resilience.
4. Identify overconcentration in medium/high intensity.
5. Deliver a corrected weekly distribution plan.

## Output Format
Current Distribution -> Adaptation Cost -> Corrected Weekly Mix -> Monitoring Triggers
