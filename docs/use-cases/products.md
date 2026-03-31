# Products: Health-Context-Aware Commerce

## Who This Is For

Supplement brands, wellness product companies, health tech manufacturers, functional food companies, and any business that sells products where user health context would improve recommendations, safety, and outcomes.

## The Pain

Products cannot access user health context. A supplement brand sells magnesium to everyone the same way, whether the customer is deficient or already at optimal levels. A protein powder company cannot recommend the right product for someone who just got bloodwork showing impaired kidney function. A sleep supplement brand has no idea whether their customer's sleep problem is actually a cortisol problem.

The result is generic recommendations, wasted money on unnecessary products, missed opportunities to help, and occasional safety issues when products interact poorly with a user's health profile.

Product companies spend millions on marketing to acquire customers, but have zero health intelligence to retain them. They cannot say "your Vitamin D hit optimal range — switch to a maintenance dose" because they never knew the customer's level in the first place.

## What Betterness MCP Enables

Betterness MCP gives product companies access to opt-in user health data, enabling personalized product recommendations, safety checks, and biomarker-driven product development.

### Personalized Product Recommendations

Instead of "take 2 capsules daily," deliver recommendations informed by actual health data:
- "Your Vitamin D is at 28 ng/mL. We recommend our high-dose D3+K2 for 8 weeks, then retest."
- "Your magnesium RBC is already at 5.8 mg/dL (optimal). You do not need additional magnesium supplementation."
- "Based on your inflammatory markers (hs-CRP 2.4), our omega-3 formula would be the most impactful product for you right now."

### Safety Checks

Flag potential issues before they become problems:
- Supplements that interact with biomarker patterns (e.g., iron supplementation when ferritin is already elevated)
- Products that may be inappropriate given lab values (e.g., high-dose calcium with already-elevated blood calcium)
- Combinations of supplements that may interact

### Biomarker-Driven Product Suggestions

Let the health data drive the product recommendation instead of the marketing funnel:
1. User shares their lab data
2. Agent identifies biomarker gaps or suboptimal ranges
3. Agent matches gaps to products that address them
4. User sees recommendations ranked by health impact, not profit margin

### Outcome Tracking

Close the loop between product purchase and health outcome:
- "You started our sleep formula 6 weeks ago. Your deep sleep has increased from 16% to 22%."
- "After 3 months on our vitamin D protocol, your levels went from 28 to 52 ng/mL. Switching to maintenance dose."
- "Your omega-3 index improved from 4.2% to 7.8% since starting our fish oil. On track for target of 8%+."

## Key MCP Tools

| Tool | Product Application |
|------|---------------------|
| `getUserLabRecords` | Access user biomarker data for personalized recommendations |
| `searchBiomarkers` | Look up specific biomarkers to match against product benefits |
| `listAvailableLabTests` | Recommend testing to establish baselines before product use |
| `purchaseLabTest` | Enable users to order labs through the product experience |
| `getSleepData` | Track sleep product outcomes with objective data |
| `getSleepStages` | Detailed sleep architecture changes from sleep products |
| `getVitals` | Monitor HRV and heart rate response to wellness products |
| `getActivityData` | Track energy and activity changes from supplements |
| `getBodyComposition` | Monitor body composition changes from nutrition products |
| `getBiologicalAge` | Track biological age as a high-level wellness product outcome |

## Example Workflows

### Personalized Supplement Stack Builder

**Prompt**: "Based on my recent bloodwork, what supplements should I actually be taking? I do not want to waste money on things I do not need."

The agent:
1. Calls `getUserLabRecords` to pull recent lab results
2. Identifies biomarkers that are suboptimal or deficient
3. Cross-references with the product catalog
4. Filters out products the user does not need (already optimal)
5. Ranks remaining products by health impact

```
PERSONALIZED SUPPLEMENT ANALYSIS

Based on your lab results from February 2026:

RECOMMENDED (clear deficiency or suboptimal level):
  1. Vitamin D3 + K2 (5000 IU) — Your level: 24 ng/mL (deficient, target: 50-70)
     Priority: HIGH. Take daily with fat-containing meal. Retest in 8 weeks.

  2. Omega-3 (EPA/DHA 2000mg) — Your omega-3 index: 3.8% (low, target: 8-12%)
     Priority: HIGH. Anti-inflammatory benefit + cardiovascular protection.

  3. Magnesium Glycinate (400mg) — Your RBC Mg: 4.2 mg/dL (low-normal, target: 5.5+)
     Priority: MEDIUM. Take before bed for sleep quality benefit.

NOT NEEDED (already optimal):
  - B12: Your level 680 pg/mL (optimal)
  - Iron: Ferritin 78 ng/mL (optimal)
  - Zinc: 95 mcg/dL (adequate)
  - CoQ10: Not tested, but no clinical indication

SUGGESTED TESTING:
  - Omega-3 index (to establish baseline before starting fish oil)
  - Homocysteine (relevant if considering B-vitamin stack)
```

### Product Safety Check

**Prompt**: "A customer wants to add our iron supplement to their stack. They have shared their health data. Is it safe?"

The agent:
1. Calls `searchBiomarkers` for ferritin, serum iron, TIBC, transferrin saturation
2. Evaluates whether iron supplementation is appropriate

```
SAFETY CHECK — Iron Supplementation

Current labs:
  Ferritin: 185 ng/mL (elevated — reference: 20-150 for women, 30-400 for men)
  Serum iron: 142 mcg/dL (high-normal)
  Transferrin saturation: 42% (elevated)

RECOMMENDATION: DO NOT SUPPLEMENT WITH IRON

This customer's iron stores are already elevated. Additional iron supplementation
could push ferritin further above range, increasing oxidative stress risk.

Suggest:
  1. Decline the iron supplement sale for this customer
  2. Recommend they discuss elevated ferritin with their physician
  3. Consider offering antioxidant products instead (relevant to their profile)
```

### Outcome Tracking Report

**Prompt**: "Generate a 90-day outcome report for customers using our sleep formula. Show objective sleep data changes."

The agent aggregates anonymized data from customers who:
- Purchased the sleep formula
- Opted in to health data sharing
- Have 90+ days of sleep tracking data

```
PRODUCT OUTCOME REPORT — Sleep Formula (90-day cohort)
Customers with data: 342

SLEEP DURATION:
  Pre-product average: 6.3h
  Post-90-day average: 6.9h (+9.5%)
  Customers who improved: 71%

DEEP SLEEP:
  Pre-product average: 15.8%
  Post-90-day average: 20.1% (+27.2%)
  Customers who improved: 68%

SLEEP ONSET (time to fall asleep):
  Pre-product average: 28 min
  Post-90-day average: 18 min (-35.7%)
  Customers who improved: 74%

HRV DURING SLEEP:
  Pre-product average: 42ms
  Post-90-day average: 49ms (+16.7%)
  Customers who improved: 62%

SEGMENTED ANALYSIS:
  Best responders: customers with pre-product deep sleep <15%
  Weak responders: customers with pre-product deep sleep >22%
  (Product is most effective for those starting with poor deep sleep)

MARKETING INSIGHT:
  Target audience for best ROI: adults with deep sleep <15%
  and no diagnosed sleep disorders. This is the segment where
  your product shows the strongest objective improvement.
```

### Biomarker-Driven Product Development

**Prompt**: "What are the most common biomarker deficiencies across our customer base? This should inform our next product development."

The agent analyzes aggregate (anonymized) customer health data:

```
CUSTOMER BIOMARKER GAPS (anonymized aggregate, n=2,847)

MOST COMMON DEFICIENCIES:
  1. Vitamin D <30 ng/mL — 62% of customers
  2. Omega-3 index <4% — 54% of customers
  3. Magnesium RBC <5.0 — 48% of customers
  4. B12 <400 pg/mL — 31% of customers
  5. Ferritin <30 ng/mL — 28% of customers (primarily female)

MOST COMMON SUBOPTIMAL (not deficient, but below optimal):
  1. Vitamin D 30-50 ng/mL — 24% of customers
  2. HbA1c 5.5-5.7% — 19% of customers
  3. hs-CRP 1.0-3.0 — 22% of customers

PRODUCT OPPORTUNITY:
  Highest unmet need: Metabolic health formula targeting the 19%
  with pre-diabetic HbA1c + 22% with elevated inflammation.
  Your current product line does not address metabolic health.
  Berberine + chromium + alpha-lipoic acid formulation would
  target your largest underserved customer segment.
```

## Integration Models

### Direct Integration

Build Betterness MCP into your product's app or website:
- Customer connects health data during onboarding
- Product recommendations are personalized from day one
- Outcome tracking runs automatically

### Partner Integration

Offer Betterness as an opt-in feature:
- "Connect your health data for personalized recommendations"
- Customers who opt in get better recommendations and outcome tracking
- You get aggregate product effectiveness data

### API-Only Integration

Use the MCP tools server-side without a customer-facing UI:
- Customer shares a Betterness data link
- Your system queries their data and generates recommendations
- Results are delivered through your existing product experience

## Privacy and Consent

- **Explicit opt-in**: Customers must actively choose to share health data with the product company
- **Purpose limitation**: Data is used only for product recommendation and outcome tracking, not sold or used for unrelated marketing
- **Granular sharing**: Customers choose which data types to share (labs only, wearables only, or all)
- **Revocation**: Customers can revoke access at any time
- **No data retention**: Product companies access data in real-time through MCP, not by storing copies
- **Aggregate analysis**: Population-level product effectiveness analysis uses only anonymized, aggregated data

## Getting Started

1. Register as a product partner at [betterness.ai](https://betterness.ai)
2. Map your product catalog to relevant biomarkers and health metrics
3. Integrate Betterness MCP into your product recommendation engine
4. Offer health data connection as an opt-in feature for customers
5. Begin tracking product outcomes against objective health metrics
6. Use aggregate insights to inform product development

## Recommended Skills

- `biomarker-trend-reviewer` — Individual biomarker analysis for personalized recommendations
- `lab-gap-detector` — Identify what testing a customer needs before starting a product
- `sleep-quality-analyzer` — Outcome tracking for sleep-related products
- `training-readiness-evaluator` — Outcome tracking for performance products

## Recommended Persona

**Wellness Coach Overlay** — Customer-facing product recommendations should be warm, encouraging, and focused on empowerment. Avoids clinical jargon that might intimidate consumers.
