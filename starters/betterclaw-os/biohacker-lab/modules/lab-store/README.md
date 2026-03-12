# Module: Lab Store

Browse, compare, and order lab panels through Betterness MCP.

## When Active
Shown when the user asks about ordering labs, or when the retest planner recommends specific panels.

## Data Sources
- Betterness MCP: `listAvailableLabTests`, `purchaseLabTest`, `purchaseLabTestWithCheckout`
- Local memory: retest schedule (to recommend the right panels)

## Output
Panel options with: name, markers included, price, and relevance to the user's retest needs. Facilitates ordering through Betterness MCP.

## Key Panels
- Betterness Biological Age ($89) — the 9 PhenoAge biomarkers
- Betterness Comprehensive ($179) — full panel including bio age markers
- Standard panels: CMP ($29), CBC ($19), Lipid ($39), Thyroid ($89)
- Specialty: Iron panel, Hormone panel, Inflammation markers
