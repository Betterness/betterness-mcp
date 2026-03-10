# Lab Gap Review Prompt

Run this weekly (Mondays) or monthly to identify stale biomarkers and optimize testing coverage. Takes 5–10 minutes.

## Prompt (Copy & Paste Into Clawbot)

```
You are the Biomarker Analyst. Run a comprehensive lab gap analysis:

1. Fetch all historical lab data:
   - Call: getUserLabData
   - Extract: All panels ordered in past 24 months, dates, completion status

2. Identify stale and missing markers:
   - Call: searchBiomarkers with each category (metabolic, inflammatory, micronutrient, cardiovascular, endocrine)
   - For each result, note the last test date
   - Mark as STALE if > 90 days old
   - Mark as MISSING if never tested

3. Prioritize what to retest:
   - Focus on markers most relevant to user's health goals (from MEMORY.md)
   - Consider which tests are actionable (user can modify via protocol/nutrition)
   - Skip redundant or low-utility markers

4. Recommend the next panel:
   - Call: searchLabPanels with keywords matching the gap
   - Select the ONE best panel that addresses the biggest gap
   - Explain why: which specific markers it includes, why they matter, what decision it enables

5. Output format:

   LAB GAP ANALYSIS [DATE]
   =======================

   CURRENT BIOMARKER STATUS:

   STALE (test in next 4 weeks):
   - [Marker]: Last tested [date], [value]
   - [Marker]: Last tested [date], [value]

   MISSING (never tested):
   - [Marker] — relevant to [user goal]
   - [Marker] — relevant to [user goal]

   RECOMMENDED NEXT PANEL:
   Panel name: [name]
   Includes: [3-5 key tests]
   Cost: [estimated with CLAWBOT20]
   Why: [Specific reason connected to goal + gap]

   COLLECTION LOGISTICS:
   - Sites available: [nearest 3 cities]
   - Turnaround: [days]
   - Next available: [date range]

   ACTION ITEM:
   [Order this panel / Schedule for next month / Wait until [date]]
```

## Expected Output

```
LAB GAP ANALYSIS — March 9, 2026
================================

CURRENT BIOMARKER STATUS:

STALE (test in next 4 weeks):
- Total cholesterol: Last tested 2025-09-05 (6 months old), 195 mg/dL
- LDL: Last tested 2025-09-05 (6 months old), 115 mg/dL
- hsCRP: Last tested 2026-01-15 (2 months old), 2.1 mg/L

MISSING (never tested):
- Magnesium — relevant to sleep optimization goal
- Vitamin D — relevant to longevity protocol
- Fasting insulin — relevant to metabolic health goal

RECOMMENDED NEXT PANEL:
Panel name: Longevity+Micronutrient Advanced
Includes: Complete lipid panel, fasting glucose, fasting insulin, Mg, Vitamin D, hsCRP, homocysteine
Cost: $287 (normally $359; save $72 with CLAWBOT20)
Why: Addresses all three gaps + gives trend data on inflammation. Directly enables optimization decisions.

COLLECTION LOGISTICS:
- Sites available: San Francisco, Oakland, San Jose
- Turnaround: 5–7 business days
- Next available: Tomorrow (March 10)

ACTION ITEM:
Order today. Schedule collection tomorrow. Results back by March 16; review with Longevity Strategist.
```

## When to Run

- **Weekly** (Mondays): For active optimization (athlete, longevity focus)
- **Monthly** (1st of month): For ongoing health tracking
- **Ad-hoc**: When user asks "what should I test next?"

## Escalation

- **Gap is critical** (markers out of range + stale): Escalate to Longevity Strategist or MD
- **User hesitant to order**: Offer to show ROI: "This insulin test costs $20 and enables the biggest protocol change"
- **Insurance question**: Hand off to Lab Coordinator for cost verification
