# Vitamin D Tracker

## Overview
Monitors vitamin D (25-hydroxyvitamin D) levels and correlates them with sleep quality, immune markers, mood indicators, and bone health biomarkers. Vitamin D deficiency affects an estimated 42% of US adults and has downstream effects on virtually every body system. This skill helps you optimize levels and track your response to supplementation.

## MCP Tools Used
- `searchBiomarkers` — Pull 25-OH vitamin D, calcium, PTH (parathyroid hormone), magnesium, phosphorus, and immune markers (WBC, lymphocytes)
- `getSleepData` — Correlate vitamin D levels with sleep quality; deficiency is strongly linked to poor sleep
- `getSleepStages` — Analyze deep sleep percentage, which is particularly affected by vitamin D status
- `getVitals` — Track seasonal HRV patterns that may correlate with vitamin D fluctuations
- `getActivityData` — Assess outdoor activity levels as a proxy for sun exposure

## How It Works
1. **Vitamin D Level Assessment**: Pulls 25-OH vitamin D and classifies status — Deficient (<20 ng/mL), Insufficient (20-29), Adequate (30-50), Optimal (40-60), Potentially Excessive (>80).
2. **Supporting Mineral Check**: Reviews calcium, magnesium, and PTH. Elevated PTH with low vitamin D indicates the body is compensating by pulling calcium from bones. Low magnesium impairs vitamin D activation.
3. **Sleep Quality Correlation**: Cross-references vitamin D levels with sleep data. Studies show vitamin D below 20 ng/mL is associated with 35% less deep sleep. The agent quantifies this relationship with your data.
4. **Immune Readiness**: Checks WBC and lymphocyte counts alongside vitamin D. Optimal vitamin D supports T-cell activation and innate immune defense.
5. **Seasonal Pattern Analysis**: If historical data exists, tracks vitamin D across seasons and correlates with outdoor activity levels to estimate sun exposure contribution versus supplementation needs.
6. **Dosing Protocol**: Calculates supplementation dose based on current level, target (50 ng/mL), body weight, and absorption factors. Recommends D3 with K2 and a fat source for absorption.

## Example Conversation
> **You:** I got my vitamin D tested and it was 22. How bad is that and what should I do?
> **Agent:** A level of 22 ng/mL puts you in the "insufficient" range. It is not critically low, but it is far from optimal and is likely affecting your health in measurable ways. Let me cross-reference with your other data.
>
> **Sleep Impact**: Your average deep sleep over the last 30 days is 42 minutes/night. Research suggests you could gain 15-20 minutes of deep sleep by reaching optimal vitamin D levels (40-60 ng/mL). Your sleep efficiency is 81% — also likely depressed by this deficiency.
>
> **Supporting Markers**:
> - PTH: 58 pg/mL (slightly elevated, normal is <50). Your body is already compensating for low D by increasing parathyroid hormone, which pulls calcium from bones.
> - Magnesium: 1.9 mg/dL (low-normal). Magnesium is required to convert vitamin D to its active form. This may be limiting your response to any supplementation.
> - Calcium: 9.4 mg/dL (normal for now, but PTH trend is concerning)
>
> **Supplementation Protocol**:
> 1. Vitamin D3: 5,000 IU daily for 8 weeks (loading phase), then 3,000 IU maintenance
> 2. Always take with K2 (MK-7, 100mcg) to direct calcium to bones, not arteries
> 3. Take with your fattiest meal for 50% better absorption
> 4. Add magnesium glycinate 400mg at bedtime (fixes the activation bottleneck AND helps sleep)
> 5. Retest 25-OH vitamin D and PTH in 8 weeks — target: 50 ng/mL

## Best With
- Blood panel: 25-hydroxyvitamin D, PTH, calcium, magnesium, phosphorus
- Immune panel: CBC with differential
- Oura Ring or any wearable with sleep stage tracking
- Historical labs for seasonal trend analysis

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Check my vitamin D level and related markers like PTH, calcium, and magnesium. Correlate with my sleep quality data. Calculate the right supplementation dose to get me to optimal levels and tell me how it should improve my sleep."
