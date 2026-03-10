---
name: weight-volatility-explainer
description: Explain short-term weight fluctuations using multi-signal context
version: 1.0.0
author: betterness
category: metabolic-cgm
requires:
  tools: [getBodyComposition, getSleepData, getVitals, getActivityData, searchBiomarkers]
  data: withings/body metrics + wearable recovery + optional labs
skillgraph:
  domains: [body-composition, weight, metabolic, sleep, activity, inflammation]
  device_affinities: [withings, garmin, oura, apple-health]
  activity_affinities: [any]
  biomarker_affinities: [hs-crp, fasting-glucose, fasting-insulin]
  goals: [body-composition, weight-management, metabolic-health, clarity]
  actions_enabled: [connect-device, upload-lab-result]
  connection_upsell: [connect-withings-for-body-composition, connect-oura-for-sleep, connect-garmin-for-activity]
  complements: [body-comp-signal-separator, metabolic-health, pre-diabetes-monitor, inflammation-tracker]
  persona_compatible: [body-recomp-seeker, metabolic-optimizer, any]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: [any, casual, fitness-enthusiast]
  user_segments: [withings-user, any-wearable-user]
---

# Weight Volatility Explainer

## Analysis Protocol

1. Pull `getBodyComposition`, `getSleepData`, `getVitals`, `getActivityData` for 14-30 days.
2. Use `searchBiomarkers` when available for inflammation/metabolic context.
3. Decompose weight swings into likely drivers: fluid, glycogen, inflammation, tissue change.
4. Flag mismatch cases (scale up while composition improves, etc.).
5. Generate 72-hour corrective plan and weekly guardrails.

## Output Format
Volatility Breakdown -> Signal Confidence -> 72-Hour Reset -> Weekly Stability Rules
