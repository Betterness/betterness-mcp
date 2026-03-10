# Biohackers: Private Health Mission Control

## Who This Is For

Self-quantifiers, longevity builders, biological age optimizers, and anyone who runs their health like a system — not a guessing game. You track everything, test constantly, and want a single intelligence layer that connects it all.

## The Pain

You have data everywhere. Oura ring data on your phone. Blood work PDFs in your email. Supplement protocols in a spreadsheet. Biological age test results on three different platforms. Notes from your longevity doctor in a patient portal you check once a quarter.

You are running a private health mission control, but it looks like a pile of disconnected apps.

The real cost is not the inconvenience — it is the insights you miss. Your Vitamin D dropped 15 points over 6 months but you did not notice because the results were in different labs. Your HRV flatlined after starting a new supplement but you did not correlate because the data lives in separate systems. You are collecting world-class data and getting amateur-level analysis.

## What Betterness MCP Enables

Betterness MCP turns your AI assistant into a health intelligence analyst that has access to all your data simultaneously. It reasons across data sources instead of within them.

### Biological Age Tracking

Track your biological age across multiple clocks (epigenetic, metabolic, functional) over time. See how interventions move the needle — not just a single snapshot, but the trajectory.

### Lab Gap Detection

Your last comprehensive panel was 6 months ago, but you only tested metabolic markers. Your inflammatory panel is 9 months stale. Your hormone panel is current but missing DHEA-S. The agent identifies what is missing and recommends specific tests to fill the gaps.

### Protocol Experiments

Running an n=1 experiment? Define your intervention, your biomarker targets, and your timeline. The agent tracks whether your metrics are moving in the expected direction and flags unexpected changes.

### Cross-Source Pattern Detection

The agent can identify patterns that no single data source reveals:
- Sleep quality decline correlating with a supplement change
- HRV improvement correlating with a dietary change
- Inflammatory markers rising alongside increased training volume

## Key MCP Tools

| Tool | What It Provides |
|------|-----------------|
| `getBiologicalAge` | Biological age calculations, clock breakdowns, trend over time |
| `getUserLabData` | All lab results across providers, with reference ranges |
| `searchBiomarkers` | Search and retrieve specific biomarker history |
| `listAvailableLabTests` | Browse available lab panels for ordering |
| `purchaseLabTest` | Order lab tests directly through Betterness |
| `getSleepData` | Sleep metrics from connected wearables |
| `getSleepStages` | Detailed sleep architecture breakdowns |
| `getVitals` | HRV, heart rate, respiratory rate, SpO2 |
| `getBodyComposition` | Weight, body fat, muscle mass trends |

## Example Workflows

### Quarterly Health Audit

**Prompt**: "Run a full quarterly health audit. Compare my current biomarkers against 3 months ago, identify any concerning trends, flag gaps in my testing, and recommend what to order next."

The agent:
1. Calls `getUserLabData` to pull all recent lab results
2. Calls `searchBiomarkers` for key markers across your history
3. Calls `getBiologicalAge` for your current bio age and trend
4. Calls `getVitals` for wearable trends over the quarter
5. Calls `listAvailableLabTests` to identify what panels would fill gaps

**Output**: A structured audit covering:
- Biomarker trends (improved, stable, declining)
- Biological age trajectory
- Missing or stale panels
- Recommended lab order for next quarter
- Flags for physician discussion

### Supplement Protocol Tracking

**Prompt**: "I started 5000 IU Vitamin D3 + K2 eight weeks ago. Has it moved my levels? Also check if anything else changed that might be related."

The agent:
1. Calls `searchBiomarkers` for Vitamin D (25-OH) over the past year
2. Calls `searchBiomarkers` for calcium, parathyroid hormone (related markers)
3. Calls `getVitals` to check if any wearable metrics shifted
4. Compares pre-intervention and post-intervention values

**Output**: Vitamin D went from 28 to 47 ng/mL (target: 50-70). On track. Calcium stable. No adverse wearable signal changes. Recommend retesting in 4 weeks to confirm you reach target range.

### Biological Age Deep Dive

**Prompt**: "Break down my biological age by system. Where am I aging fastest and what biomarkers are driving it?"

The agent:
1. Calls `getBiologicalAge` for multi-clock results
2. Calls `getUserLabData` for biomarkers that feed into each aging domain
3. Cross-references metabolic, inflammatory, hormonal, and cardiovascular markers

**Output**: A system-by-system breakdown:
- Metabolic age: 2 years younger (fasting glucose, HbA1c, insulin all optimal)
- Inflammatory age: 1 year older (hs-CRP slightly elevated, IL-6 borderline)
- Hormonal age: on track (testosterone, DHEA-S, cortisol normal)
- Cardiovascular age: 3 years younger (ApoB low, Lp(a) low, lipid panel optimal)
- **Priority target**: inflammatory markers. Recommend omega-3 index test and dietary review.

### Sleep Optimization Protocol

**Prompt**: "I want to increase my deep sleep from 18% to 25%. Analyze my current sleep data, relevant biomarkers, and suggest a 30-day protocol with measurable checkpoints."

The agent:
1. Calls `getSleepData` and `getSleepStages` for the past 90 days
2. Calls `getVitals` for HRV and heart rate patterns during sleep
3. Calls `searchBiomarkers` for magnesium, vitamin D, cortisol, melatonin (if available)
4. Analyzes patterns by day of week, bedtime, and correlating factors

**Output**: A structured 30-day protocol with weekly checkpoints and specific metrics to track.

## Getting Started

1. Connect all your data sources in the Betterness dashboard (wearables, lab providers, manual uploads)
2. Upload historical lab PDFs — the more history, the better the trend analysis
3. Set up Betterness MCP in your preferred client (see [Client Setup Guides](../clients/))
4. Load the `biomarker-trend-reviewer` and `lab-gap-detector` skills
5. Apply the `biohacker-overlay` or `longevity-overlay` persona
6. Run your first quarterly health audit

## Recommended Skills

- `biomarker-trend-reviewer` — Multi-marker trend analysis across lab providers
- `lab-gap-detector` — Identifies stale, missing, or incomplete panels
- `biological-age-tracker` — Tracks bio age across clocks over time
- `sleep-quality-analyzer` — Deep sleep architecture analysis
- `morning-brief-composer` — Daily health intelligence briefing

## Recommended Personas

- **Biohacker Overlay** — Speaks like a fellow self-quantifier, emphasizes n=1 methodology and optimization opportunities
- **Longevity Overlay** — Focuses on biological age, healthspan, and long-term trajectories with aging research citations
