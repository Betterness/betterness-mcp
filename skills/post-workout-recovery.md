# Post-Workout Recovery Analyzer

## Overview
Analyzes your recovery trajectory after intense training sessions by tracking HRV rebound, sleep stage quality, resting heart rate normalization, and next-day readiness metrics. Helps you understand how long you actually need to recover and whether your recovery strategies (nutrition, sleep, cold exposure) are working.

## MCP Tools Used
- `getVitals` — Track HRV recovery curve, resting heart rate normalization, respiratory rate, and skin temperature changes post-exercise
- `getSleepData` — Analyze post-workout sleep quality, which directly determines recovery speed
- `getSleepStages` — Monitor deep sleep and REM on workout nights versus rest days; deep sleep is when growth hormone peaks
- `getActivityData` — Identify the workout that triggered the recovery demand — intensity, duration, type
- `searchBiomarkers` — Pull CK (creatine kinase), cortisol, testosterone, and inflammatory markers if recent bloodwork exists
- `getBodyComposition` — Track acute weight changes (hydration) and longer-term muscle adaptation

## How It Works
1. **Workout Identification**: Pulls activity data to identify the triggering session — type (strength, HIIT, endurance), duration, heart rate zones, and estimated training load.
2. **HRV Recovery Curve**: Plots your HRV from the night of the workout through the following 48-72 hours. A healthy recovery shows HRV returning to baseline within 24-48 hours. Delayed recovery (>72 hours) flags insufficient recovery capacity.
3. **Sleep Quality on Workout Nights**: Late or intense workouts often suppress deep sleep. The agent compares sleep architecture on workout nights versus rest nights to identify if training timing is sabotaging recovery.
4. **Resting HR Normalization**: Tracks how quickly your resting heart rate returns to baseline after hard sessions. Faster normalization indicates better cardiovascular fitness and recovery capacity.
5. **Recovery Score**: Generates a 0-100 recovery score based on HRV rebound speed, sleep quality, resting HR normalization, and subjective readiness. Compares against your personal history.
6. **Protocol Optimization**: Identifies which recovery strategies correlate with faster recovery in YOUR data — not generic advice but patterns specific to you.

## Example Conversation
> **You:** I did heavy deadlifts and sprints yesterday. How am I recovering and when can I go hard again?
> **Agent:** Let me trace your recovery trajectory from yesterday's session.
>
> **Triggering Workout** (yesterday, 4:45 PM):
> - Type: Strength + HIIT hybrid
> - Duration: 72 minutes
> - Peak HR: 178 bpm (94% max)
> - Time in Zone 4-5: 18 minutes
> - Estimated training load: High
>
> **Recovery Timeline**:
> | Metric | Last Night | This Morning | Baseline | Status |
> |--------|-----------|-------------|----------|--------|
> | HRV | 28ms | 35ms | 46ms | 76% recovered |
> | Resting HR | 62 bpm | 58 bpm | 52 bpm | Still elevated |
> | Respiratory Rate | 16.2 | 15.4 | 14.1 | Slightly elevated |
> | Skin Temp | +0.6C | +0.3C | baseline | Elevated (inflammatory) |
>
> **Sleep Impact**: Last night you got 7.1 hours but your deep sleep was only 34 minutes (your average is 55). This is typical after late-afternoon high-intensity training — elevated cortisol and core temperature suppress deep sleep. Your REM was actually above average at 112 minutes, which is common as the body prioritizes neural recovery.
>
> **Recovery Verdict**: You are approximately 60% recovered. Based on your historical recovery patterns after similar sessions, you typically reach 90% by hour 44-48.
>
> **Recommendation**:
> - **Today**: Active recovery only — 20-30 min easy walk, mobility work, foam rolling
> - **Tomorrow morning**: Recheck HRV. If it is within 10% of your baseline (42+), you can do a moderate session. If still below, add another recovery day.
> - **Recovery boost**: Tonight, prioritize 8+ hours of sleep. Your deep sleep should normalize since you will not have trained today. Consider 10 min cold exposure (shown to reduce CK and accelerate your HRV rebound in previous data).
>
> **Pattern I have noticed**: Your recovery is consistently 30% faster when you train before 2 PM versus after 4 PM. The evening sessions suppress your deep sleep and delay HRV rebound by a full day.

## Best With
- Oura Ring (best for overnight HRV and sleep stages)
- Garmin or Whoop (continuous HRV and training load metrics)
- Apple Watch (workout HR zones + sleep)
- Blood panel: CK, cortisol (for heavy training blocks)

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "Analyze my recovery from yesterday's workout. Track my HRV rebound, sleep quality, and resting heart rate normalization. Tell me how recovered I am as a percentage, when I can train hard again, and whether my workout timing is hurting my recovery."
