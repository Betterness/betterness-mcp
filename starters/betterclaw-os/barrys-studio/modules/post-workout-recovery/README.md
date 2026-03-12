# Module: Post-Workout Recovery

## Purpose

Delivers a structured recovery plan within 30 minutes of class completion. Covers nutrition, hydration, mobility, and recovery actions tailored to the session and the week's context.

## When It Activates

- Heartbeat fires 30 minutes after a scheduled class end time
- User says "Just finished class" or similar
- User asks about post-workout nutrition or recovery

## Data Sources

| Source | What It Provides |
|--------|-----------------|
| Local memory | Class type, time, studio location, dietary preferences |
| Betterness Graph | Training load this week, recovery baseline |
| OpenClaw Maps | Nearby restaurants and cafes matching dietary preferences |
| Local memory | Food preferences, allergies, favorite post-workout spots |

## Output Structure

### Session Note (1 line)
Where this class fits in the week. Example: "Third session this week. One more Friday."

### Nutrition Plan
Specific macronutrient targets based on class type:
- **Floor & Tread**: 30–40g protein, 40–60g carbs within 60 min
- **Lift**: 30–40g protein, moderate carbs within 90 min
- **Double Floor**: 40g protein, 50–70g carbs within 60 min
- **Run**: 25–35g protein, 50–60g carbs within 45 min

Adjusts for time of day:
- Morning: quick options (shakes, grab-and-go) if heading to work
- Evening: full meal recommendations

### Nearby Food Options
2–3 options from OpenClaw Maps:
- Within 10-minute walk of the studio
- Filtered by user's dietary preferences
- Each with: name, what to order, walk time

### Recovery Actions
2–3 specific actions based on session and schedule:
- Hydration target in oz or mL
- Sleep priority if another class is tomorrow
- Mobility focus for muscle groups targeted in today's class
- Rest day guidance if tomorrow is off

## What This Module Never Does

- Give generic "eat protein and drink water" advice without quantities
- Recommend food that conflicts with known dietary preferences
- Ignore the difference between a 6am and 7pm class
- Suggest supplements without checking the user's current stack
- Overload the user — they just worked out, keep it tight
