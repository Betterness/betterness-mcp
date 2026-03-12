# Module: Product Quality Checker

Validates supplement brands and formulations for quality, testing, and bioavailability.

## When Active
Shown when the user asks about a specific product or brand, or when reviewing the supplement stack.

## Data Sources
- Browser: brand websites, third-party testing databases, ConsumerLab, Labdoor
- Betterness MCP: `knowledgeSearch` for evidence on supplement forms and dosing
- Local memory: current stack for interaction checking

## Output
Quality assessment for a specific product: third-party testing status, form bioavailability, dose adequacy, known interactions with current stack, and price comparison.

## Assessment Criteria
- **Third-party testing:** NSF Certified for Sport, USP Verified, ConsumerLab Approved, BSCG, Informed Sport
- **Manufacturing:** GMP/cGMP certified facility
- **Form:** bioavailable form for the target nutrient (e.g., methylfolate vs folic acid, glycinate vs oxide)
- **Dose:** clinically relevant dose vs token amount
- **Purity:** heavy metal testing, allergen disclosure
- **Value:** cost per effective dose, not just per pill
