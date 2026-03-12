# Module: Fueling Calculator

Calculates calorie and hydration targets based on training volume, run distance, body weight, and environmental conditions.

## When Active

Shown on pre-long-run days and throughout race week. Also available on demand when the runner asks about fueling, nutrition, or hydration for any training session.

## Data Sources

- Betterness MCP: `getWearableData` (training load, heart rate data for calorie estimation, body metrics)
- Betterness Graph: fueling effectiveness history (what has worked at which distances and conditions), GI tolerance data, carb loading response patterns
- Local memory: body weight, fueling brand preferences (gel brand, flavor, caffeine preference), hydration habits, known GI sensitivities

## What It Calculates

- **Daily calorie target** — scaled to training volume and phase (higher in peak, adjusted in taper)
- **Pre-run fueling** — what and when to eat before training sessions
- **During-run fueling** — gel/calorie schedule by mile marker for long runs and race day
- **Post-run recovery fueling** — calorie and macro targets within the recovery window
- **Hydration targets** — water and electrolyte intake by distance and temperature
- **Carb loading protocol** — 2-3 day loading protocol for race week (grams/lb, food suggestions)

## Output

### Example — long run fueling

```
Fueling | Saturday Long Run — 18 miles

Pre-run (2-3 hours before):
  400-500 cal — oatmeal, banana, coffee. Nothing new.

During run:
  Mile 6: 1 gel (100 cal) + 6 oz water
  Mile 9: 6 oz water + electrolytes
  Mile 12: 1 gel (100 cal) + 6 oz water
  Mile 15: 6 oz water + electrolytes
  Mile 16: 1 gel (100 cal) + 6 oz water

Total during-run intake: ~300 cal, 36+ oz fluid

Post-run (within 45 min):
  600 cal — 3:1 carb:protein ratio
  Rehydrate: 20-24 oz per lb lost
```

### Example — carb loading protocol

```
Carb Loading | Race Week Thursday-Saturday

Target: 3.5g carbs per lb body weight per day
At 160 lbs: ~560g carbs/day

Meal ideas (all tested, nothing new):
  Breakfast: Oatmeal + banana + honey + toast (120g)
  Snack: Pretzels + sports drink (60g)
  Lunch: Rice + chicken + bread (140g)
  Snack: Bagel + jam (80g)
  Dinner: Pasta + bread + juice (160g)

Hydrate aggressively. Urine should be pale yellow.
Expect to feel bloated — that is the glycogen loading.
You will be glad you did this at mile 22.
```

### Example — heat adjustment

```
Fueling Adjustment | Race Day — 78F forecast

Heat increases fluid and electrolyte needs significantly.
Adjusted plan:
  Water at every aid station (not every other)
  Extra electrolyte serving at miles 9 and 18
  Consider pre-loading with electrolytes race morning
  Pace adjustment: +10-15 sec/mi to manage heat stress

Your gel schedule stays the same. Your body needs the
calories regardless of temperature.
```

## Rules

- Fueling is by mile marker, not by time — runners track miles, not minutes
- Always specify tested foods only — "nothing new" is a non-negotiable rule for race day
- Hydration targets adjust for temperature: add 25% fluid above 70F, 50% above 80F
- Carb loading is specific: grams per pound, food examples, day-by-day
- Post-run recovery window is explicit: calories, ratio, timing
- Never recommend specific supplement brands unless the runner has established preferences
- Keep the fueling plan under 100 words for training runs, more detail for race day
