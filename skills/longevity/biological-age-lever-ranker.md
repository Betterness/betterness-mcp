---
name: biological-age-lever-ranker
description: Rank the interventions most likely to improve biological age trajectory
version: 1.0.0
author: betterness
category: longevity
requires:
  tools: [getBiologicalAge, searchBiomarkers, getSleepData, getVitals, getActivityData, getBodyComposition, listAvailableLabTests]
  data: biological age + biomarkers + wearables
skillgraph:
  domains: [biological-age, longevity, biomarkers, sleep, activity, body-composition]
  device_affinities: [oura, garmin, whoop, withings, apple-health]
  activity_affinities: [any]
  biomarker_affinities: [albumin, alp, hs-crp, creatinine, fasting-glucose, hba1c, lymphocytes, mcv, rdw, wbc]
  goals: [biological-age-reduction, longevity, healthspan, prioritization]
  actions_enabled: [upload-lab-result, purchase-lab-test, connect-device]
  connection_upsell: [upload-biological-age-panel, purchase-longevity-panel, connect-oura-for-readiness]
  complements: [bio-age-reducer, longevity-protocol, heart-health-scorecard, metabolic-health, sleep-analyst]
  persona_compatible: [attia-inspired-longevity-strategist, biohacker, executive-optimizer]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: [longevity-optimizer, biohacker, executive]
  user_segments: [lab-result-uploader, advanced-optimizer, any-wearable-user]
---

# Biological Age Lever Ranker

## Analysis Protocol

1. Pull `getBiologicalAge` history and identify current delta vs chronological age.
2. Pull key contributors from `searchBiomarkers` and wearable context (`getSleepData`, `getVitals`, `getActivityData`, `getBodyComposition`).
3. Rank top levers by expected effect size and execution difficulty.
4. If data gaps block ranking, call `listAvailableLabTests` and propose exact panel.
5. Produce a 30/60/90 day lever roadmap.

## Output Format
Age Delta Snapshot -> Lever Ranking -> 30/60/90 Plan -> Required Retest Labs
