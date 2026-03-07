# Gut Health Optimizer

## Overview
Analyzes gut-related biomarkers, systemic inflammation markers, and lifestyle data to assess digestive health and its downstream effects on immunity, mood, and performance. Ideal for anyone dealing with bloating, food sensitivities, or chronic low-grade inflammation who wants data-driven dietary guidance.

## MCP Tools Used
- `searchBiomarkers` — Pull inflammatory markers (hs-CRP, ESR), nutrient absorption indicators (iron, B12, folate, vitamin D), and gut-linked metabolic markers (homocysteine, albumin)
- `getActivityData` — Correlate exercise type and intensity with GI symptom periods
- `getSleepData` — Assess sleep quality as a gut-brain axis indicator; poor sleep disrupts microbiome diversity
- `getVitals` — Track HRV trends as a proxy for autonomic stress load on the digestive system
- `getBodyComposition` — Monitor visceral fat, which both drives and is driven by gut inflammation
- `getLoincCodes` — Identify standardized codes for calprotectin, zonulin, and other specialized gut markers

## How It Works
1. **Biomarker Scan**: Pulls hs-CRP, ESR, ferritin, B12, folate, vitamin D, albumin, and homocysteine. Low absorption markers (B12, iron, folate) alongside elevated inflammation suggest gut permeability or malabsorption.
2. **Inflammation Correlation**: Cross-references inflammatory markers with sleep quality and HRV. Chronic sleep disruption raises CRP and degrades gut lining integrity.
3. **Activity Pattern Analysis**: Reviews exercise data for overtraining signals. High-intensity endurance training increases intestinal permeability ("leaky gut") — the agent flags this if CRP is elevated alongside heavy training loads.
4. **Visceral Fat Check**: Elevated visceral fat is both a cause and consequence of gut dysbiosis. The agent quantifies this relationship with body composition data.
5. **Nutrient Absorption Score**: Calculates a composite absorption score from B12, iron, folate, and vitamin D levels. Low scores trigger recommendations for gut healing protocols before adding supplements.
6. **Personalized Protocol**: Delivers a prioritized gut restoration plan covering elimination diet suggestions, targeted supplementation (L-glutamine, zinc carnosine, probiotics), sleep optimization, and training load adjustments.

## Example Conversation
> **You:** My bloating has been terrible the last few months. Can you check my gut health markers and see if anything connects?
> **Agent:** I pulled your recent labs and wearable data. Here is what stands out:
>
> **Inflammatory Markers**: Your hs-CRP is 2.8 mg/L (moderate — target is below 1.0). Ferritin is 189 ng/mL, which at your level could indicate inflammation rather than pure iron stores.
>
> **Absorption Red Flags**: Vitamin B12 is 312 pg/mL (low-normal; optimal is 500+), and your vitamin D is 24 ng/mL (insufficient). Iron is fine at 85 mcg/dL, but the combination of low B12 + low D with elevated CRP suggests malabsorption.
>
> **Sleep-Gut Connection**: Over the last 60 days, your average deep sleep is only 38 minutes per night (target: 60+). Your HRV has declined 12% over this period. Poor sleep is one of the strongest disruptors of gut barrier integrity.
>
> **Training Load**: You have been averaging 7.2 hours/week of running, with 3 sessions above 80% max HR. High-intensity endurance work at this volume is associated with increased intestinal permeability.
>
> **Priority Protocol**:
> 1. Reduce high-intensity sessions to 2x/week for 4 weeks (biggest lever for gut healing)
> 2. Target 7.5+ hours of sleep with a consistent 10:30 PM bedtime
> 3. Add L-glutamine 5g/day and zinc carnosine 75mg twice daily
> 4. Retest hs-CRP and B12 in 30 days to measure improvement

## Best With
- Blood panels including hs-CRP, B12, folate, vitamin D, ferritin, homocysteine
- Specialized gut panels: GI-MAP, calprotectin, zonulin (if available)
- Oura Ring or Garmin for sleep stages and HRV
- Any wearable with activity tracking for exercise load analysis

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Analyze my gut health using my latest biomarkers and wearable data. Look at inflammation markers, nutrient absorption levels, sleep quality, and training load. Tell me if my lifestyle is contributing to gut issues and give me a prioritized healing protocol."
