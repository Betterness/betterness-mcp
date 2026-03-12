# Skill: Route Planner

## Trigger

This skill activates when the rider asks for a route, asks about a specific ride's terrain, or when the heartbeat needs to attach a route to a ride briefing.

Example triggers:
- "Plan a 3-hour endurance ride from home"
- "What's a good route for threshold intervals?"
- "Plan Saturday's long ride"
- "Find me a flat route for recovery"
- "What's the elevation on Latigo Canyon?"
- Pre-ride heartbeat (automatic, for rides with route component)

---

## Execution

### Step 1: Determine ride parameters

From the rider's request or the training plan, establish:
- Ride type (endurance, tempo, threshold intervals, long ride, recovery spin)
- Duration or distance target
- Starting location
- Terrain preference (flat, rolling, climbing, mixed)
- Any specific roads or segments to include/avoid

### Step 2: Gather context

- Local memory: rider's favorite routes, home location, known roads
- Betterness MCP `getActivityData`: recent route history and patterns
- Betterness Graph: route performance history (power/HR on repeated routes)
- Weather forecast: temperature, wind speed and direction, precipitation
- Time of day: daylight hours, traffic patterns

### Step 3: Build the route

Construct or recommend a route that matches:
- **Ride type to terrain:** threshold intervals need sustained grades or flat sections; endurance rides benefit from variety; recovery rides need flat, low-traffic roads
- **Wind to direction:** plan headwind in the first half when legs are fresh, tailwind home
- **Elevation to fitness:** total climbing should match the rider's ability and the session's intent
- **Duration to distance:** account for elevation and stops when estimating time
- **Fueling to distance:** identify water/resupply stops for rides over 2 hours

### Step 4: Add fueling and pacing layers

- Calculate target NP for the route based on ride type and FTP
- Identify pacing zones for different segments (e.g., "climb at Z3, descend easy, flat at Z2")
- Calculate fueling: carbs/hour, gel timing, bottle resupply points
- Note any equipment considerations (climbing gearing, tire pressure for rough roads)

### Step 5: Deliver the route plan

Format:

```
[Ride Type] — [Duration], [Distance], [Elevation]

Route: [Description with key turns/roads]
Target NP: [watts] ([% FTP])
Weather: [temp], [wind speed/direction]
Pacing: [segment-by-segment zone targets]
Fuel: [carbs/hr, gels, bottle stops]
Notes: [wind strategy, traffic, gear]
```

Example:

```
Sunday Long Ride — 4h, 75 mi, 3,200 ft

Route: South on PCH → climb Latigo (mi 32) → Mulholland → descend Topanga → return via PCH
Target NP: 205-215W (75% FTP)
Weather: 72F, S 8mph. Tailwind on coast out, headwind on climb.
Pacing:
  PCH flat: Z2 (175-195W)
  Latigo climb: Z3 (230-245W), seated, cadence >80
  Mulholland rolling: Z2-Z3
  Topanga descent: easy, recover
  PCH return: Z2 with tailwind
Fuel: 80g carbs/hr. 2 bottles mix + 3 gels. Refill at Malibu Country Mart (mi 45).
Notes: Chain at 2,800 mi — shift carefully on the climb.
```

---

## Rules

- Always include weather and wind direction — they affect pacing, clothing, and safety
- Match terrain to training intent (don't send a rider up a mountain for a recovery spin)
- Include fueling for any ride over 90 minutes
- Include refill/resupply stops for rides over 2.5 hours
- Pacing targets are in watts, not heart rate or RPE
- Use the rider's known routes when possible — familiarity adds safety and enjoyment
- Flag any equipment concerns relevant to the route (climbing gearing, tire condition for rough roads)
- If the route is new or unfamiliar, note this and suggest the rider preview it on a map
