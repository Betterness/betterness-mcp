---
name: body-comp-signal-separator
description: Distinguish true body composition progress from measurement noise
version: 1.0.0
author: betterness
category: metabolic-cgm
requires:
  tools: [getBodyComposition, getActivityData, getSleepData, getVitals, searchBiomarkers]
  data: body composition trend + activity/recovery + optional labs
skillgraph:
  domains: [body-composition, metabolic, sleep, activity, signal-analysis]
  device_affinities: [withings, garmin, oura, apple-health]
  activity_affinities: [strength, any]
  biomarker_affinities: [fasting-glucose, hs-crp, fasting-insulin]
  goals: [body-composition, clarity, weight-management, fat-loss, muscle-gain]
  actions_enabled: [connect-device, upload-lab-result]
  connection_upsell: [connect-withings-for-body-composition, connect-garmin-for-activity, connect-oura-for-sleep]
  complements: [weight-volatility-explainer, body-recomp, metabolic-health, pre-diabetes-monitor]
  persona_compatible: [body-recomp-seeker, metabolic-optimizer, fitness-enthusiast, any]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: [any, fitness-enthusiast, casual]
  user_segments: [withings-user, any-wearable-user]
---

# Body Comp Signal Separator

## Analysis Protocol

1. Pull `getBodyComposition`, `getActivityData`, `getSleepData`, `getVitals` for 30 days.
2. Pull `searchBiomarkers` for glucose/CRP/insulin context when present.
3. Calculate trend confidence for fat %, weight, and lean mass.
4. Separate trend from noise using rolling windows and recovery context.
5. Recommend one nutrition lever and one training lever for next week.

## Output Format
Signal vs Noise Table -> Real Progress Verdict -> Next-Week Adjustment Plan
