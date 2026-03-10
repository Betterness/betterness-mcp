# Residential: Facility Wellness Intelligence

## Who This Is For

Residential wellness operators, corporate wellness program managers, senior living communities, co-living spaces with health programming, and any facility where the health of a resident population is part of the value proposition.

## The Pain

Facility health programs lack intelligence. A senior living community tracks resident falls but not the sleep and activity patterns that predict them. A corporate wellness program offers gym memberships and annual health fairs but cannot tell you whether employees are actually healthier than last year. A wellness-focused co-living space markets a healthy lifestyle but has no data on whether residents experience one.

Program decisions are made on participation metrics (how many people attended yoga class) rather than health outcome metrics (did the population's cardiovascular health improve). Budgets go to popular programs, not effective ones.

For senior living specifically, the stakes are high. Declining sleep quality, reduced activity levels, and worsening vital signs are leading indicators of health events. By the time a resident falls or is hospitalized, the warning signs were in the data weeks earlier — but nobody was looking.

## What Betterness MCP Enables

Betterness MCP gives facility operators an AI-powered health intelligence layer for their resident population, enabling proactive health management instead of reactive crisis response.

### Resident Health Monitoring

Continuous, passive monitoring of resident health signals through connected wearables:
- Sleep quality trends for each resident
- Activity level patterns (detecting decline)
- Vital sign baselines and deviations
- Early warning indicators for health events

### Population-Level Biomarker Tracking

Aggregate lab data across the resident population to identify facility-wide health trends:
- Seasonal Vitamin D deficiency patterns
- Metabolic health distribution
- Inflammatory marker trends
- Vaccination and preventive care compliance

### Program Effectiveness Measurement

Quantify the health impact of facility programs with real data:
- Did the new fitness class improve the group's activity levels?
- Is the sleep hygiene workshop actually improving sleep quality?
- Are residents who participate in the nutrition program showing better biomarkers?

### Predictive Health Alerts

The agent monitors for patterns that precede health events:
- Sustained decline in sleep quality + reduced activity + elevated resting heart rate = elevated risk flag
- Declining HRV trend + weight change + reduced social activity = wellness check recommended
- Multiple residents showing similar patterns = environmental or programmatic issue

## Key MCP Tools

| Tool | Residential Application |
|------|------------------------|
| `getSleepData` | Monitor resident sleep quality, detect decline patterns |
| `getSleepStages` | Identify sleep architecture changes that precede health issues |
| `getVitals` | Track resting heart rate, HRV, respiratory rate baselines |
| `getActivityData` | Monitor activity levels, detect isolation or mobility decline |
| `getBodyComposition` | Track weight changes, detect unintended loss or gain |
| `getUserLabData` | Population lab result tracking and gap identification |
| `searchBiomarkers` | Search for specific markers across the resident population |
| `listAvailableLabTests` | Plan facility-wide lab screening programs |
| `purchaseLabTest` | Order lab panels for residents through the platform |
| `listConnectedDevices` | Track device adoption and data coverage across residents |
| `getBiologicalAge` | Track facility-wide biological age as a headline health metric |

## Example Workflows

### Weekly Facility Health Report

**Prompt**: "Generate the weekly health report for our 120-resident senior living community. Flag anyone with concerning trends and summarize population health status."

```
FACILITY HEALTH REPORT — Week of March 3-9, 2026
Residents with active monitoring: 94/120 (78%)

POPULATION SLEEP:
  Average total sleep: 6.9h (stable)
  Residents with declining sleep trend (>15% over 30 days): 8
  Residents averaging <5.5h: 5 (up from 3 last week — investigate)

POPULATION ACTIVITY:
  Average daily steps: 4,200 (down from 4,500 — seasonal pattern?)
  Residents with >30% activity decline in past 14 days: 6
  Residents below 1,000 steps/day: 3 (flag for wellness check)

POPULATION VITALS:
  Residents with RHR >10% above personal baseline: 4
  Residents with declining HRV trend: 12
  New SpO2 flag: 1 resident with sustained SpO2 <94%

PRIORITY FLAGS:
  RED (immediate attention): 2
    - Resident A: SpO2 sustained <94%, declining activity, poor sleep
    - Resident B: RHR spike + 30% activity decline + weight loss
  YELLOW (monitor closely): 9
    - 5: Sleep quality declining + activity declining (correlation)
    - 4: HRV declining but sleep and activity stable

PROGRAM METRICS:
  Morning Tai Chi: 34 regular attendees, group activity avg 15% higher
  Evening Meditation: 22 regulars, group sleep quality 12% better
  New Strength Class: 18 enrolled, too early for outcome data (week 2)

RECOMMENDATIONS:
  1. Wellness check for 2 RED-flagged residents immediately
  2. Investigate the increase in residents sleeping <5.5h
  3. Consider adding afternoon activity option — activity dip
     correlates with 2-5 PM low-engagement period
```

### Program ROI Analysis

**Prompt**: "We have been running the morning fitness program for 6 months. Compare health outcomes for regular participants vs non-participants."

The agent segments the population and compares:

```
PROGRAM IMPACT ANALYSIS — Morning Fitness (6-month review)

Regular participants (3+ sessions/week): 28 residents
Non-participants: 66 residents (with data)

ACTIVITY:
  Participants: +22% daily steps vs 6 months ago
  Non-participants: -3% daily steps
  Difference: significant

SLEEP QUALITY:
  Participants: deep sleep 21% (up from 17%)
  Non-participants: deep sleep 16% (unchanged)
  Difference: significant

CARDIOVASCULAR:
  Participants: RHR -4 bpm average, HRV +11%
  Non-participants: RHR stable, HRV -2%
  Difference: significant

FALLS (6-month period):
  Participants: 1 fall (3.6% incidence)
  Non-participants: 9 falls (13.6% incidence)
  Difference: notable (small sample, not statistically powered)

BIOLOGICAL AGE (12 participants, 8 non-participants with data):
  Participants: average -1.2 years over 6 months
  Non-participants: average +0.4 years
  Difference: directionally meaningful

RECOMMENDATION:
  Program shows strong positive signal across all measured domains.
  Consider expanding capacity and incentivizing enrollment.
  Estimated healthcare cost avoidance from fall reduction alone
  justifies program expense.
```

### Seasonal Screening Campaign

**Prompt**: "Winter is ending. Plan a spring screening campaign for our residents. What should we test based on population data gaps and seasonal health patterns?"

The agent analyzes the population's lab history and seasonal factors:
- 72% of residents have not had Vitamin D tested since October
- 45% are overdue for metabolic panel (last test >6 months ago)
- Spring is appropriate for thyroid screening (seasonal variation)
- 15 residents are due for annual comprehensive panel

Recommends a tiered panel approach with pricing and scheduling.

## Corporate Wellness Application

The same tools apply to corporate wellness with different framing:

- **Employee health trends** instead of resident monitoring
- **Program ROI** tied to productivity and absenteeism, not fall prevention
- **Department-level analysis** instead of individual flags
- **Voluntary participation** with aggregate-only reporting to leadership

**Example prompt**: "How is the engineering department's health trending compared to sales? Both teams started the wellness program 3 months ago."

## Privacy and Compliance

- **Consent**: All health monitoring requires explicit resident (or employee) consent with clear opt-out
- **HIPAA**: Facility operators using clinical data must ensure HIPAA compliance in their data handling
- **Aggregate reporting**: Leadership receives population-level statistics only. Individual data goes to the resident and their care team
- **Minimum reporting thresholds**: No group statistics reported for groups smaller than 10 to prevent re-identification
- **Data retention**: Configurable retention policies per facility regulatory requirements
- **Audit trail**: All data access is logged for compliance review

## Getting Started

1. Register your facility at [betterness.ai](https://betterness.ai) with an appropriate plan
2. Define your health monitoring program and consent framework
3. Deploy wearable devices to consenting residents (Betterness supports bulk device programs)
4. Set up Betterness MCP in your preferred client (see [Client Setup Guides](../clients/))
5. Run an initial population health baseline assessment
6. Configure weekly automated health reports
7. Begin measuring program effectiveness at the 3-month mark

## Recommended Skills

- `population-health-scanner` — Facility-wide health trend analysis
- `sleep-quality-analyzer` — Individual and group sleep monitoring
- `biomarker-trend-reviewer` — Population biomarker distribution analysis
- `morning-brief-composer` — Daily facility health briefings
- `training-readiness-evaluator` — Activity and mobility assessment

## Recommended Persona

**Clinical Overlay** — For care teams and medical directors who need formal clinical language and guideline-based reasoning in facility health reports.
