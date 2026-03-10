# Persona Overlays

Persona overlays change **how** a skill thinks and communicates — not **what** it executes. They are modular, composable lenses that can be applied on top of any compatible skill to shift worldview, prioritization logic, evidence threshold, communication style, and risk posture without modifying the underlying skill definition.

---

## What Overlays Are

An overlay is a set of instructions that reshape the interpretive layer between raw data and user-facing output. When an overlay is active alongside a skill, the skill still runs its full execution logic — it still fetches labs, interprets biomarkers, scores risk, or reviews products. But the overlay controls:

- **Worldview**: What framework does this advisor see the world through? (Risk-reduction vs. performance optimization vs. safety-first vs. cycle-aware)
- **Prioritization**: Given N findings, which ones does this advisor surface first?
- **Evidence threshold**: How strong does evidence need to be before the advisor recommends an intervention? Mechanistic only? RCT-backed? Observational acceptable?
- **Communication style**: Clinically precise? Protocol-heavy? Educational with mechanism explanations? Coaching-direct?
- **Risk posture**: How conservative or aggressive is this advisor on supplements, interventions, lab ordering, specialist referral?

Overlays do **not** invent new skills. They do not add capabilities that the underlying skill doesn't have. They shape how existing capabilities are deployed.

---

## How Overlays Pair With Skills

Each overlay declares `compatible_skills`, `compatible_specialists`, and `compatible_domains`. These are the contexts where the overlay is appropriate to activate.

Pairing is additive: the skill provides the execution engine, the overlay provides the interpretive lens. A `longevity-protocol` skill paired with the `attia-inspired-longevity-strategist` overlay will run the same biomarker analysis but prioritize ApoB and VO2 max, cite mechanistic evidence, recommend against low-ROI supplements, and frame everything as long-horizon risk reduction.

The same `longevity-protocol` skill without an overlay activates in a neutral, balanced mode.

---

## Overlay Rules

### 1. Expert-inspired, never impersonation

Overlays labeled `overlay_type: expert-inspired` are inspired by publicly documented frameworks, research, protocols, and published work associated with a practitioner or field — not by imitating a specific person. The overlay captures a **methodology**, not a voice. Never claim to be a specific person or simulate their private views. Always attribute to frameworks and literature, not to individuals.

### 2. Source-grounded, never style imitation

The overlay's `knowledge_sources` field defines the evidentiary foundation. All recommendations must be traceable to those sources or to the underlying skill's data. Style choices (directness, protocol-orientation, mechanistic depth) reflect the overlay's design, but they do not override evidence or fabricate citations.

### 3. Explicit about evidence threshold

Every overlay has a defined `evidence_style`. When making recommendations under an overlay, the threshold for what constitutes sufficient evidence must be transparent. A conservative overlay that requires RCT-backing should say "the evidence for X is mostly observational — I'd hold off." An overlay comfortable with mechanistic reasoning should say "the mechanism is well-understood even if large trials are sparse."

### 4. Explicit about contraindications

Every overlay has a `risk_posture` and a boundaries/contraindications section. When a user's situation falls outside the overlay's appropriate scope — pregnancy, active disease, medications, clinical-grade symptoms — the overlay must route to clinical care rather than extend beyond its domain. Overlays amplify skill capability within a domain; they do not replace medical diagnosis or treatment.

---

## Available Overlays

| Overlay | Type | Domain | Key Lens |
|---|---|---|---|
| `attia-inspired-longevity-strategist` | expert-inspired | longevity, metabolic, cardiovascular | ApoB, VO2 max, metabolic health |
| `huberman-inspired-sleep-and-stress-operator` | expert-inspired | sleep, recovery, circadian | Adenosine, cortisol, light timing |
| `endurance-performance-coach` | role-based | fitness, endurance, recovery | ACWR, polarized training, HRV |
| `metabolic-health-operator` | domain-specific | metabolic, nutrition | Glucose stability, insulin sensitivity |
| `womens-health-performance-strategist` | domain-specific | womens-health, hormonal, fitness | Cycle phase, hormonal context |
| `shopper-safety-optimizer` | domain-specific | products, nutrition, safety | Ingredients, certifications, risk |

---

## How to Reference an Overlay in a Skill

```yaml
persona_overlay: attia-inspired-longevity-strategist
```

Add this field to a skill's frontmatter or to a mission's configuration to activate the overlay for that skill execution. If no overlay is declared, the skill runs in its default neutral mode.
