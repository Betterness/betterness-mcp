# Athlete Overtraining Detector

## Overview
Uses HRV trends, resting heart rate changes, sleep quality degradation, and stress biomarkers (cortisol, CRP, testosterone) to detect overtraining syndrome before it derails your performance. Designed for endurance athletes, CrossFitters, and anyone pushing hard who needs an objective early warning system.

## MCP Tools Used
- `getVitals` — Track HRV trends, resting heart rate changes, and respiratory rate as primary overtraining signals
- `getSleepData` — Analyze sleep duration, efficiency, and quality decline as an early overtraining marker
- `getSleepStages` — Monitor deep sleep and REM suppression, which occur before performance declines
- `getActivityData` — Calculate training load, intensity distribution, and monotony scores
- `searchBiomarkers` — Pull cortisol, testosterone, CRP, CK (creatine kinase), ferritin, and free T3 if available
- `getBodyComposition` — Detect unexplained weight loss or muscle mass decline

## How It Works
1. **HRV Trend Analysis**: The gold standard for overtraining detection. The agent analyzes your 7-day HRV rolling average against your 30-day baseline. A sustained drop of more than 10% is an amber warning. More than 15% is a red flag. Critically, the agent also checks for HRV suppression (unusually LOW variability), which indicates parasympathetic saturation — a late-stage overtraining sign.
2. **Resting HR Deviation**: Tracks resting heart rate over 14-30 days. A rise of 5+ bpm above your rolling average, especially combined with HRV decline, is a strong overtraining signal.
3. **Sleep Architecture Disruption**: Overtraining paradoxically destroys sleep. The agent looks for declining deep sleep percentages, increased wake-after-sleep-onset (WASO), and reduced sleep efficiency — all of which precede performance drops by 1-2 weeks.
4. **Training Load Metrics**: Calculates acute:chronic workload ratio (ACWR). A ratio above 1.5 flags rapid load increases. Also computes training monotony (low variation = higher injury/overtraining risk).
5. **Hormonal Stress Markers**: If bloodwork is available, checks cortisol (elevated = acute overreach), testosterone (declining = deeper overtraining), T:C ratio (below 0.35 = significant concern), CRP (systemic inflammation), and CK (muscle damage).
6. **Overtraining Risk Score**: Generates a composite 0-10 score with classification: Fresh (0-2), Functional Overreach (3-5), Non-Functional Overreach (6-7), Overtraining Syndrome (8-10).

## Example Conversation
> **You:** My race times are getting worse even though I have been training more. Am I overtrained?
> **Agent:** The data suggests you are in a state of non-functional overreach, heading toward overtraining syndrome. Here is the evidence:
>
> **OVERTRAINING RISK SCORE: 7.2/10 (Non-Functional Overreach)**
>
> **HRV**: Your 7-day average is 34ms, down 22% from your 30-day baseline of 44ms. This has been declining steadily for 18 days. This is a significant and sustained drop.
>
> **Resting Heart Rate**: Has risen from 47 to 55 bpm over the last 3 weeks. An 8 bpm increase with declining HRV is a textbook overtraining pattern.
>
> **Sleep Destruction**: Despite spending 8 hours in bed, your sleep efficiency has dropped to 76% (was 89%). Deep sleep is down to 28 minutes/night from your baseline of 58 minutes. You are waking up 4-5 times per night. Your body cannot recover because your sleep is broken.
>
> **Training Load**: Your ACWR (acute:chronic workload ratio) is 1.72 — well above the 1.3 safety threshold. You ramped volume 40% over the last 3 weeks. Training monotony score is 2.8 (high — too many similar sessions, not enough variation).
>
> **Bloodwork Signals**: Cortisol is 24.8 mcg/dL (elevated), free testosterone has dropped 18% from 6 months ago, and CRP is 3.1 (elevated). Your hormonal profile confirms what the wearable data shows.
>
> **Recovery Protocol**:
> 1. **Immediate**: Reduce training volume by 60% for 10 days. Walk, swim, easy yoga only.
> 2. **Sleep**: Prioritize 9 hours in bed. No screens after 8 PM. Magnesium glycinate 400mg before bed.
> 3. **Nutrition**: Increase calories by 300-500/day. You are likely under-fueling. Increase carbs to 5g/kg bodyweight.
> 4. **Monitoring**: Track HRV daily. Do not resume hard training until your 7-day HRV average returns to within 5% of your 30-day baseline.
> 5. **Retest**: Repeat cortisol and testosterone in 4 weeks.

## Best With
- Oura Ring, Garmin, or Whoop for continuous HRV and resting HR tracking
- Sleep stage data (Oura is best for this)
- Training log with intensity data (Garmin, Strava, TrainingPeaks)
- Blood panel: cortisol (AM), testosterone (free + total), CRP, CK, ferritin

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Analyze my HRV, resting heart rate, sleep quality, and training load over the last 30 days. Am I overtrained? Calculate my acute:chronic workload ratio and give me an overtraining risk score. If I am overreaching, tell me exactly how long to rest and what to monitor before returning to hard training."
