# Module: Protocol Tracker

Tracks active interventions (supplements, diet changes, lifestyle changes) mapped to the biomarkers they target, with effectiveness assessment.

## When Active
Always shown in the workspace. Updated whenever protocols change.

## Data Sources
- Local memory: active protocols with start dates, target markers, doses
- Betterness Graph: biomarker response since protocol start

## Output
Each protocol entry includes: intervention, dose/detail, start date, duration, target marker(s), and current status.

## Status Categories
- **Responding** — target marker moving in the expected direction
- **Too early** — protocol has not been running long enough to evaluate (typically <8 weeks for supplements)
- **Not responding** — target marker has not moved after sufficient time
- **Unclear** — confounding factors make attribution difficult
