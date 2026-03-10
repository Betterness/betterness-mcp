---
name: thermal-recovery-orchestrator
description: Correlate temperature interventions with sleep quality and readiness
version: 1.0.0
author: betterness
category: sleep-recovery
requires:
  tools: [getSleepData, getSleepStages, getVitals, getActivityData]
  data: eight sleep + wearable recovery data (7+ days)
skillgraph:
  domains: [sleep, recovery, temperature, hrv]
  device_affinities: [eight-sleep, oura, whoop, garmin]
  activity_affinities: [strength, hiit, endurance]
  biomarker_affinities: []
  goals: [recovery, sleep-quality, performance]
  actions_enabled: [connect-device]
  connection_upsell: [connect-eight-sleep-for-temperature-control, connect-oura-for-sleep-staging, connect-whoop-for-hrv]
  complements: [sleep-environment-tuner, sleep-analyst, recovery-coach]
  persona_compatible: [biohacker, endurance-performance-coach, longevity-optimizer]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: [biohacker, athlete, longevity-optimizer]
  user_segments: [eight-sleep-user, oura-user, advanced-optimizer]
---

# Thermal Recovery Orchestrator

## Analysis Protocol

1. Pull `getSleepData`, `getSleepStages`, `getVitals`, and `getActivityData` for last 14 days.
2. Segment nights by thermal strategy (cooler, neutral, warmer).
3. Compare each segment on deep sleep, REM stability, overnight HRV, and next-day readiness proxies.
4. Control for workout load from prior day using `getActivityData`.
5. Rank thermal patterns by recovery quality and consistency.
6. Produce a 7-night thermal protocol with fallback adjustments.

## Output Format
Best Thermal Window -> Recovery Impact Score -> 7-Night Temperature Plan -> If/Then Adjustments
