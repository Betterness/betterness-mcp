# Events: Health-Informed Event Intelligence

## Who This Is For

Event organizers, retreat operators, wellness conference planners, race directors, corporate offsite coordinators, and anyone running an event where participant health, readiness, or wellness is relevant to the experience.

## The Pain

Health events lack data. A wellness retreat promises transformation but has no way to measure whether participants actually improved. A race director manages 500 runners with zero insight into who might be at risk. A corporate wellness day fills a schedule with speakers but cannot tailor content to what attendees actually need.

Event organizers collect registration data but not health data. They plan programs based on assumptions, not evidence. Post-event surveys ask "how did you feel?" instead of showing "here is how your biomarkers changed."

The gap between a generic wellness event and a health-intelligent event is the difference between entertainment and measurable impact.

## What Betterness MCP Enables

Betterness MCP gives event organizers access to opt-in participant health data, enabling events that are safer, more personalized, and measurably effective.

### Participant Health Readiness

Before a physically demanding event (race, retreat with intense programming, adventure experience), assess participant readiness:
- Are there participants whose HRV trend suggests they are overtrained?
- Does anyone have recent lab flags that suggest modified participation?
- What is the group's overall readiness distribution?

### Event-Specific Lab Panels

Offer pre-event and post-event lab panels that measure the event's health impact:
- **Pre-event**: Baseline inflammatory markers, metabolic panel, hormone panel
- **Post-event**: Same markers 2-4 weeks later to quantify change
- **During event**: Daily wearable check-ins for multi-day retreats

### Personalized Event Experiences

Segment participants by health profile to deliver tailored programming:
- High-stress participants get extra recovery sessions
- Athletes with low HRV get modified intensity options
- Participants with specific biomarker gaps get relevant workshops

### Post-Event Impact Reports

Generate data-driven impact reports that show measurable outcomes:
- Sleep quality improvement during a retreat
- Stress marker reduction after a wellness program
- Fitness improvements across a training camp
- Before/after biomarker comparisons for lab-inclusive events

## Key MCP Tools

| Tool | Event Application |
|------|-------------------|
| `getSleepData` | Monitor participant sleep quality during multi-day events |
| `getVitals` | Track HRV and stress signals across the event |
| `getActivityData` | Monitor activity levels and strain during physical events |
| `getUserLabRecords` | Pre/post event biomarker comparisons |
| `listAvailableLabTests` | Design event-specific lab panels |
| `purchaseLabTest` | Enable participants to order panels through the event |
| `getBodyComposition` | Track body composition changes for fitness retreats |
| `getBiologicalAge` | Biological age as a high-level event outcome metric |
| `listConnectedDevices` | Track participant device adoption and data availability |

## Example Workflows

### Pre-Race Safety Screening

**Prompt**: "We have 200 registered runners for Saturday's trail ultramarathon. Of those who have shared health data, flag anyone with concerning patterns that suggest elevated risk."

The agent reviews available participant data:

```
RACE READINESS REPORT — Trail Ultra 50K
Participants with health data: 134/200 (67%)

GREEN (race-ready): 112
  Normal HRV trends, adequate sleep, appropriate training load

YELLOW (monitor): 18
  - 7: Declining HRV trend (>15% drop over 14 days)
  - 5: Average sleep below 6h for past week
  - 4: Training load spike in past 10 days (taper not evident)
  - 2: Recent illness recovery (elevated RHR)

RED (recommend consultation): 4
  - 2: Significant HRV suppression + poor sleep + high training load
  - 1: Resting heart rate 15 bpm above personal baseline
  - 1: No recent data (device disconnected 3 weeks ago)

RECOMMENDATION: Contact YELLOW and RED participants individually.
RED participants should consult with event medical staff before start.
```

### Wellness Retreat Daily Briefing

**Prompt**: "Generate today's retreat briefing. We are on Day 3 of 5. Show how the group is responding to the programming."

```
RETREAT BRIEFING — Day 3 of 5
Participants tracking: 28/30

SLEEP (last night):
  Group average: 7.8h (up from 6.4h on arrival night)
  Deep sleep: 23% (up from 17% on Day 1)
  12 participants achieved personal best sleep scores

HRV (trend since arrival):
  Group median up 8% since Day 1
  22/28 showing positive HRV trajectory
  Biggest responders: participants in the morning meditation cohort

ACTIVITY:
  Average steps: 11,200 (balanced day)
  No participants in overexertion zone

TODAY'S PROGRAMMING RECOMMENDATION:
  Group is responding well to recovery-focused Day 2 schedule.
  Day 3 can safely include the planned hike (moderate intensity).
  Consider adding an optional recovery session for the 6 participants
  whose HRV has not yet started improving.
```

### Post-Event Impact Report

**Prompt**: "Generate the final impact report for our 5-day wellness retreat. Compare arrival data to departure data for all participants."

```
RETREAT IMPACT REPORT — 5-Day Wellness Intensive

PARTICIPANTS: 30 (28 with complete data)

SLEEP IMPROVEMENT:
  Average total sleep: 6.4h → 7.6h (+18.7%)
  Average deep sleep: 17% → 24% (+41.2%)
  Participants who improved sleep quality: 26/28 (93%)

HRV IMPROVEMENT:
  Group median HRV: 48ms → 56ms (+16.7%)
  Participants with improved HRV: 24/28 (86%)

STRESS INDICATORS:
  Average resting heart rate: 68 → 62 bpm (-8.8%)
  HRV variability (consistency): improved in 22/28

PRE/POST LAB COMPARISON (18 participants completed both panels):
  Average cortisol: 18.2 → 14.7 mcg/dL (-19.2%)
  Average hs-CRP: 2.1 → 1.6 mg/L (-23.8%)
  Average fasting glucose: 96 → 91 mg/dL (-5.2%)

BIOLOGICAL AGE (12 participants with bio age data):
  Average shift: -0.8 years over 5 days
  (Note: short-term bio age shifts reflect acute state, not permanent change)

MEASURABLE OUTCOMES:
  93% improved sleep, 86% improved HRV, 80% reduced cortisol
  Net promoter data + biomarker data = compelling ROI story for sponsors
```

## Revenue Opportunities for Event Organizers

- **Premium health-tracked experience** — Charge more for events that include health monitoring and personalized reports
- **Pre-event lab panels** — Offer bundled lab testing as an event add-on
- **Post-event individual reports** — Participants receive their personal health impact report
- **Sponsor reports** — Aggregate (anonymized) impact data for wellness brand sponsors
- **Recurring events** — Track participants across multiple events to show long-term improvement

## Privacy and Consent

- All participant health data sharing is opt-in with explicit consent during registration
- Event organizers see only aggregated data and flagged categories (GREEN/YELLOW/RED), not individual health records
- Individual health reports go only to the participant
- Data sharing consent expires at the end of the event unless the participant opts into ongoing tracking
- Participants can withdraw consent at any time during the event

## Getting Started

1. Register as an event organizer at [betterness.ai](https://betterness.ai)
2. Create your event and configure health data collection preferences
3. Add the health opt-in to your registration flow
4. Set up Betterness MCP in your preferred client (see [Client Setup Guides](../clients/))
5. Run a pre-event readiness assessment 48 hours before the event
6. Generate daily briefings during multi-day events
7. Produce the impact report within 1 week of event conclusion

## Recommended Skills

- `training-readiness-evaluator` — Participant readiness assessment
- `sleep-quality-analyzer` — Group sleep quality monitoring
- `biomarker-trend-reviewer` — Pre/post biomarker analysis
- `morning-brief-composer` — Daily event health briefings

## Recommended Persona

**Wellness Coach Overlay** — Appropriate for participant-facing communications. Encouraging tone, focuses on positive trends, and frames health data as empowering rather than clinical.
