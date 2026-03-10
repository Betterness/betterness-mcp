---
name: cardio-load-readiness-gate
description: Daily green/yellow/red readiness gating for endurance load decisions
version: 1.0.0
author: betterness
category: fitness-performance
requires:
  tools: [getActivityData, getSleepData, getVitals]
  data: training + sleep + recovery data (14+ days)
skillgraph:
  domains: [training-readiness, cardio, recovery, hrv]
  device_affinities: [garmin, whoop, oura, apple-health]
  activity_affinities: [running, cycling, rowing, triathlon, cardio]
  biomarker_affinities: []
  goals: [performance, injury-prevention, recovery, endurance]
  actions_enabled: [connect-device]
  connection_upsell: [connect-garmin-for-training-load, connect-whoop-for-strain, connect-oura-for-readiness]
  complements: [recovery-coach, endurance-optimizer, athlete-overtraining-detector, intensity-distribution-coach]
  persona_compatible: [endurance-performance-coach, triathlete, runner]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: [running-clubs, triathlon-clubs, cycling-studios]
  icp_affinities: [athlete, endurance-athlete, biohacker]
  user_segments: [garmin-user, endurance-athlete, active-athlete]
---

# Cardio Load Readiness Gate

## Analysis Protocol

1. Pull `getActivityData`, `getSleepData`, `getVitals` for 21 days.
2. Compute rolling training load and monotony.
3. Assess overnight recovery (HRV, resting HR, sleep quality).
4. Produce daily readiness state (green/yellow/red).
5. Map each state to precise training action for that day.

## Output Format
Readiness State -> Why -> Today's Session Rule -> Recovery Safeguard
