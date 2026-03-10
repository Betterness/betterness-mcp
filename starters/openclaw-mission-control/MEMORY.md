# Persistent Memory: User & Operator Context

This file holds context that persists across sessions. Update it weekly.

## User Context (Health Profile)

### Identity
- **Name**: [User name]
- **Betterness User ID**: [UUIDv4 format, e.g., a1b2c3d4-e5f6-7890-abcd-ef1234567890]
- **Age/DOB**: [For biomarker reference ranges]
- **Location**: [For lab collection site recommendations]

### Health Goals (Primary)
- **#1**: [e.g., "Optimize metabolic health", "Improve endurance", "Extend lifespan"]
- **#2**: [Secondary goal]
- **#3**: [Tertiary goal]

### Current Focus Area
- **This quarter**: [What's the user optimizing for right now?]
- **Last lab panel date**: [YYYY-MM-DD]
- **Wearables status**: [e.g., "Whoop + Oura syncing; Apple Watch connected"]

### Risk Tolerance & Preferences
- **Medical risk tolerance**: Conservative / Moderate / Aggressive
- **Testing preference**: Minimal / Standard / Comprehensive
- **Supplement/protocol approach**: Evidence-based only / Open to novel / Willing to experiment
- **Response style preference**: Executive summary + action / Detailed explanation / Strategic narrative

## Connected Data (Source of Truth)

Update this weekly by running smoke tests.

### Devices (listConnectedDevices)
```
- Whoop Band: Last sync [date], status [OK/pending/stale]
- Oura Ring: Last sync [date], status [OK/pending/stale]
- Apple Watch: Last sync [date], status [OK/pending/stale]
- Other: [device name], last sync [date]
```

### Lab Data (getUserLabData)
```
Most recent panel:
- Date ordered: [YYYY-MM-DD]
- Date collected: [YYYY-MM-DD]
- Date results back: [YYYY-MM-DD]
- Panel name: [e.g., "Comprehensive Metabolic Panel"]
- Status: Complete / Pending collection / Processing
```

### Known Data Gaps
- **Missing markers**: [e.g., "No inflammation markers in 6 months"]
- **Stale data**: [e.g., "Lipids last tested 2025-09-03, 6 months old"]
- **Never tested**: [e.g., "No genetic testing yet"]

### Devices Not Yet Connected
- [List devices user owns but hasn't connected: e.g., "Fitbit, Apple Health"]
- **Action**: Ask user to connect in Betterness dashboard if data is needed

## Operator Context (How This Workspace Operates)

### Active Specialists
- **Chief of Staff**: [Yes/No] — Active? Last used [date]
- **Longevity Strategist**: [Yes/No] — Active? Last used [date]
- **Performance Coach**: [Yes/No] — Active? Last used [date]
- **Biomarker Analyst**: [Yes/No] — Active? Last used [date]
- **Lab Coordinator**: [Yes/No] — Active? Last used [date]
- **Nutrition & Environment**: [Yes/No] — Active? Last used [date]

### Workflow Schedule

**Daily**:
- Morning review (use `prompts/morning-review.md`)
- Time: [e.g., 7:00 AM user time]
- Last run: [date]

**Weekly**:
- Lab gap review (use `prompts/lab-gap-review.md`)
- Day: [e.g., Monday]
- Last run: [date]

**Monthly**:
- Operator coordination review (use `prompts/weekly-operator-review.md`)
- Date: [e.g., 1st of month]
- Last run: [date]

### Recent Actions & Pending Items

**Last 30 days**:
- [Date]: Lab order placed (Comprehensive Metabolic Panel) — status pending
- [Date]: Added Oura Ring to workspace — syncing
- [Date]: Changed biomarker target (magnesium: 35+ mg/dL)

**Pending**:
- [ ] Order lipid panel (gap: 8 months stale)
- [ ] Schedule check-in with coach after marathon
- [ ] Review updated HRV baseline after device reset

## Operating Preferences

### Communication Style
- **Conciseness**: [1-5, 1=verbose, 5=ultra-concise]
- **Technical depth**: [1-5, 1=plain language, 5=deep biomarker talk]
- **Recommendation style**: [Passive suggestion / Direct action / Options with trade-offs]

### Decision Authority
- **Lab ordering**: [Me (user) approves / Operator can order < $100 / Operator has discretion]
- **Protocol changes**: [User approves all / Operator can suggest, user decides / Operator drives]
- **Escalation threshold**: [Immediately to MD / Operator filters first / Operator decides]

### Content Preferences
- **Sources**: [PubMed studies / Podcast experts / Experienced coaches / Mix]
- **Protocol format**: [One thing per week / Everything at once / Seasonal themes]
- **Reporting cadence**: [Daily / Weekly / Monthly / Quarterly]

## Example (Filled In)

```
## User Context

### Identity
- Name: Sarah Chen
- Betterness User ID: 550e8400-e29b-41d4-a716-446655440000
- Age: 38
- Location: San Francisco, CA

### Health Goals
- #1: Extend healthspan (age well)
- #2: Optimize sleep and recovery
- #3: Maintain athletic base (running)

### Current Focus
- Q1 2026: Sleep optimization
- Last lab: 2025-03-08 (Longevity Panel)
- Wearables: Whoop + Oura + Apple Watch, all syncing

### Risk Tolerance
- Medical: Moderate (evidence-based, willing to try novel interventions with data)
- Response preference: Executive summary + action

## Connected Data

### Devices
- Whoop Band: Last sync 2026-03-09 08:00 UTC, OK
- Oura Ring: Last sync 2026-03-09 06:30 UTC, OK
- Apple Watch: Last sync 2026-03-09 09:15 UTC, OK

### Lab Data
- Most recent: Longevity Panel (2025-03-08)
- Status: Complete
- Key findings: Magnesium low (32 mg/dL), inflammation elevated (hsCRP 2.1)

### Data Gaps
- Stale: Lipid panel (2024-09-01, 6 months old)
- Missing: Micronutrient panel (never done)

## Operator Context

### Active Specialists
- Chief of Staff: Yes, last used 2026-03-09
- Longevity Strategist: Yes
- Performance Coach: Yes
- Biomarker Analyst: Yes
- Lab Coordinator: Yes
- Nutrition & Environment: Yes

### Workflows
- Morning review: Daily at 7:00 AM, last run 2026-03-09
- Weekly lab check: Monday at 9:00 AM, last run 2026-03-09
- Monthly review: 1st of month, last run 2026-03-01

### Pending
- [ ] Order lipid panel (cost check + insurance)
- [ ] Experiment: 2g magnesium glycinate at bedtime, track HRV
- [ ] Schedule follow-up with Longevity Strategist (March 30)
```

---

**Update cadence**: Weekly (Sunday evening)
**Responsible party**: Chief of Staff (or operator)
**Version**: 1.0
