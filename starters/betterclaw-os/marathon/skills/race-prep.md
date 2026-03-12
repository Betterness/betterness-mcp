# Skill: Race Prep

## Trigger

This skill activates when the runner asks about race planning, race week execution, race-day strategy, or pacing for their target race.

Example triggers:
- "Plan my race week"
- "What's my race day plan?"
- "What pace should I run?"
- "Walk me through race week"
- "Am I ready for this race?"
- "What should I eat before the race?"
- Race week heartbeat (automatic, 7 days before race)

---

## Execution

### Step 1: Confirm race details

Check local workspace memory for:
- Race name, date, and start time
- Course profile (flat, hilly, elevation gain)
- Goal time and goal pace
- Weather forecast (if within 10 days)
- Travel logistics (local vs destination race)

If any details are missing, ask the runner before proceeding.

### Step 2: Assess readiness

Request from Betterness Graph:
- 12-week training load progression — did volume build appropriately?
- Long run completion — did the runner hit their longest runs at or near target pace?
- Recovery trajectory — is the runner entering taper/race week healthy or fatigued?
- Previous race performance — historical data for race prediction
- Taper response — is recovery rebounding as expected?

Call Betterness MCP `getWearableData` for:
- Current HRV, resting HR, sleep quality
- Training load trend over the past 14 days

### Step 3: Build the pacing strategy

Calculate target pacing based on:
- Goal time and current fitness data
- Course elevation profile (adjust for hills)
- Weather conditions (adjust for heat, wind, humidity)
- Runner's historical pacing patterns (tendency to go out fast, fade, negative split)

Standard marathon pacing framework:
- **Miles 1-6:** Goal pace + 5-10 sec/mi (patient start, do not bank time)
- **Miles 7-18:** Goal pace (settle into rhythm, fuel on schedule)
- **Miles 19-22:** Hold goal pace (this is where the race begins)
- **Miles 23-26.2:** Whatever the runner has left (the reward for pacing well)

Adjust for course features:
- Uphill sections: +10-15 sec/mi, recover on the downhill
- Downhill sections: do not accelerate — maintain effort, let gravity help
- Wind sections: tuck behind other runners, do not fight headwind with pace

### Step 4: Build the fueling plan

Based on the runner's tested protocol:
- Pre-race meal: what, when, how much (2.5-3 hours before start)
- During-race gels: by mile marker, matched to aid station locations
- Hydration: water at every station, electrolytes at planned intervals
- Caffeine timing: if used, typically at mile 18-20 for the final push

### Step 5: Deliver the race prep plan

Format for race-week activation:

```
Race Prep | [Race Name] — [Date]

Readiness: [assessment based on training data]
Goal: [time] ([pace]/mi)

Pacing:
  Miles 1-6: [pace] (patient start)
  Miles 7-18: [pace] (rhythm)
  Miles 19-22: [pace] (hold)
  Miles 23-26.2: (give it everything)

Fueling:
  Pre-race: [meal] at [time]
  Mile [X]: gel + water
  Mile [X]: gel + electrolytes
  Mile [X]: gel + water
  Mile [X]: gel (caffeine) + water

Weather: [conditions]
Adjustments: [any pace/fuel mods needed]

Race week protocol is active — daily guidance starts now.
```

Format for readiness assessment:

```
Race Readiness | [Race Name] — [X] weeks out

Training block: [summary — weeks completed, volume progression]
Long runs: [completed/planned, longest run, pace performance]
Recovery: [current trajectory — improving, stable, declining]

Assessment: [honest readiness verdict]
Recommended goal: [pace range based on data]

[If adjustment needed: specific recommendation]
```

### Step 6: Offer to go deeper

- "Want me to map your gel schedule to the actual aid station locations on the course?"
- "I can adjust the pacing plan for the hill at mile 16 — want to see that?"
- "Your ferritin was low last month. Want me to check if that could affect race-day performance?"
- "Should I build a plan B pace in case conditions are worse than forecast?"

---

## Rules

- Pacing strategy always starts conservative — never recommend banking time in the first miles
- Fueling plan uses mile markers, not time intervals — and only tested foods
- Weather adjustments are explicit: degrees above 60F map to specific pace additions
- Readiness assessments are honest — if the data says the goal is unlikely, say so and offer a realistic alternative
- Race week protocol covers logistics (bib, gear, travel) as much as training and fueling
- Nothing new on race day — this is a non-negotiable rule for food, gear, and strategy
- Keep the race-day plan to one page — the runner should be able to screenshot it
- Tone shifts to calm confidence as race day approaches — the training is done, now it is about execution
