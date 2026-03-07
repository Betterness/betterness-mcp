# Blood Sugar Optimizer

## Overview
Combines continuous glucose monitor (CGM) insights with wearable activity data, sleep patterns, and metabolic biomarkers to help you understand and optimize your glycemic responses. Identifies which meals spike you, which activities flatten your curve, and builds a personalized glucose optimization protocol. Valuable for anyone wearing a CGM (Levels, Dexcom, Libre) or tracking metabolic health.

## MCP Tools Used
- `searchBiomarkers` — Pull fasting glucose, HbA1c, fasting insulin, HOMA-IR, triglycerides, and HDL for metabolic context
- `getActivityData` — Correlate exercise timing, type, and intensity with glucose responses; post-meal walking is the most powerful glucose management tool
- `getSleepData` — Analyze how sleep duration and quality affect next-day glucose variability
- `getVitals` — Track resting heart rate and HRV as autonomic indicators of metabolic stress
- `getBodyComposition` — Assess body fat percentage and visceral fat, both drivers of insulin resistance
- `getBiologicalAge` — Contextualize metabolic health within overall biological aging

## How It Works
1. **Baseline Metabolic Assessment**: Pulls fasting glucose, HbA1c, fasting insulin, and calculates HOMA-IR. Establishes whether underlying insulin resistance is present, which determines the aggressiveness of the optimization protocol.
2. **Glucose Variability Analysis**: Analyzes CGM data patterns including time in range (70-140 mg/dL target), glycemic variability (standard deviation), dawn effect magnitude, and post-meal spike patterns. Optimal: 90%+ time in range with SD below 20 mg/dL.
3. **Meal-Response Mapping**: Identifies which meals and food combinations produce the largest glucose excursions. Ranks meals by peak glucose, time to peak, and area under the curve. This reveals personal glucose responses that vary dramatically between individuals.
4. **Exercise-Glucose Correlation**: Analyzes how different exercise types and timing affect glucose. Zone 2 cardio and post-meal walks are typically most effective. The agent quantifies the exact glucose reduction from your specific activities.
5. **Sleep-Glucose Connection**: Poor sleep dramatically worsens glucose control. The agent correlates sleep duration and quality with next-day glucose variability, providing specific evidence for YOUR body.
6. **Personalized Optimization Protocol**: Delivers meal ordering strategies (fiber/protein first), exercise timing recommendations, sleep targets, and supplement suggestions (berberine, chromium, cinnamon) based on your individual data patterns.

## Example Conversation
> **You:** I have been wearing a CGM for 2 weeks. Help me understand my glucose patterns and how to optimize them.
> **Agent:** Great — 2 weeks gives solid pattern data. Let me cross-reference your CGM trends with your activity, sleep, and baseline labs.
>
> **Glucose Overview (14 days)**:
> | Metric | Your Value | Optimal Target |
> |--------|-----------|---------------|
> | Time in Range (70-140) | 78% | >90% |
> | Average Glucose | 108 mg/dL | 85-100 |
> | Glucose Variability (SD) | 28 mg/dL | <20 |
> | Dawn Effect | +22 mg/dL | <10 |
> | Highest Spike | 187 mg/dL | <140 |
>
> **Your Top Glucose Spikers**:
> 1. **Oatmeal with banana** (breakfast) — average spike to 168 mg/dL, peak at 45 min. This "healthy" breakfast is your worst meal for glucose.
> 2. **Rice-based dinners** — average spike to 155 mg/dL when eaten without protein first.
> 3. **Afternoon snack (crackers/fruit)** — spikes to 148 mg/dL. Naked carbs without fat or protein.
>
> **What Flattens Your Curve**:
> 1. **Post-meal walks**: A 12-minute walk after dinner reduces your spike by an average of 34 mg/dL. This is your single most powerful tool.
> 2. **Protein-first meals**: When you eat protein before carbs, your spike is 25% lower on average.
> 3. **Morning exercise**: Days with morning workouts show 15% better time-in-range for the entire day.
>
> **Sleep Impact**: On nights with less than 6.5 hours of sleep, your next-day average glucose is 12 mg/dL higher and your dawn effect doubles from +22 to +41 mg/dL.
>
> **Optimization Protocol**:
> 1. Replace oatmeal breakfast with eggs + vegetables + small portion of berries (predicted spike: <120 vs 168)
> 2. Walk 10-15 minutes after lunch and dinner (you are already doing this 40% of the time — make it 90%)
> 3. Eat protein and vegetables BEFORE any carbs at every meal
> 4. Add 1 tbsp apple cider vinegar in water before carb-heavy meals (shown to reduce spikes 20-30%)
> 5. Prioritize 7+ hours of sleep to fix the dawn effect

## Best With
- CGM: Dexcom G7, Libre 3, Levels, Nutrisense
- Blood panel: fasting glucose, HbA1c, fasting insulin, lipid panel
- Any wearable with activity and sleep tracking
- Food logging app for meal correlation (MyFitnessPal, Cronometer)

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Analyze my glucose patterns from my CGM data and wearable. Identify my biggest glucose spikers and what flattens my curve. Correlate with my sleep quality, exercise timing, and meal patterns. Give me a ranked list of changes that will maximize my time in range."
