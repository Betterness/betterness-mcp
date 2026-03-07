# Liver Health Check

## Overview
Monitors liver enzyme levels (ALT, AST, GGT, ALP), bilirubin, and albumin alongside lifestyle factors like alcohol intake context, medication use, body composition, and metabolic markers to assess liver health. Especially relevant given the rise of non-alcoholic fatty liver disease (NAFLD), which now affects 25% of adults globally and is closely tied to metabolic syndrome.

## MCP Tools Used
- `searchBiomarkers` — Pull ALT, AST, GGT, ALP, bilirubin (total and direct), albumin, total protein, ferritin, fasting glucose, HbA1c, triglycerides, and HDL
- `getBodyComposition` — Assess body fat percentage and visceral fat; NAFLD is driven by visceral adiposity
- `getActivityData` — Evaluate exercise volume, which directly reduces liver fat independent of weight loss
- `getSleepData` — Monitor sleep patterns; sleep apnea and short sleep are independent risk factors for liver disease
- `getVitals` — Track HRV and resting heart rate as systemic health indicators
- `getBiologicalAge` — Contextualize liver health within overall biological aging

## How It Works
1. **Enzyme Pattern Analysis**: ALT and AST individually mean little — the pattern matters. ALT above 30 U/L (men) or 19 U/L (women) using updated thresholds flags concern even if the lab says "normal." The AST/ALT ratio helps differentiate causes: ratio below 1 suggests fatty liver, above 2 suggests alcohol-related damage.
2. **GGT as the Early Warning**: GGT is often the first enzyme to rise in liver stress and is highly sensitive to both alcohol and metabolic dysfunction. Elevated GGT with normal ALT/AST is an early signal most doctors overlook.
3. **Metabolic Liver Risk (NAFLD Assessment)**: Cross-references liver enzymes with triglycerides, HDL, fasting glucose, HbA1c, and visceral fat. Calculates the Fatty Liver Index (FLI) and hepatic steatosis index where data permits. NAFLD is present in 70%+ of people with metabolic syndrome.
4. **Ferritin in Context**: Elevated ferritin can indicate liver inflammation (not just iron overload). The agent checks whether high ferritin correlates with elevated liver enzymes and inflammatory markers.
5. **Albumin and Synthetic Function**: Low albumin (<3.5 g/dL) indicates the liver is struggling to produce proteins. This is a late-stage finding but important to catch.
6. **Lifestyle Factor Assessment**: Evaluates exercise (both cardio and resistance training reduce liver fat), sleep (short sleep increases NAFLD risk by 40%), and body composition trends.

## Example Conversation
> **You:** My GGT keeps coming back high but my doctor says everything else is normal. Should I be concerned?
> **Agent:** Yes, isolated GGT elevation is a real signal that deserves investigation, not dismissal. Let me pull the full picture.
>
> **Liver Panel**:
> | Marker | Your Value | Optimal | Standard "Normal" | Status |
> |--------|-----------|---------|-------------------|--------|
> | ALT | 34 U/L | <30 (men) | <56 | BORDERLINE* |
> | AST | 28 U/L | <30 | <40 | Normal |
> | GGT | 68 U/L | <30 | <65 | ELEVATED |
> | ALP | 72 U/L | 44-147 | <147 | Normal |
> | Bilirubin | 0.8 mg/dL | 0.1-1.2 | <1.2 | Normal |
> | Albumin | 4.2 g/dL | 3.5-5.5 | >3.5 | Normal |
>
> *Your doctor said ALT of 34 is "normal" because the lab range goes to 56. But updated clinical guidelines set the optimal cutoff at 30 for men. This is mildly elevated.
>
> **Metabolic Connection**:
> - Triglycerides: 178 mg/dL (elevated)
> - HDL: 38 mg/dL (low)
> - Fasting glucose: 98 mg/dL (high-normal)
> - Visceral fat: Elevated on your last body composition scan
>
> **Assessment: Early Non-Alcoholic Fatty Liver Disease (NAFLD)**. The pattern of elevated GGT + borderline ALT + metabolic dysfunction (high TG, low HDL, borderline glucose, visceral fat) is the classic NAFLD signature. This is the most common liver disease globally and is reversible with lifestyle intervention.
>
> **The Good News**: Albumin and bilirubin are normal, meaning liver synthetic function is preserved. You have caught this early.
>
> **Reversal Protocol**:
> 1. **Exercise**: Add 150+ minutes/week of moderate cardio. Exercise reduces liver fat by 20-30% even without weight loss. Resistance training 2x/week is equally effective.
> 2. **Visceral fat reduction**: Target 5-7% body weight loss over 12 weeks. This can normalize liver enzymes in 60%+ of NAFLD cases.
> 3. **Sleep**: Your average of 5.7 hours is an independent NAFLD risk factor. Target 7+ hours.
> 4. **Nutrition**: Reduce refined carbs and fructose (biggest dietary driver of liver fat). Mediterranean-style eating has the strongest evidence for NAFLD reversal.
> 5. **Retest**: Full liver panel + lipids in 90 days to track reversal.
>
> **Optional**: Request a liver ultrasound to quantify current fat content (FibroScan is even better if available). This gives a baseline to measure improvement against.

## Best With
- Liver panel: ALT, AST, GGT, ALP, bilirubin, albumin
- Metabolic markers: triglycerides, HDL, fasting glucose, HbA1c, fasting insulin
- Body composition with visceral fat measurement
- Any wearable with activity and sleep tracking
- Liver ultrasound or FibroScan for baseline quantification

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Analyze my liver health from my latest bloodwork. Check ALT, AST, GGT, and bilirubin using updated optimal ranges, not just standard lab normals. Cross-reference with my metabolic markers, body composition, and lifestyle data. Tell me if I am at risk for fatty liver disease and how to reverse it."
