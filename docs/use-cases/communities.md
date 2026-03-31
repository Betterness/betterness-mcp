# Communities: Connected Wellness Intelligence

## Who This Is For

Wellness communities, running clubs, CrossFit boxes, cycling teams, health-focused online groups, mastermind groups with a wellness focus, and any organized group where members share health goals and want to optimize together.

## The Pain

Communities optimize alone. Every member of your running club is individually tracking sleep, HRV, and mileage — but nobody sees the group picture. Your wellness mastermind shares tips anecdotally, but nobody can say "here is what actually moved the needle for our group."

Group challenges are motivating but shallow. Step-count leaderboards measure activity but miss the point. Nobody asks whether the group's sleep quality improved during the "better sleep" challenge, because aggregating that data across 50 members using different devices is practically impossible.

Community leaders lack intelligence. They know members are engaged, but they cannot answer: "Are our members actually getting healthier? What should we focus on next? Who needs support?"

## What Betterness MCP Enables

Betterness MCP lets community leaders and members access aggregated, anonymized health intelligence for their group — turning a collection of individuals into a health-optimizing collective.

### Shared Health Challenges

Go beyond step counts. Create challenges around biomarkers, sleep quality, HRV improvement, or biological age reduction. The agent tracks group progress with real data, not self-reports.

**Example challenge**: "30-Day Sleep Quality Challenge — goal is to get the group average deep sleep above 20%."

The agent tracks nightly sleep data across participating members (anonymized), reports daily standings, and identifies which strategies are working for the top improvers.

### Group Biomarker Reviews

Quarterly group lab reviews where the community examines aggregate trends:
- What is the group's average Vitamin D level?
- How many members have optimal inflammatory markers?
- What biomarkers should the group prioritize next quarter?

Individual data stays private. The agent reports distributions, averages, and anonymized outlier flags.

### Event Planning with Health Data

Planning a group race, retreat, or event? The agent can assess group readiness:
- What percentage of the group is in a recovered state (by HRV)?
- Are there members whose recent health data suggests they should modify participation?
- What is the group's collective training load trending?

### Community Health Intelligence

Community leaders get a dashboard view:
- Engagement: how many members are actively syncing data
- Health trends: which metrics are improving across the group
- Risk flags: anonymized alerts when members show concerning patterns
- Content opportunities: what health topics the community should learn about based on their data

## Key MCP Tools

| Tool | Community Application |
|------|----------------------|
| `getSleepData` | Group sleep quality tracking, challenge scoring |
| `getSleepStages` | Deep sleep and REM analysis across the group |
| `getVitals` | Group HRV trends, heart rate patterns |
| `getActivityData` | Group activity levels, training load balance |
| `getBodyComposition` | Group body composition trends (with consent) |
| `getUserLabRecords` | Aggregate biomarker distributions |
| `searchBiomarkers` | Group-level biomarker searches |
| `listAvailableLabTests` | Recommend group lab panels for bulk ordering |
| `listConnectedDevices` | Track device adoption across the community |

## Example Workflows

### Monthly Community Health Brief

**Prompt**: "Generate the monthly health brief for our running club. 47 members have data synced. Show group sleep trends, average HRV, training load distribution, and any flags."

The agent aggregates anonymized data across all participating members:

```
COMMUNITY HEALTH BRIEF — March 2026
Members reporting: 47/62 (76% data participation)

SLEEP (group averages):
  Total sleep: 7.1h (up from 6.9h last month)
  Deep sleep: 19.2% (target: 20%+, improving)
  Members below 6h average: 8 (flag for outreach)

HRV (group trends):
  Group median: 54ms (stable)
  Members with declining 30-day trend: 11
  Members with improving 30-day trend: 22

TRAINING LOAD:
  Average weekly mileage: 38 km
  Members in overreach zone (>20% above baseline): 6
  Members in detraining zone (<50% of baseline): 3

RECOMMENDATIONS:
  1. Continue sleep challenge — group trending toward 20% deep sleep target
  2. Reach out to 6 members in overreach zone before next race
  3. Consider group Vitamin D testing — winter season, likely low across group
```

### Challenge Leaderboard with Real Metrics

**Prompt**: "Update the HRV improvement challenge standings. We are on week 3 of 6."

The agent ranks members by HRV improvement percentage (not absolute value, to be fair across fitness levels), shows the group trend, and highlights strategies reported by the top improvers.

### Group Lab Panel Coordination

**Prompt**: "We want to do a group blood panel. What should we test based on our community's data gaps, and can we set up bulk ordering?"

The agent:
1. Scans `getUserLabRecords` across members to find the most common gaps
2. Calls `listAvailableLabTests` to find panels that cover those gaps
3. Recommends 2-3 panel options with pricing for group ordering
4. Identifies members who are most overdue

## Privacy and Consent

Community health intelligence requires careful privacy handling:

- **Opt-in only**: Members must explicitly consent to share anonymized data with the community
- **Anonymized aggregation**: Individual data is never exposed to other members or community leaders
- **Minimum group size**: Aggregate statistics require at least 10 participating members to prevent de-identification
- **Granular consent**: Members choose which data types to share (sleep, activity, labs, etc.)
- **Withdrawal**: Members can revoke consent at any time, and their data is immediately excluded from aggregates

## Getting Started

1. Create a community organization at [betterness.ai](https://betterness.ai)
2. Invite members with a join link
3. Members connect their own devices and grant community data sharing consent
4. Set up Betterness MCP in your preferred client (see [Client Setup Guides](../clients/))
5. Load community-focused skills
6. Run your first community health brief

## Recommended Skills

- `morning-brief-composer` — Adapted for community-level reporting
- `biomarker-trend-reviewer` — Group biomarker distribution analysis
- `sleep-quality-analyzer` — Group sleep quality tracking
- `training-readiness-evaluator` — Group readiness assessments

## Recommended Persona

**Wellness Coach Overlay** — Warm, encouraging tone appropriate for community communication. Focuses on group progress, celebrates improvements, and frames recommendations as opportunities rather than deficiencies.
