# Module: Fueling Calculator

Calculates carbohydrate and hydration targets scaled to ride duration, intensity, elevation, and temperature.

## When Active
Shown for rides over 90 minutes, in hot conditions (>80F), or when the rider asks about nutrition for an upcoming ride.

## Data Sources
- Betterness MCP: `getWearableData` (body weight, sweat rate estimates)
- Betterness Graph: fueling effectiveness patterns, preferred products, gut tolerance
- Local memory: current ride plan (duration, target watts, route elevation)
- External: temperature forecast

## Output
Carbs per hour target, gel/bar timing, bottle mix recipe, refill stops on route, and pre-ride nutrition timing. Scales with intensity: Z2 endurance gets less than Z4 threshold work.
