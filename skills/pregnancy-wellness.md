# Pregnancy Wellness Monitor

## Overview
Tracks critical biomarkers during pregnancy — iron, folate, thyroid function, glucose, vitamin D, and blood pressure — alongside sleep and activity data to support a healthy pregnancy. Provides trimester-specific reference ranges (which differ significantly from non-pregnant ranges) and flags values that warrant discussion with your OB/GYN.

## MCP Tools Used
- `searchBiomarkers` — Pull ferritin, hemoglobin, folate, B12, TSH, free T4, fasting glucose, HbA1c, vitamin D, calcium, and blood type antibodies
- `getSleepData` — Monitor sleep duration and disruption patterns, which change dramatically each trimester
- `getSleepStages` — Track deep sleep decline (normal in third trimester) versus pathological disruption
- `getVitals` — Monitor resting heart rate (normally rises 10-20 bpm during pregnancy), HRV, and blood pressure
- `getActivityData` — Track activity levels and ensure appropriate movement for each trimester
- `getBodyComposition` — Monitor weight gain trajectory against recommended ranges

## How It Works
1. **Trimester-Adjusted Ranges**: All biomarker analysis uses pregnancy-specific reference ranges. For example, TSH optimal range shifts to 0.1-2.5 in first trimester (not the standard 0.4-4.0). Hemoglobin below 11.0 g/dL flags anemia (hemodilution is normal but true deficiency must be caught).
2. **Iron and Anemia Screening**: Pregnancy doubles iron requirements. The agent tracks ferritin (target: above 30, ideally above 50), hemoglobin, and MCV. Flags depletion early since iron deficiency anemia increases preterm birth risk.
3. **Thyroid Monitoring**: TSH and free T4 are critical. Subclinical hypothyroidism (TSH 2.5-4.0 in pregnancy) is common and linked to developmental concerns. The agent flags any values outside trimester-specific ranges.
4. **Gestational Diabetes Risk**: Analyzes fasting glucose, HbA1c, and any glucose tolerance test results. Tracks risk factors (BMI, age, family history, PCOS) and correlates with activity levels.
5. **Sleep Adaptation Tracking**: Sleep architecture changes dramatically during pregnancy. The agent differentiates normal third-trimester disruption from concerning patterns, and suggests position, timing, and comfort strategies.
6. **Activity Guidance**: Monitors daily movement and provides trimester-appropriate recommendations. Flags excessive intensity or concerning drops in activity.

## Example Conversation
> **You:** I am 24 weeks pregnant and just got bloodwork back. Can you make sure everything looks good for the baby?
> **Agent:** Congratulations — you are in your second trimester. I will analyze everything using pregnancy-specific reference ranges, which differ significantly from standard ranges.
>
> **Pregnancy Biomarker Panel (24 weeks)**:
> | Marker | Your Value | Pregnancy Range | Status |
> |--------|-----------|----------------|--------|
> | Hemoglobin | 10.8 g/dL | >11.0 | MILD ANEMIA |
> | Ferritin | 14 ng/mL | >30 (target 50+) | LOW |
> | Folate | 18.2 ng/mL | >5.0 | Good |
> | B12 | 380 pg/mL | >300 | Good |
> | TSH | 2.1 mIU/L | 0.3-3.0 (2nd tri) | Normal |
> | Free T4 | 1.1 ng/dL | 0.8-1.5 (2nd tri) | Normal |
> | Fasting Glucose | 88 mg/dL | <92 | Normal |
> | Vitamin D | 28 ng/mL | 40-60 | INSUFFICIENT |
>
> **Key Findings**:
> 1. **Iron deficiency anemia is developing.** Hemoglobin at 10.8 with ferritin at 14 means your iron stores are depleted. This is the most common nutritional deficiency in pregnancy and increases preterm risk. This needs immediate attention.
> 2. **Vitamin D is insufficient.** At 28 ng/mL, you are below the 40+ target for pregnancy. Low vitamin D is associated with increased gestational diabetes and preeclampsia risk.
> 3. **Thyroid is reassuringly normal.** TSH of 2.1 is well within second-trimester range.
> 4. **Glucose is excellent.** You are on track for your glucose tolerance test at 28 weeks.
>
> **Sleep Data**: You are averaging 6.2 hours with sleep efficiency of 72%. The drop from your pre-pregnancy baseline (7.5 hrs, 88% efficiency) is steeper than expected at 24 weeks. Consider a pregnancy pillow and elevating your head 15 degrees.
>
> **Recommendations**:
> 1. Discuss iron supplementation with your OB — ferrous bisglycinate 25-50mg daily with vitamin C is gentler on the stomach than ferrous sulfate
> 2. Increase vitamin D3 to 4,000 IU daily (safe in pregnancy, supported by multiple studies)
> 3. Your daily steps have dropped to 3,800 — try to maintain 5,000-7,000 for glucose management ahead of your GDM screen
> 4. Retest hemoglobin and ferritin in 4 weeks to confirm iron is responding
>
> **Disclaimer**: All findings should be reviewed with your OB/GYN or midwife. This analysis supplements but does not replace prenatal care.

## Best With
- Prenatal blood panels: CBC, ferritin, thyroid (TSH, free T4), vitamin D, glucose, folate, B12
- Glucose tolerance test results (24-28 weeks)
- Wearable with sleep and heart rate tracking (Oura, Apple Watch)
- Blood pressure cuff (Withings, Omron)

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "I am [X weeks] pregnant. Analyze my latest bloodwork using pregnancy-specific reference ranges. Check my iron, thyroid, glucose, vitamin D, and folate. Cross-reference with my sleep and activity data. Flag anything that needs attention and give me trimester-appropriate recommendations."
