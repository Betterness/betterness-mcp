---
name: metabolic-stress-detector
description: Detect early metabolic stress before visible performance decline
version: 1.0.0
author: betterness
category: metabolic-cgm
requires:
  tools: [searchBiomarkers, getBodyComposition, getSleepData, getVitals, getActivityData, getBiologicalAge]
  data: biomarkers + wearables + body composition
skillgraph:
  domains: [metabolic, stress, sleep, hrv, body-composition, biological-age]
  device_affinities: [oura, garmin, withings, apple-health]
  activity_affinities: [any]
  biomarker_affinities: [fasting-glucose, fasting-insulin, triglycerides, hdl, hs-crp]
  goals: [metabolic-health, early-detection, recovery, longevity]
  actions_enabled: [upload-lab-result, purchase-lab-test, connect-device]
  connection_upsell: [upload-metabolic-panel, connect-oura-for-hrv, connect-withings-for-body-comp]
  complements: [metabolic-health, pre-diabetes-monitor, blood-sugar-optimizer, stress-resilience, body-comp-signal-separator]
  persona_compatible: [biohacker, longevity-optimizer, metabolic-optimizer, any]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: [biohacker, longevity-optimizer, any]
  user_segments: [lab-result-uploader, any-wearable-user]
---

# Metabolic Stress Detector

## Analysis Protocol

1. Pull metabolic labs via `searchBiomarkers` (glucose, insulin, triglycerides, HDL, CRP when available).
2. Pull `getBodyComposition`, `getSleepData`, `getVitals`, `getActivityData`, and `getBiologicalAge`.
3. Compute stress signatures: sleep debt + HRV suppression + visceral/body-fat drift + biomarker shifts.
4. Classify risk level and shortest path interventions.
5. Define retest timeline and objective recovery targets.

## Output Format
Risk Tier -> Driver Map -> 14-Day Intervention Stack -> Retest Plan
