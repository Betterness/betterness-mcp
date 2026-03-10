# Fitness: Unified Performance Intelligence

## Who This Is For

Marathon runners, cyclists, CrossFit athletes, gym operators, performance coaches, and anyone who trains seriously and wants their health data to work as hard as they do.

## The Pain

You wear an Oura ring for sleep. A Whoop for strain. A Garmin for GPS runs. Apple Health for heart rate. You log workouts in one app, nutrition in another, and labs in a spreadsheet.

Five apps track your body. None of them talk to each other.

Your sleep quality directly affects your HRV which affects your training readiness which determines whether today's interval session is building fitness or digging a recovery hole. But that chain of reasoning lives entirely in your head because no single tool connects the dots.

Coaches face the same problem at scale. They have 30 athletes, each with different devices, different data formats, and no unified view. Pre-workout readiness checks mean opening 4 tabs and eyeballing it.

## What Betterness MCP Enables

Betterness MCP gives your AI assistant access to all your health data through a single protocol. Instead of checking multiple apps, you ask one question and get one answer backed by data from every source.

### Unified Wearable Data

All your devices feed into a single health data layer. When you ask "how did I sleep," the answer includes Oura sleep stages, Whoop recovery score, and Apple Watch heart rate data — merged and analyzed together.

### Lab-Informed Training Decisions

Your ferritin is low? That explains why your easy pace feels hard. Betterness connects lab biomarkers to training performance so you catch issues that wearable-only systems miss entirely.

### Biomarker Trend Tracking

Track key performance biomarkers over months and years — not just the snapshot from your last blood draw. See how your testosterone, cortisol ratio, CRP, and vitamin D trend alongside training load changes.

### Morning Readiness Briefs

A daily briefing that synthesizes last night's sleep, current HRV trend, recent training load, and relevant biomarkers into a single readiness assessment. Delivered before you decide what today's training looks like.

## Key MCP Tools

| Tool | What It Provides |
|------|-----------------|
| `getSleepData` | Total sleep, efficiency, time in bed, sleep/wake times |
| `getSleepStages` | Deep, REM, light, and awake breakdowns with durations |
| `getVitals` | HRV, resting heart rate, respiratory rate, SpO2 |
| `getActivityData` | Steps, active calories, workout sessions, strain scores |
| `getBodyComposition` | Weight, body fat %, muscle mass, hydration |
| `searchBiomarkers` | Look up any biomarker by name across your lab history |

## Example Workflow: Marathon Taper Mission Control

A runner is 3 weeks out from their goal marathon. They need to nail the taper — reduce training load while maintaining fitness and arriving at the start line fully recovered.

### Week 3 Out: Establish Baseline

**Prompt**: "Analyze my sleep, HRV, and training load from the past 4 weeks. Establish my baseline metrics for taper monitoring."

The agent calls `getSleepData`, `getSleepStages`, `getVitals`, and `getActivityData` for the past 28 days. It identifies:
- Average deep sleep: 1.4h (22% of total)
- HRV baseline: 62ms (7-day rolling)
- Resting heart rate: 48 bpm
- Weekly training load: 65 km average

### Week 2 Out: Monitor Recovery Response

**Prompt**: "Training volume dropped to 45km this week. How is my body responding to the taper?"

The agent compares current week data against the baseline:
- Deep sleep trending up (now 1.6h, 25%) — recovery improving
- HRV rising to 68ms — parasympathetic rebound occurring
- RHR dropped to 46 bpm — cardiovascular recovery on track

### Race Week: Final Readiness Check

**Prompt**: "Marathon is Saturday. Give me a full readiness assessment."

The agent pulls all available data and synthesizes:
- Sleep quality: optimal (deep sleep 27%, REM 24%)
- HRV: 74ms — highest in 6 weeks, strong recovery signal
- RHR: 45 bpm — at seasonal low
- Body weight: stable, no unexpected fluctuations
- Recent labs: ferritin 68 ng/mL (adequate), vitamin D 52 ng/mL (optimal), CRP 0.3 mg/L (no inflammation)
- Assessment: **Green light. Full recovery achieved. Race-ready.**

### Post-Race: Recovery Tracking

**Prompt**: "I ran the marathon yesterday. Track my recovery over the next 2 weeks."

The agent sets up daily monitoring, watching for:
- HRV return to baseline (typically 7-14 days)
- Sleep quality normalization
- RHR normalization
- Any inflammatory markers if labs are drawn

## For Coaches and Gym Operators

### Multi-Athlete Dashboard

Coaches can connect multiple athletes and get population-level views:

**Prompt**: "Show me which of my athletes have HRV below their baseline today."

### Periodization Validation

**Prompt**: "Is my team's training periodization actually producing the recovery patterns I expect? Compare planned vs actual recovery metrics for the past training block."

### Injury Risk Flags

**Prompt**: "Flag any athletes whose sleep quality has dropped more than 20% this week combined with rising resting heart rate."

## Getting Started

1. Connect your wearable devices in the Betterness dashboard
2. Upload or sync your lab results
3. Set up Betterness MCP in your preferred client (see [Client Setup Guides](../clients/))
4. Load the `training-readiness-evaluator` and `sleep-quality-analyzer` skills
5. Apply the `sports-medicine-overlay` persona for performance-focused analysis
6. Ask: "Give me today's training readiness assessment"

## Recommended Skills

- `sleep-quality-analyzer` — Deep sleep and recovery analysis
- `training-readiness-evaluator` — Multi-signal readiness scoring
- `morning-brief-composer` — Daily health + readiness briefing
- `biomarker-trend-reviewer` — Lab result trend analysis

## Recommended Persona

**Sports Medicine Overlay** — Interprets all data through a performance and recovery lens, cites exercise science, and speaks like an experienced sports medicine physician.
