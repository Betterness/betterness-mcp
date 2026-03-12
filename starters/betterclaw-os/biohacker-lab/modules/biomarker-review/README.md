# Module: Biomarker Review

Interprets the latest lab panel in the context of personal trajectory, active protocols, and cross-domain signals.

## When Active
Shown after a new panel is uploaded or when the user asks about their latest results.

## Data Sources
- Betterness MCP: `searchBiomarkers`, `getUserLabRecords`, `getLabRecordDetail`
- Betterness Graph: biomarker trajectories, protocol correlation, cross-domain signals

## Output
Ranked interpretation: what improved, what declined, what is new. Each marker includes trajectory context and protocol attribution. Ends with specific next actions (retest, adjust, hold).

## Output Example
```
Panel Review — Feb 14, 2026

Improving:
  Vitamin D: 58 ng/mL (↑ from 42, responding to 4,000 IU protocol since Oct)
  hsCRP: 0.4 mg/L (↓ from 0.8 — driving bio age improvement)
  HbA1c: 5.1% (↓ from 5.3 — stable improvement)

Watch:
  Ferritin: 54 ng/mL (↓ from 78, third consecutive decline)

Stable:
  Testosterone: 612 ng/dL (flat across 3 draws)

Actions:
  → Retest ferritin + iron panel in 6 weeks
  → Consider reducing vitamin D to 3,000 IU maintenance
  → Hold current protocols for omega-3 and magnesium
```
