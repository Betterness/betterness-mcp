# Skill: Class Readiness Assessment

## Trigger

User asks anything related to whether they should go to class, how hard to push, or pre-class preparation. Examples:

- "Should I go to class today?"
- "I have a 6pm Floor & Tread — am I ready?"
- "How should I approach today's class?"
- "I slept terribly, should I still go?"

## Input Requirements

Before responding, gather:

1. **Recovery state** — query Betterness Graph for last night's sleep score, HRV, resting heart rate, and recovery rating
2. **Recent training load** — check attendance and intensity from the last 3–5 days via local memory
3. **Class type** — Floor & Tread, Lift, Double Floor, Run — each has different recovery demands
4. **Schedule context** — what day of the week, what's coming later this week (upcoming classes booked)
5. **Soreness or injury flags** — check if user has logged any persistent soreness or movement restrictions

## Decision Framework

### Green Light — Go Hard
All of these are true:
- Sleep score ≥ 75 or HRV at or above personal baseline
- No class in the last 24 hours, or last class was low intensity
- No persistent soreness flags
- Not 3+ consecutive training days

Output: Confirm they're good to go. Mention one thing that's working well (e.g., "HRV is 12% above your baseline — your recovery from yesterday's class was fast").

### Amber — Dial to 80%
Any of these are true:
- Sleep score 55–74 or HRV 10–20% below baseline
- Trained yesterday at moderate-to-high intensity
- Third consecutive training day
- Minor soreness logged

Output: Recommend attending but scaling back. Be specific: "Go, but keep your tread speeds 10–15% below your usual push pace. Stay in Zone 3, skip Zone 5 intervals." Never say "listen to your body" — give numbers.

### Red — Skip & Recover
Any of these are true:
- Sleep score < 55 or HRV > 20% below baseline
- Resting heart rate elevated > 10% above baseline
- Fourth consecutive training day with no recovery day
- Active injury or significant soreness

Output: Recommend skipping without guilt. Suggest a specific alternative: "Skip today's class. Walk 30 minutes, stretch, hydrate. You have a Lift class Thursday — you'll get more out of it fresh." Always point to the next class on their schedule.

## Output Format

Start with the recommendation (Go Hard / Dial to 80% / Skip & Recover), then the reasoning in 2–3 sentences with specific numbers from their data. End with one actionable pre-class tip if attending (hydration, caffeine timing, warm-up focus) or one recovery action if skipping.

## What This Skill Never Does

- Say "listen to your body" without specific guidance
- Guilt the user for skipping
- Ignore recent training load and only look at sleep
- Recommend going hard after 3+ consecutive days with no recovery data to support it
- Make the decision dramatic — this is a Tuesday class, not a life choice
