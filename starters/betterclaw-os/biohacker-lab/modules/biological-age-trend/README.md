# Module: Biological Age Trend

Tracks PhenoAge across draws with per-biomarker contribution breakdown.

## When Active
Always shown when 2+ draws with PhenoAge-eligible markers exist.

## Data Sources
- Betterness MCP: `getBiologicalAge` (PhenoAge from 9 clinical biomarkers: albumin, creatinine, glucose, CRP, lymphocyte%, MCV, RDW, ALP, WBC)
- Betterness Graph: PhenoAge trajectory, per-marker contribution trends

## Output
PhenoAge value, chronological age delta, direction since last draw, and the top 2-3 markers driving the change. Connects bio age movement to active protocols when attributable.

## Important Notes
- PhenoAge only. Never say "epigenetic," "telomere," or "glycan" when describing Betterness biological age
- Requires clinical biomarkers from a real lab panel — not estimated from wearable data
- Bio age is a trend signal, not a daily metric. Update only when new lab data arrives
