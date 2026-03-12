# Module: Nearby Nutrition

## Purpose

Surfaces post-workout food options near the user's studio, filtered by dietary preferences, macronutrient needs, and time constraints. This is not a restaurant finder — it is a recovery nutrition tool that happens to use location data.

## When It Activates

- As part of the Post-Workout Recovery module output
- User asks "What should I eat?" or "Where should I go after class?"
- User asks for food near a specific studio location

## Data Sources

| Source | What It Provides |
|--------|-----------------|
| OpenClaw Maps | Restaurants, cafes, juice bars near studio |
| Local memory | Dietary preferences, allergies, favorite spots, past orders |
| Post-Workout Recovery | Macronutrient targets for current session type |
| Local memory | Time of day, schedule constraints |

## How It Works

### 1. Determine Nutrition Need
Based on class type and timing from Post-Workout Recovery:
- What macros are prioritized (protein-forward, carb-replenish, balanced)
- Time constraint (grab-and-go vs sit-down)
- Meal type (breakfast, lunch, dinner, snack)

### 2. Query Nearby Options
Via OpenClaw Maps, find options that are:
- Within 10-minute walk of the studio
- Open at the current time
- Match the user's dietary profile (vegan, gluten-free, etc.)

### 3. Rank and Recommend
Present 2–3 options, each with:
- **Name** — the restaurant or cafe
- **What to order** — specific menu item(s) that hit the macro targets
- **Walk time** — minutes from the studio
- **Why this one** — one line connecting it to the recovery need

### Favorites System
When the user mentions liking a spot or ordering from one repeatedly, store it in local memory. Prioritize favorites in future recommendations. Example: "You've hit Sweetgreen 4 times after Tuesday classes — your usual Harvest Bowl covers your protein and carb targets."

## Output Format

Keep it to 2–3 options max. Lead with the best match. If the user has a known favorite near this studio, lead with that.

```
**Sweetgreen** — Harvest Bowl (add chicken) — 4 min walk
Hits your 35g protein / 50g carb target. Your usual spot after Tuesday classes.

**Joe & The Juice** — Power shake + turkey sandwich — 2 min walk
Quick option if you're heading to work. 30g protein, ready in 5 min.
```

## What This Module Never Does

- Recommend places that conflict with known dietary restrictions
- Show more than 3 options (decision fatigue after a workout is real)
- Ignore the user's established favorites
- Treat this as a Yelp review — no ratings, no ambiance descriptions, just recovery fuel
- Recommend food that does not align with post-workout macronutrient needs
