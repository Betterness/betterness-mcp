# Pre-Diabetes Monitor

## Overview
Tracks fasting glucose, HbA1c, fasting insulin, and HOMA-IR to detect insulin resistance and pre-diabetes early — often years before a standard doctor visit would flag it. Correlates metabolic markers with sleep, activity, and body composition data to identify the lifestyle drivers and provide a reversal protocol.

## MCP Tools Used
- `searchBiomarkers` — Pull fasting glucose, HbA1c, fasting insulin, triglycerides, HDL, and calculate HOMA-IR and TG/HDL ratio
- `getActivityData` — Assess exercise volume and intensity; even moderate daily walking dramatically improves insulin sensitivity
- `getSleepData` — Correlate sleep duration and quality with glucose regulation; sleep debt raises insulin resistance within days
- `getBodyComposition` — Track body fat percentage and visceral fat, the strongest modifiable risk factor for insulin resistance
- `getVitals` — Monitor resting heart rate as an indirect metabolic health indicator
- `getBiologicalAge` — Assess metabolic aging, as insulin resistance is a primary driver of accelerated biological age

## How It Works
1. **Metabolic Marker Analysis**: Pulls fasting glucose, HbA1c, and fasting insulin. Calculates HOMA-IR (fasting insulin x fasting glucose / 405). HOMA-IR above 1.9 indicates early insulin resistance, often missed by doctors who only check fasting glucose.
2. **TG/HDL Ratio**: Calculates triglycerides divided by HDL. A ratio above 2.0 is an independent predictor of insulin resistance and small dense LDL particles. This is one of the most powerful yet underused metabolic markers.
3. **Sleep-Glucose Connection**: Analyzes sleep duration and quality. Just 4 nights of 5-hour sleep reduces insulin sensitivity by 25-30%. The agent quantifies your specific sleep debt and its metabolic cost.
4. **Activity Impact Assessment**: Reviews daily step counts, moderate-to-vigorous exercise minutes, and post-meal activity. A 15-minute walk after meals reduces glucose spikes by 30-50%.
5. **Body Composition Risk**: Assesses body fat percentage and visceral fat index. Every 5% reduction in body fat can improve HOMA-IR by 20-40%.
6. **Risk Staging**: Classifies as Optimal, Early Insulin Resistance, Pre-Diabetes, or Diabetes-Range, with a clear reversal protocol for each stage.

## Example Conversation
> **You:** My doctor said my fasting glucose of 102 is "just barely high" and to watch it. Should I be more concerned?
> **Agent:** Your doctor is right that 102 mg/dL is technically just over the normal threshold (100), but let me look at the full picture — fasting glucose alone misses the early stages.
>
> **Metabolic Dashboard**:
> | Marker | Your Value | Optimal | Status |
> |--------|-----------|---------|--------|
> | Fasting Glucose | 102 mg/dL | 72-85 | ELEVATED |
> | HbA1c | 5.6% | <5.4% | PRE-DIABETIC RANGE |
> | Fasting Insulin | 14.2 uIU/mL | 2-6 | HIGH |
> | HOMA-IR | 3.57 | <1.0 | INSULIN RESISTANT |
> | Triglycerides | 168 mg/dL | <100 | ELEVATED |
> | HDL | 42 mg/dL | >60 | LOW |
> | TG/HDL Ratio | 4.0 | <2.0 | HIGH RISK |
>
> **Assessment: Active Insulin Resistance**. Your fasting glucose is the tip of the iceberg. Your fasting insulin of 14.2 and HOMA-IR of 3.57 show your pancreas is working overtime to keep glucose in range. The TG/HDL ratio of 4.0 confirms metabolic dysfunction.
>
> **Contributing Factors**:
> - Sleep: Averaging 5.8 hours/night over the last 30 days. This alone can increase insulin resistance by 25%.
> - Activity: 4,200 daily steps average. Below the 7,500 minimum for metabolic benefit.
> - Body composition: 28% body fat with elevated visceral fat index.
>
> **Reversal Protocol** (this IS reversible):
> 1. Increase sleep to 7+ hours (single biggest metabolic lever)
> 2. Walk 15 minutes after every meal (reduces post-meal glucose spikes 30-50%)
> 3. Reach 8,000+ daily steps
> 4. Target 5% body fat reduction over 12 weeks
> 5. Retest fasting insulin and HOMA-IR in 90 days — these will improve first

## Best With
- Blood panel: fasting glucose, HbA1c, fasting insulin, lipid panel (triglycerides, HDL)
- CGM (continuous glucose monitor) data for real-time glucose patterns
- Any wearable with activity and sleep tracking
- Body composition scale (InBody, Withings Body+)

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Analyze my metabolic health for insulin resistance. Check my fasting glucose, HbA1c, fasting insulin, and lipid ratios. Calculate my HOMA-IR and TG/HDL ratio. Cross-reference with my sleep, activity, and body composition data to tell me my real diabetes risk and how to reverse it."
