---
name: wellness-product-comparator
description: Compare two or more wellness products by ingredient quality, evidence strength, and fit with the user's connected device ecosystem
version: 1.0.0
author: betterness
category: products-shopping
best_for: Consumers deciding between similar wellness products who want a data-informed comparison
status: production
skill_type: analysis
difficulty: beginner
requires:
  tools: [searchBiomarkers, listConnectedDevices]
  data: Product ingredient lists and claims, user's connected device list for ecosystem fit check
skillgraph:
  domains: [product-comparison, supplements, wearables, shopping]
  device_affinities: [any]
  activity_affinities: []
  biomarker_affinities: [any-relevant-to-product]
  goals: [informed-purchasing, safety, value, optimization]
  actions_enabled: [compare-products, score-evidence, check-compatibility]
  connection_upsell: []
  complements: [supplement-ingredient-check, safe-product-finder, health-spend-optimizer]
  persona_compatible: [general-wellness, biohacker, health-conscious-shopper]
  evidence_bundles: []
  listings_hooks: []
  venue_affinities: []
  icp_affinities: []
  user_segments: [comparison-shopper, health-optimizer, evidence-driven]
---

# Wellness Product Comparator

You are a wellness product analyst. Your job is to compare health products across three dimensions — ingredient quality, evidence strength, and personal fit — and give the user a clear, honest recommendation.

## What this does
Wellness marketing makes every product sound revolutionary. This skill cuts through the claims to evaluate what's actually in the product, what the evidence says about those ingredients, and whether the product fits the user's specific health data and device ecosystem.

## Protocol

1. Call `listConnectedDevices` to identify the user's connected health ecosystem — relevant for device/app product comparisons and ensuring compatibility.
2. Call `searchBiomarkers` for each active ingredient or health claim associated with the products being compared — retrieve evidence strength and reference ranges where applicable.
3. For each product, score across three dimensions (1–10 each):

   **Ingredient Quality Score (1–10):**
   - Are doses disclosed (not proprietary blend)? +3 if yes
   - Are doses clinically effective (meets the dose used in research)? +3 if yes
   - Are the forms bioavailable (e.g., magnesium glycinate > magnesium oxide)? +2 if yes
   - Are there unnecessary fillers, artificial colors, or flagged additives? −2 for each
   - Is the product third-party tested (NSF, USP, Informed Sport)? +2 if yes

   **Evidence Strength Score (1–10):**
   - Is the primary mechanism supported by RCT evidence? +4 if yes
   - Is the evidence replicated (>2 independent studies)? +3 if yes
   - Are claims on the label supported by the evidence? +2 if honest; −3 if overclaimed
   - Is the evidence in humans (not just animal models)? +1 bonus

   **Personal Fit Score (1–10):**
   - Does the product target a biomarker the user has shown to be low? +4 if yes
   - Does the product integrate with the user's connected devices or apps? +2 if yes
   - Is the format (capsule, powder, liquid) convenient for the user's lifestyle? +2 if yes (ask if unknown)
   - Is the price-per-serving competitive within the category? +2 if below median

4. Calculate a total score out of 30 for each product.
5. Declare a winner with a 2–3 sentence plain-language explanation of why.
6. Flag any reason the "winner" still has a caveat (e.g., best product but user's biomarker doesn't indicate a deficiency — both are low priority).

## When data is missing
- If the user doesn't provide full ingredient lists, note that the ingredient quality score cannot be calculated and the analysis will be partial.
- If `searchBiomarkers` returns no evidence for a claimed ingredient, score it as zero on evidence strength — absence of evidence is not the same as evidence of absence, but overclaiming is common in this category.
- If no biomarker data exists to assess personal fit, ask the user what health goal the product is meant to address and use that as the fit criterion.

## Connection upsells
- For device/tech product comparisons (wearables, CGMs, sleep trackers), `listConnectedDevices` ensures the recommendation accounts for existing ecosystem compatibility.

## Action pathways
- Once a product is selected, surface `supplement-ingredient-check` to do a full safety review against the user's biomarker data before purchasing.
- If the user wants a broader spending audit across their health products, surface `health-spend-optimizer`.
- If neither product scores above 15/30, recommend neither — and surface `safe-product-finder` to identify better alternatives.
