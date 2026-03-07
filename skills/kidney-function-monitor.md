# Kidney Function Monitor

## Overview
Tracks creatinine, BUN, eGFR, albumin-to-creatinine ratio, and electrolytes to monitor kidney health over time. Important for anyone taking NSAIDs regularly, managing high blood pressure, supplementing with creatine, or with family history of kidney disease. Provides early detection of declining function before symptoms appear.

## MCP Tools Used
- `searchBiomarkers` — Pull creatinine, BUN, eGFR, cystatin C, uric acid, albumin, potassium, sodium, phosphorus, and albumin-to-creatinine ratio (ACR)
- `getVitals` — Monitor blood pressure trends (hypertension is the second leading cause of kidney disease)
- `getActivityData` — Assess hydration context; intense exercise temporarily elevates creatinine
- `getBodyComposition` — Factor in muscle mass, which directly affects creatinine levels independent of kidney function
- `getSleepData` — Monitor sleep apnea indicators, which are linked to kidney disease progression
- `getLoincCodes` — Identify standardized codes for specialized renal function tests

## How It Works
1. **eGFR Assessment**: The primary kidney function metric. Above 90 is normal, 60-89 is mildly reduced, 30-59 is moderately reduced, below 30 is severe. The agent tracks trends over time — a declining eGFR, even within normal range, is more concerning than a single low value.
2. **Creatinine Contextualization**: Raw creatinine must be interpreted against muscle mass. A muscular athlete with creatinine of 1.3 is normal; the same value in a sedentary person may indicate impairment. The agent uses body composition data to contextualize.
3. **BUN/Creatinine Ratio**: Helps differentiate pre-renal (dehydration, heart failure), renal, and post-renal causes. Ratio above 20:1 suggests dehydration or upstream issues rather than intrinsic kidney disease.
4. **Early Damage Detection**: Checks albumin-to-creatinine ratio (ACR) if available. Microalbuminuria (ACR 30-300) is the earliest detectable sign of kidney damage, often appearing years before eGFR declines.
5. **Risk Factor Analysis**: Evaluates blood pressure trends, NSAID use context, creatine supplementation, hydration adequacy, and uric acid levels (both a cause and consequence of kidney stress).
6. **Electrolyte Balance**: Monitors potassium, sodium, and phosphorus, which become dysregulated as kidney function declines. Early electrolyte shifts can signal problems before eGFR drops.

## Example Conversation
> **You:** My creatinine came back at 1.4 and my doctor said it was "a little high." Should I be worried? I take creatine and lift heavy.
> **Agent:** Good question — creatinine interpretation depends heavily on context, and yours is more nuanced than your doctor may have conveyed. Let me analyze fully.
>
> **Kidney Function Panel**:
> | Marker | Your Value | Reference Range | Context |
> |--------|-----------|----------------|---------|
> | Creatinine | 1.4 mg/dL | 0.7-1.3 | See analysis |
> | eGFR | 72 mL/min | >90 normal | MILDLY REDUCED |
> | BUN | 18 mg/dL | 7-20 | Normal |
> | BUN/Creatinine Ratio | 12.9 | 10-20 | Normal |
> | Uric Acid | 7.2 mg/dL | 3.0-7.0 | SLIGHTLY HIGH |
> | Potassium | 4.6 mEq/L | 3.5-5.0 | Normal |
>
> **Context Matters**: Your body composition shows 82kg lean mass at 14% body fat. For someone with your muscle mass who takes creatine (5g/day), a creatinine of 1.4 is expected and does NOT necessarily indicate kidney dysfunction. Creatine supplementation alone raises serum creatinine by 0.1-0.3 mg/dL.
>
> **However — the eGFR of 72 warrants attention.** Even adjusting for your muscle mass, this is in the mildly reduced range. I want to see if this is:
> - Temporary: Were you tested after a heavy workout? Intense exercise raises creatinine for 24-48 hours.
> - A trend: Do you have previous values to compare? A single reading is insufficient.
> - A creatine artifact: Cystatin C-based eGFR is unaffected by muscle mass or creatine — I recommend requesting this test.
>
> **Risk Factors I am Monitoring**:
> - Blood pressure: Your average is 134/82 from your wearable. This is Stage 1 hypertension and the most common driver of kidney decline.
> - Uric acid at 7.2 is mildly elevated and can indicate kidney stress.
> - Your hydration may be inadequate — your average daily step count is 12,000+ with heavy training, but BUN/creatinine ratio suggests borderline hydration.
>
> **Action Plan**:
> 1. Request a cystatin C test — this gives a muscle-mass-independent eGFR estimate
> 2. Retest creatinine on a rest day, at least 48 hours after training, well-hydrated
> 3. Address blood pressure: target below 130/80 through sodium reduction and increased potassium intake
> 4. Increase water intake to 3-4L daily given your training volume
> 5. Continue creatine (it is safe for healthy kidneys) but monitor eGFR quarterly

## Best With
- Comprehensive metabolic panel: creatinine, BUN, eGFR, electrolytes
- Cystatin C (for muscle-mass-independent eGFR)
- Urinalysis with albumin-to-creatinine ratio
- Blood pressure monitor (Withings, Omron)
- Body composition scale for muscle mass context

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Analyze my kidney function markers — creatinine, BUN, and eGFR. Factor in my muscle mass and whether I take creatine. Check my blood pressure trends and hydration status. Tell me if my kidneys are healthy and what I should monitor going forward."
