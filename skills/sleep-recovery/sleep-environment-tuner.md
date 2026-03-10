---
name: sleep-environment-tuner
description: Tune sleep environment variables to improve restorative sleep
version: 1.0.0
author: betterness
category: sleep-recovery
requires:
  tools: [getSleepData, getSleepStages, getVitals]
  data: wearable sleep and vitals (10+ nights)
skillgraph:
  domains: [sleep, recovery, circadian, environment]
  device_affinities: [oura, eight-sleep, whoop, garmin]
  activity_affinities: [any]
  biomarker_affinities: []
  goals: [sleep-quality, recovery, deep-sleep]
  actions_enabled: [connect-device]
  connection_upsell: [connect-oura-for-sleep-staging, connect-eight-sleep-for-temperature, connect-whoop-for-hrv]
  complements: [sleep-analyst, thermal-recovery-orchestrator, morning-briefing]
  persona_compatible: [biohacker, longevity-optimizer, endurance-performance-coach]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: [biohacker, longevity-optimizer, sleep-focused]
  user_segments: [oura-user, eight-sleep-user, any-sleep-tracker]
---

# Sleep Environment Tuner

## Analysis Protocol

1. Pull `getSleepData`, `getSleepStages`, and `getVitals` for the last 21 days.
2. Identify nights with highest deep sleep and HRV versus worst 25% nights.
3. Detect timing and stage-fragmentation patterns that indicate environment mismatch.
4. Build a targeted environment protocol (temperature, timing, wind-down cadence).
5. Define measurable nightly success metrics.

## Output Format
Baseline Sleep Quality -> Friction Points -> Environment Tuning Plan -> 14-Day Validation Criteria
