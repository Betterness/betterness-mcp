# Heart Health Scorecard

## Overview
Builds a comprehensive cardiovascular risk scorecard by combining lipid panels, inflammatory markers, blood pressure data, HRV, VO2 max estimates, and body composition into a single actionable assessment. Goes far beyond standard cholesterol checks to evaluate the actual drivers of heart disease — inflammation, metabolic health, and autonomic function.

## MCP Tools Used
- `searchBiomarkers` — Pull total cholesterol, LDL, HDL, triglycerides, ApoB, Lp(a), hs-CRP, homocysteine, fasting glucose, fasting insulin, and HbA1c
- `getVitals` — Retrieve resting heart rate, HRV, blood pressure (if available), and VO2 max estimates
- `getActivityData` — Assess weekly exercise volume, cardio minutes, and intensity distribution
- `getBodyComposition` — Evaluate body fat percentage, visceral fat, and lean mass as cardiovascular risk modifiers
- `getSleepData` — Analyze sleep duration and quality, both independent cardiovascular risk factors
- `getBiologicalAge` — Compare cardiovascular-driven biological age to chronological age

## How It Works
1. **Lipid Deep Dive**: Goes beyond total cholesterol. Calculates ApoB particle count (if available), remnant cholesterol (TC - HDL - LDL), TG/HDL ratio (insulin resistance proxy), and TC/HDL ratio. ApoB above 90 mg/dL and remnant cholesterol above 24 mg/dL are red flags most doctors miss.
2. **Inflammation Assessment**: hs-CRP is the strongest inflammatory predictor of cardiovascular events. The agent also checks homocysteine (vascular damage) and correlates with lifestyle factors driving inflammation.
3. **Functional Heart Data**: Analyzes resting heart rate (every 10bpm increase above 60 raises mortality risk 10-20%), HRV (autonomic flexibility), and VO2 max (the single strongest predictor of cardiovascular mortality). Integrates blood pressure if wearable data is available.
4. **Metabolic-Cardiac Link**: Checks fasting glucose, insulin, and HbA1c. Insulin resistance is a primary driver of atherogenic dyslipidemia (high TG, low HDL, small dense LDL).
5. **Composite Scoring**: Generates a 0-100 Heart Health Score across five domains — Lipids, Inflammation, Fitness, Metabolic, and Recovery. Each domain is weighted by evidence-based impact on cardiovascular outcomes.
6. **Risk-Stratified Protocol**: Delivers specific interventions ranked by impact for your individual risk profile. Someone with great lipids but poor HRV gets a different protocol than someone with high ApoB but excellent fitness.

## Example Conversation
> **You:** Give me a full heart health assessment. I want to know my real cardiovascular risk, not just "your cholesterol is fine."
> **Agent:** Here is your comprehensive Heart Health Scorecard pulling from labs, wearables, and body composition.
>
> **HEART HEALTH SCORECARD: 68/100**
>
> | Domain | Score | Key Findings |
> |--------|-------|-------------|
> | Lipids | 55/100 | ApoB 112 mg/dL (high), TG/HDL 2.8 (elevated) |
> | Inflammation | 72/100 | hs-CRP 1.4 (moderate), homocysteine 9.2 (good) |
> | Fitness | 82/100 | VO2 max 42 (above average), RHR 58 bpm |
> | Metabolic | 60/100 | Fasting insulin 11.2 (elevated), HbA1c 5.5% |
> | Recovery | 71/100 | HRV 48ms (moderate), 6.5 hrs avg sleep |
>
> **Top Risk Factors**:
> 1. **ApoB of 112 mg/dL** — This is the number of atherogenic particles in your blood. Optimal is below 80. This is your single most actionable cardiac risk factor.
> 2. **Insulin resistance** — Fasting insulin of 11.2 is driving your TG/HDL ratio up and likely producing small dense LDL particles (the dangerous kind). This is the root cause of your lipid pattern.
> 3. **Sleep deficit** — 6.5 hours average. Below 7 hours increases cardiovascular events by 20%.
>
> **Positive Findings**: Your VO2 max of 42 and resting HR of 58 indicate good cardiovascular fitness. Homocysteine is well-controlled. These are protective.
>
> **Priority Protocol**:
> 1. Address insulin resistance first (this will improve lipids downstream) — increase sleep to 7+ hours, add post-meal walks
> 2. Discuss ApoB-lowering strategy with your doctor if lifestyle changes do not bring it below 90 in 90 days
> 3. Increase Zone 2 cardio to 150 min/week to push VO2 max higher
> 4. Retest ApoB, fasting insulin, and hs-CRP in 90 days

## Best With
- Advanced lipid panel: ApoB, Lp(a), LDL-P (particle count), standard lipids
- Inflammatory markers: hs-CRP, homocysteine
- Metabolic: fasting glucose, fasting insulin, HbA1c
- Wearable with HRV, resting HR, VO2 max (Garmin, Apple Watch, Oura, Whoop)
- Blood pressure monitor (Withings BPM, Omron)

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Build me a comprehensive heart health scorecard. Analyze my lipid panel, inflammatory markers, metabolic markers, wearable cardiovascular data, and body composition. Score each domain out of 100, identify my top risk factors, and give me a prioritized protocol to improve my score."
