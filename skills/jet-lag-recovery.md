# Jet Lag Recovery Protocol

## Overview
Uses sleep stage data, HRV patterns, activity timing, and circadian rhythm indicators to build a personalized jet lag recovery plan when crossing time zones. Tracks your real-time adaptation progress and tells you exactly when to seek light, when to avoid it, when to sleep, and when to exercise to reset your body clock as fast as possible.

## MCP Tools Used
- `getSleepData` — Track sleep timing, duration, and efficiency as the primary measure of circadian adaptation
- `getSleepStages` — Monitor deep sleep and REM timing shifts; these stages must align with the new timezone for full adaptation
- `getVitals` — Track HRV recovery (jet lag suppresses HRV), resting heart rate, and body temperature rhythm as circadian markers
- `getActivityData` — Analyze activity timing to optimize light exposure and exercise as circadian reset tools
- `searchBiomarkers` — Pull cortisol (if available) to assess adrenal stress from timezone disruption, plus melatonin precursors

## How It Works
1. **Timezone Shift Calculation**: Determines the number of hours shifted and direction (eastward is harder — your body must advance its clock; westward is easier — you delay). Calculates expected adaptation time: roughly 1 day per timezone eastward, 0.7 days per timezone westward.
2. **Pre-Travel Baseline**: Captures your normal sleep-wake timing, HRV baseline, and circadian pattern from the last 7 days. This establishes what "adapted" looks like for you.
3. **Real-Time Adaptation Tracking**: After arrival, monitors sleep onset time, wake time, deep sleep timing, and HRV recovery to measure how quickly your circadian clock is shifting. Deep sleep and REM should progressively shift toward their new-timezone optimal windows.
4. **Light Exposure Protocol**: Calculates your critical light exposure and avoidance windows based on your origin timezone, destination timezone, and current adaptation state. Getting this wrong (light at the wrong time) can delay adaptation or shift you in the wrong direction.
5. **Activity and Meal Timing**: Exercise and meals are secondary circadian zeitgebers (time-givers). The agent schedules these to reinforce the light protocol.
6. **Supplement Timing**: Calculates precise melatonin timing (0.5-3mg, timed to the new timezone's desired sleep onset) and optional caffeine cutoff to accelerate adaptation without disrupting sleep.

## Example Conversation
> **You:** I just landed in Tokyo from New York (13 hours ahead). I feel terrible. Help me recover as fast as possible.
> **Agent:** A 13-hour eastward shift is one of the hardest jet lag scenarios. Without intervention, full adaptation takes 10-13 days. With an optimized protocol, we can compress that to 5-7 days. Let me check your current state.
>
> **Your Current State** (Day 1 in Tokyo, arrived 3 PM local):
> - Last sleep: 4.2 hours on the plane, sleep efficiency 51%, minimal deep sleep
> - HRV: 29ms (down 38% from your baseline of 47ms)
> - Resting HR: 68 bpm (up from baseline 54 — stress response + dehydration)
> - Your body thinks it is 2 AM (New York time) right now
>
> **Day 1 Protocol (today)**:
> - **NOW (3 PM Tokyo / 2 AM your body clock)**: Stay awake. Get outside in bright light immediately. Walk for 30+ minutes. This is critical — afternoon light in Tokyo will push your clock forward.
> - **5 PM**: Light meal, high protein. Eating on local schedule helps reset peripheral clocks.
> - **7 PM**: Light exercise (20 min walk). Do NOT do intense exercise — your body is too stressed.
> - **8 PM**: Dim all lights. Begin wind-down.
> - **9 PM Tokyo**: Take 1mg melatonin. Target sleep at 9:30-10 PM local. Yes, this is early — your body will cooperate because it is exhausted.
> - **AVOID**: Bright screens and overhead lights after 7 PM. No caffeine after 12 PM local.
>
> **Day 2 Protocol**:
> - Wake at 6:30 AM local (set alarm, do not sleep past 7 AM regardless of how you feel)
> - Immediate bright light exposure: 30 min outdoor walk
> - Coffee is allowed before 11 AM only
> - Exercise: Moderate session before 2 PM (shifts clock forward)
> - Melatonin 0.5mg at 9 PM
>
> **Days 3-5**: I will adjust the protocol daily based on your sleep data. Key metrics I am tracking:
> - Sleep onset time (should shift ~1-2 hours toward target each day)
> - Deep sleep timing (should move into the first third of the night)
> - HRV recovery (expect it to return to within 10% of baseline by day 4-5)
>
> **Adaptation Progress**: I will give you a daily "circadian alignment score" from 0-100%. You will know exactly where you stand each morning.

## Best With
- Oura Ring (best for sleep stage timing and body temperature rhythm)
- Any wearable with sleep and HRV tracking
- Light therapy glasses (Luminette, Re-Timer) for controlled light exposure
- Travel across 5+ time zones for maximum benefit

## Try It
Paste this into ChatGPT, Claude, or any AI with Betterness MCP connected:
> "I just traveled from [origin city] to [destination city]. Analyze my current sleep and HRV data to determine how jet lagged I am. Give me a day-by-day recovery protocol with exact times for light exposure, meals, exercise, and melatonin. Track my adaptation progress each morning."
