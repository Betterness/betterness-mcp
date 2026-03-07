# Immune System Check

## Overview
Evaluates overall immune readiness by analyzing white blood cell counts, lymphocyte subsets, inflammatory markers, vitamin D status, and lifestyle factors that modulate immune function. Ideal before travel, during cold/flu season, or when you want to understand why you keep getting sick.

## MCP Tools Used
- `searchBiomarkers` — Pull WBC, lymphocytes, neutrophils, monocytes, hs-CRP, ESR, vitamin D, zinc, ferritin, and immunoglobulin levels if available
- `getSleepData` — Assess sleep duration and quality; sleep deprivation suppresses natural killer cell activity by up to 70%
- `getSleepStages` — Monitor deep sleep specifically, during which the immune system produces cytokines and T-cells
- `getVitals` — Track HRV (marker of autonomic balance affecting immune regulation) and resting heart rate
- `getActivityData` — Evaluate exercise load; moderate exercise boosts immunity while overtraining suppresses it
- `getBodyComposition` — Assess body fat, since both excess and insufficient body fat impair immune function

## How It Works
1. **White Blood Cell Analysis**: Reviews total WBC count and differential. Low WBC (<4.0) may indicate immune suppression. Elevated WBC (>10.0) suggests active infection or chronic inflammation. Examines the neutrophil-to-lymphocyte ratio (NLR) — above 3.0 indicates immune stress.
2. **Immune Support Nutrients**: Checks vitamin D (below 30 ng/mL impairs T-cell activation), zinc (below 70 mcg/dL reduces immune response), ferritin (both low and very high affect immunity), and B12/folate (required for immune cell production).
3. **Inflammation Baseline**: Analyzes hs-CRP and ESR. Chronic low-grade inflammation (CRP 1-3) diverts immune resources and increases susceptibility to infections. The agent identifies what is driving the inflammation.
4. **Sleep-Immune Connection**: Quantifies your sleep debt and its immune impact. Less than 7 hours of sleep reduces antibody response to vaccines by 50% and natural killer cell activity by 70%. Deep sleep is specifically when the immune system does its heaviest work.
5. **Exercise-Immune Balance**: Moderate exercise (30-60 min at moderate intensity) enhances immune surveillance. But training over 90 minutes at high intensity creates an "open window" of immune suppression lasting 3-72 hours. The agent calculates your current position on this curve.
6. **Immune Readiness Score**: Generates a composite score from bloodwork, sleep, activity, and stress markers. Classifies as Strong, Adequate, Compromised, or Suppressed with specific actions for each level.

## Example Conversation
> **You:** I keep catching every cold that goes around the office. Can you figure out why my immune system is underperforming?
> **Agent:** Let me build a complete picture of your immune status from labs and lifestyle data.
>
> **IMMUNE READINESS: Compromised (52/100)**
>
> **Blood Markers**:
> | Marker | Your Value | Optimal | Status |
> |--------|-----------|---------|--------|
> | WBC | 4.2 x10^9/L | 4.5-11.0 | LOW-NORMAL |
> | Lymphocytes | 1.1 x10^9/L | 1.5-4.0 | LOW |
> | Neutrophil/Lymphocyte Ratio | 3.8 | <3.0 | ELEVATED |
> | Vitamin D | 19 ng/mL | 40-60 | DEFICIENT |
> | Ferritin | 22 ng/mL | 50-150 | LOW |
> | hs-CRP | 2.1 mg/L | <1.0 | ELEVATED |
>
> **Root Causes Identified**:
> 1. **Vitamin D deficiency (19 ng/mL)** — This is your biggest immune gap. Vitamin D activates T-cells, and at your level, your adaptive immune response is significantly impaired. This single factor could explain your recurrent infections.
> 2. **Low lymphocytes (1.1)** — Your infection-fighting cells are below optimal. Combined with the high NLR of 3.8, your immune system is in a stressed, inflammation-biased state rather than a surveillance-ready state.
> 3. **Sleep**: Averaging 5.9 hours with deep sleep of only 32 minutes. At this level, your natural killer cell activity is estimated to be 40-50% below optimal. This is the lifestyle factor most suppressing your immunity.
> 4. **Low ferritin**: Iron is required for lymphocyte proliferation. At 22, your immune cells literally cannot multiply fast enough to fight off infections.
>
> **Immune Restoration Protocol**:
> 1. **Vitamin D3**: 5,000 IU daily with K2 and a fat source (8-week loading)
> 2. **Sleep**: Non-negotiable 7.5+ hours. This is the single fastest way to restore NK cell activity
> 3. **Iron**: Ferrous bisglycinate 25mg daily with vitamin C (retest in 8 weeks)
> 4. **Zinc**: 15-30mg daily (zinc picolinate) — supports lymphocyte production
> 5. **Exercise adjustment**: Keep workouts under 60 min at moderate intensity until immunity improves. No high-intensity sessions exceeding 75 min.
> 6. **Retest**: CBC with differential, vitamin D, and ferritin in 8 weeks

## Best With
- CBC with differential (WBC, lymphocytes, neutrophils, monocytes, eosinophils)
- Vitamin D, zinc, ferritin, B12
- Inflammatory markers: hs-CRP, ESR
- Any wearable with sleep and HRV tracking

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Run a full immune system check. Analyze my white blood cell counts, vitamin D, iron, zinc, and inflammatory markers. Cross-reference with my sleep quality and exercise load. Give me an immune readiness score and tell me exactly why I keep getting sick and how to fix it."
