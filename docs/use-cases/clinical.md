# Clinical: Continuous Care Intelligence

## Who This Is For

Concierge medicine practices, longevity clinics, functional medicine providers, care coordinators, and any clinical team that wants health context to persist between visits instead of disappearing into chart notes.

## The Pain

A patient walks into their quarterly visit. The clinician has 15 minutes and a chart full of lab values with no narrative thread. What changed since last time? What was the patient trying? Did the intervention work?

Health context disappears between visits. The patient remembers some of it. The chart captures snapshots but not trajectories. The clinician reconstructs the story every time, losing the first 5 minutes of a 15-minute visit to orientation.

For longevity clinics managing complex, multi-system protocols, the problem compounds. Patients are tracking 40+ biomarkers, running multiple interventions simultaneously, and expecting their clinician to see the whole picture. Manual chart review cannot keep up.

Care coordinators face it at scale — managing dozens of patients across multiple providers, each with different lab vendors, different testing cadences, and different follow-up needs.

## What Betterness MCP Enables

Betterness MCP gives clinical teams an AI layer that maintains continuous health context. It reads across all of a patient's data sources and produces clinician-ready intelligence.

### Pre-Visit Summaries

Before every appointment, the agent generates a structured summary:
- What was discussed last visit
- What interventions were started
- What biomarkers have changed since then
- What the patient's wearable data shows about adherence and response
- What needs attention today

The clinician walks into the room already oriented.

### Biomarker Trend Reviews

Instead of comparing two lab panels manually, the agent presents:
- Direction of change for every marker (improving, stable, worsening)
- Rate of change (fast enough? plateauing?)
- Markers approaching reference range boundaries
- Cross-system correlations (e.g., rising HbA1c alongside declining sleep quality)

### Care Continuity Across Providers

When a patient sees multiple specialists, Betterness maintains the unified health record. The cardiologist sees what the endocrinologist ordered. The functional medicine provider sees what the PCP flagged. No more "did you already get that test?"

### Critical Value Alerts

The agent monitors incoming lab results and wearable data for critical values that need immediate attention, not at the next quarterly visit.

## Key MCP Tools

| Tool | Clinical Application |
|------|---------------------|
| `getUserLabRecords` | Pull all lab results for a patient, across providers and time |
| `searchBiomarkers` | Retrieve specific biomarker history with trends |
| `listAvailableLabTests` | Identify appropriate panels for follow-up testing |
| `getSleepData` | Assess patient sleep quality and adherence to sleep hygiene |
| `getVitals` | Monitor HRV, heart rate, respiratory rate trends |
| `getActivityData` | Assess exercise adherence and activity levels |
| `getBodyComposition` | Track weight, body composition changes |
| `getBiologicalAge` | Track biological age as an outcome metric for longevity protocols |
| `listConnectedDevices` | Verify what data sources a patient has active |

## Example Workflows

### Pre-Visit Preparation

**Prompt**: "Generate a pre-visit summary for my 2:00 PM patient. Include biomarker trends since last visit, wearable data summary, and items needing discussion."

The agent:
1. Pulls last visit date and notes context
2. Calls `getUserLabRecords` for all labs since last visit
3. Calls `getVitals`, `getSleepData`, `getActivityData` for wearable trends
4. Identifies biomarkers that moved significantly
5. Flags items for discussion

**Output**:
```
PRE-VISIT SUMMARY — Patient: [Name] — Last Visit: 2025-12-15

BIOMARKER CHANGES (since 2025-12-15):
  HbA1c: 5.8% → 5.4% (improved, target <5.5% achieved)
  hs-CRP: 1.2 → 2.8 mg/L (worsening, investigate)
  Vitamin D: 42 → 38 ng/mL (declining, supplement adherence?)
  Ferritin: 45 → 52 ng/mL (stable, within range)

WEARABLE TRENDS (90-day):
  Sleep: avg 6.8h (down from 7.2h), deep sleep 16% (below target)
  HRV: declining trend (68 → 58 ms over 90 days)
  Activity: 6,200 steps/day avg (down from 8,100)

ITEMS FOR DISCUSSION:
  1. hs-CRP doubled — new stressor? Infection? Exercise change?
  2. Sleep and activity both declining — lifestyle screen
  3. Vitamin D slipping — adjust supplementation
  4. HbA1c at target — consider maintaining current approach
```

### Population Health Screening

**Prompt**: "Across my patient panel, flag anyone with hs-CRP above 3.0 who has not had a cardiovascular risk assessment in the past year."

The agent scans across connected patients, cross-referencing inflammatory markers with testing history, and produces a prioritized list for outreach.

### Protocol Efficacy Review

**Prompt**: "How are my patients on the longevity protocol performing? Show me aggregate biomarker trends for the cohort."

The agent aggregates anonymized data across patients on a specific protocol to show:
- What percentage improved on key markers
- Average magnitude of change
- Outliers who may need protocol adjustment
- Comparison against expected response curves

## Compliance and Safety Notes

- Betterness MCP provides health data intelligence, not clinical decision support in the regulatory sense. It is a data access and analysis layer.
- All data access respects the patient's consent and the clinic's data sharing agreements.
- The agent does not make diagnoses or prescribe treatments. It surfaces data and patterns for clinician interpretation.
- Lab reference ranges are displayed as provided by the performing laboratory. The agent does not substitute its own ranges.
- Critical value alerts supplement, not replace, laboratory critical value notification procedures.

## Getting Started

1. Register your practice at [betterness.ai](https://betterness.ai) and select a Clinic plan
2. Connect your lab data sources (Quest, Labcorp, or upload via CSV/PDF)
3. Invite patients to connect their wearable data
4. Set up Betterness MCP in your preferred client (see [Client Setup Guides](../clients/))
5. Apply the `clinical-overlay` persona for formal clinical language and guideline-based reasoning
6. Start with pre-visit summaries for your next day's patients

## Recommended Skills

- `biomarker-trend-reviewer` — Multi-marker trend analysis with clinical context
- `pre-visit-summarizer` — Structured pre-appointment briefings
- `lab-gap-detector` — Identifies overdue or missing testing
- `population-health-scanner` — Cohort-level analysis across your patient panel

## Recommended Persona

**Clinical Overlay** — Uses formal medical terminology, cites clinical practice guidelines (AASM, AHA, USPSTF), flags values requiring physician review, and structures output in clinical report format.
