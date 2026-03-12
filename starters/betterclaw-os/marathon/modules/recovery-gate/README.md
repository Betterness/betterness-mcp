# Module: Recovery Gate

Determines whether today is a push day, moderate day, or rest day based on recovery status, training load context, and the current training phase.

## When Active

Shown on days with quality sessions scheduled (tempo, intervals, long run). Also available on demand when the runner asks "should I train today?" or "should I do the workout?"

## Data Sources

- Betterness MCP: `getWearableData` (HRV, resting heart rate, sleep stages, recovery/readiness score, strain)
- Betterness Graph: personal HRV baseline, resting HR baseline, recovery response curves, training load trend, recent session history
- Local memory: today's planned session, training phase and week, recent training decisions

## How It Gates

### Green — Push

- HRV at or above personal baseline
- Resting HR at or below personal baseline
- Sleep quality adequate (deep sleep near baseline)
- Training load trend is sustainable (no acute spike)
- No red flags from multi-day trend

**Action:** Proceed with the planned quality session as written.

### Amber — Moderate

- HRV slightly below baseline OR resting HR slightly elevated
- OR deep sleep notably below baseline
- OR 2+ consecutive days of declining recovery trend
- OR training load has spiked above plan this week

**Action:** Modify the session — reduce volume, drop intensity by one tier, or swap for easy miles. Protect tonight's sleep.

### Red — Rest

- HRV significantly below baseline (>20% drop)
- AND/OR resting HR elevated >5 bpm above baseline
- AND/OR 3+ days of declining HRV trend
- AND/OR very poor sleep (deep sleep <50% of baseline)
- AND/OR illness symptoms or acute pain

**Action:** Replace with rest or a very easy walk. No training stimulus today. Prioritize sleep and recovery.

## Output

### Example — green gate on tempo day

```
Recovery Gate | Thursday Tempo

Gate: green. HRV 58ms (baseline 52ms). Sleep clean.
Proceed with today's tempo: 6 mi @ 7:50.
No modifications needed.
```

### Example — amber gate on interval day

```
Recovery Gate | Tuesday Intervals

Gate: amber. Deep sleep 38 min (baseline 68 min).
Resting HR slightly elevated.

Planned: 8x800m @ 7:00/mi
Recommendation: Swap to easy 5 miles at 9:00 pace.

You are in Peak Week 2 — 3 weeks from race day.
This is not the week to push through marginal recovery.
Saturday's long run is the priority.
```

### Example — red gate

```
Recovery Gate | Wednesday

Gate: red. HRV dropped 26% from baseline. Third day
of declining trend. Resting HR up 7 bpm.

Skip all training today. Walk if you want to move.
Prioritize: hydration, nutrition, sleep by 9:30 PM.

If this continues tomorrow, we should look at what is
driving it — could be accumulated fatigue, could be
something else. Let's reassess in the morning.
```

## Phase Context

The recovery gate adjusts its threshold sensitivity based on the training phase:
- **Base:** slightly more permissive — amber days can still do easy-moderate work
- **Build:** standard thresholds — amber means modify, red means rest
- **Peak:** slightly more conservative — the body is under maximum load
- **Taper:** very conservative — any amber signal means rest, the work is done
- **Race Week:** no quality sessions to gate — all runs are easy by default

## Rules

- Always compare to personal baselines, never population averages
- Always include the phase context in the gating decision
- The gate recommendation is a clear verb: proceed, modify, or rest
- When the gate is amber or red, name the specific driver (which metric, which trend)
- Never push through amber or red for a non-critical training session
- Keep the gate output under 60 words for green, up to 80 for amber/red
