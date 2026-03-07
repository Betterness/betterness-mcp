# Iron Deficiency Detective

## Overview
Tracks the full iron panel — ferritin, serum iron, TIBC, transferrin saturation, and hemoglobin — to detect early-stage iron deficiency before it becomes full-blown anemia. Especially valuable for endurance athletes, women of reproductive age, and anyone experiencing unexplained fatigue, hair loss, or declining performance.

## MCP Tools Used
- `searchBiomarkers` — Pull ferritin, serum iron, TIBC, transferrin saturation, hemoglobin, hematocrit, MCV, and RDW
- `getActivityData` — Assess training volume and intensity, as endurance exercise accelerates iron loss through foot-strike hemolysis and sweat
- `getVitals` — Monitor resting heart rate trends; rising resting HR with stable fitness often signals declining iron stores
- `getSleepData` — Correlate iron status with sleep quality; iron deficiency disrupts sleep architecture
- `getLoincCodes` — Identify LOINC codes for specialized iron studies and reticulocyte counts
- `listAvailableLabTests` — Recommend specific iron panel tests if key markers are missing

## How It Works
1. **Full Iron Panel Review**: Pulls ferritin, serum iron, TIBC, transferrin saturation, hemoglobin, hematocrit, MCV, and RDW. Ferritin below 30 ng/mL flags early depletion even if hemoglobin is normal (stage 1 deficiency).
2. **Stage Classification**: Classifies iron status into four stages — Optimal (ferritin 50-150), Depleted Stores (ferritin <30, normal Hgb), Iron-Deficient Erythropoiesis (low transferrin sat, rising TIBC), and Iron Deficiency Anemia (low Hgb + low ferritin).
3. **Athletic Impact Assessment**: For athletes, cross-references training volume with iron markers. Runners doing 30+ miles/week lose iron at 2-3x the rate of sedentary individuals. The agent calculates risk based on your specific volume.
4. **Resting HR Trend Analysis**: A rising resting heart rate over 4-8 weeks with no change in fitness load is one of the earliest wearable-detectable signs of iron depletion. The agent flags this pattern.
5. **Confounding Factor Check**: Elevated ferritin with low iron can indicate inflammation masking true deficiency. The agent checks CRP to differentiate.
6. **Repletion Protocol**: Recommends iron form (ferrous bisglycinate for absorption), timing (away from coffee, tea, calcium), vitamin C co-administration, and retest intervals based on deficiency stage.

## Example Conversation
> **You:** I have been dragging through my runs lately and my times are getting worse. Could it be iron related?
> **Agent:** Strong possibility. Let me check your iron markers and training data.
>
> **Iron Panel**:
> | Marker | Your Value | Optimal Range | Status |
> |--------|-----------|---------------|--------|
> | Ferritin | 18 ng/mL | 50-150 | LOW |
> | Serum Iron | 52 mcg/dL | 60-170 | Low-normal |
> | TIBC | 410 mcg/dL | 250-370 | ELEVATED |
> | Transferrin Sat | 13% | 20-50% | LOW |
> | Hemoglobin | 12.8 g/dL | 12.0-15.5 | Normal |
>
> **Diagnosis: Stage 2 Iron Deficiency** (iron-deficient erythropoiesis). Your stores are depleted AND your body is struggling to deliver iron to red blood cells. Hemoglobin is still normal, so you are not anemic yet — but you are on the path.
>
> **Training Factor**: You are running 35 miles/week with 3 tempo sessions. At this volume, you are likely losing 1.5-2mg of iron daily through foot-strike hemolysis and sweat. That exceeds what most diets can replace.
>
> **Wearable Signal**: Your resting HR has risen from 48 to 54 bpm over the last 6 weeks despite consistent training. This is a classic early iron depletion signal.
>
> **Repletion Plan**:
> 1. Ferrous bisglycinate 25mg twice daily, taken with vitamin C (500mg) on an empty stomach
> 2. Avoid coffee/tea within 2 hours of supplementation
> 3. Reduce high-intensity sessions to 2x/week until ferritin reaches 50+
> 4. Retest full iron panel in 8 weeks (ferritin responds slowly)

## Best With
- Complete iron panel: ferritin, serum iron, TIBC, transferrin saturation, hemoglobin, hematocrit
- CBC with differential (MCV, RDW for microcytic anemia detection)
- hs-CRP (to rule out inflammation-elevated ferritin)
- Any wearable with resting heart rate tracking (Oura, Garmin, Apple Watch, Whoop)

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Run an iron deficiency analysis on my latest blood work. Check ferritin, iron, TIBC, and hemoglobin. Cross-reference with my training load and resting heart rate trends. Tell me what stage I am at and what to do about it."
