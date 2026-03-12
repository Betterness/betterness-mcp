# Module: Training Load

Tracks weekly mileage, intensity distribution, and training stress balance against the current phase targets.

## When Active

Always shown in the workspace home view, below the training phase card. Training load is the backbone of periodization — it is always relevant.

## Data Sources

- Betterness MCP: `getWearableData` (distance, pace, heart rate, training load score, strain)
- Betterness Graph: weekly volume targets by phase, acute:chronic workload ratio, intensity distribution history, personal training stress baselines

## What It Tracks

- **Weekly volume** — total miles run vs phase target (e.g., 42 of 48 mi)
- **Intensity distribution** — percentage of easy, moderate, and hard miles (target: ~80/10/10 for most phases)
- **Training stress balance** — accumulated fatigue vs fitness, trending positive or negative
- **Volume progression** — week-over-week mileage change (flags jumps >10% that risk injury)
- **Key session completion** — did the tempo, intervals, and long run happen this week?

## Output

Concise training load summary with phase target comparison and one insight about the week's trajectory.

### Example — on track

```
Training Load | Build Week 6

Volume: 42 mi of 48 target (88% — on track)
Intensity: 78% easy / 12% moderate / 10% hard
Key sessions: Tempo (done), Long run (Saturday)

Fatigue trending normal for this phase. No adjustments needed.
```

### Example — volume spike warning

```
Training Load | Build Week 4

Volume: 46 mi of 40 target (115% — high)
You jumped 22% from last week. That is a bigger increase
than planned. Consider cutting Thursday's run to 3 easy miles
to bring the week back in line.
```

## Rules

- Always compare to the phase-specific volume target, not a static number
- Flag volume increases >10% week-over-week as potential injury risk
- Intensity distribution matters as much as total volume — surface imbalances
- Do not present training load as a single number without context
- Keep the summary under 80 words unless the user asks for detail
