# SkillGraph

SkillGraph is the health agent skill system that powers BETT-i. Each skill is a self-describing unit of health intelligence — not a prompt template, not a static knowledge card, but a composable, graph-connected capability tied to real MCP tools, user data, and actions.

## What SkillGraph Is Not

Most AI health tools ship flat prompt libraries: a list of topics an LLM can discuss. SkillGraph is different.

- Skills are **connected to real MCP tools** — a sleep skill can read Whoop HRV, trigger a recovery protocol, or schedule a rest day in your calendar.
- Skills **compose with each other** — a CGM skill and a cycling skill combine into glucose-informed fueling guidance. The graph knows this.
- Skills **adapt to what the user has connected** — a skill renders differently with an Oura ring than without one. Missing data surfaces a targeted connection upsell, not a generic disclaimer.
- Skills **route into actions** — every skill can trigger a scheduling call, a lab order, a product recommendation, or a coach referral.

## Structure of a Skill

Each skill lives in a category folder and contains:

```
skills/
  sleep-recovery/
    whoop-recovery-operator.json     # Skill definition + skillgraph metadata
    ...
  fitness-performance/
    cycling-hr-zone-optimizer.json
    ...
  _categories.json                   # 16-category taxonomy
  _skillgraph.schema.json            # Schema for skillgraph metadata blocks
  _persona-overlay.schema.json       # Schema for persona overlay definitions
  _combination-rules.md              # How skills combine
```

A skill file contains two sections:
1. **Skill definition** — name, description, category, prompt template, MCP tool bindings
2. **SkillGraph metadata block** — the graph data that drives composition, adaptation, and routing

## The 16-Category System

Categories are the top-level taxonomy. Every skill belongs to exactly one category. Categories are ordered by breadth (daily-health is the widest, device-guides is the narrowest entry point for device-first users).

| ID | Name | Purpose |
|----|------|---------|
| `daily-health` | Daily Health | Broadest entry point. Useful to any user on day one. |
| `sleep-recovery` | Sleep & Recovery | Highest wearable relevance. Strongest mass-market category. |
| `fitness-performance` | Fitness & Performance | Athletes, runners, cyclists, lifters, HIIT, HYROX, yoga. |
| `biomarkers-labs` | Biomarkers & Labs | One of the deepest Betterness moats. Routes insight into ordering, uploads, scheduling. |
| `metabolic-cgm` | Metabolic Health & CGM | Broad demand, high actionability. Connects food, exercise, sleep, labs, glucose. |
| `longevity` | Longevity | Flagship imagination category. Expert-inspired overlays and long-horizon protocols. |
| `nutrition-food` | Nutrition & Food | Expands beyond measurement into meals, grocery, fueling, restaurants. |
| `products-shopping` | Products & Shopping | Turns recommendations into user value. Supplements, comparisons, health spending. |
| `social-events-community` | Social, Events & Community | Makes wellness social, local, and discoverable. |
| `gyms-studios-coaching` | Gyms, Studios & Coaching | Ties to Barry's, Equinox, Life Time, HYROX, yoga, coaching ecosystems. |
| `womens-health` | Women's Health | First-class category. Cycle-aware, hormonal, fertility, pregnancy, menopause. |
| `travel-circadian` | Travel & Circadian | Broad-use with immediate value. Sleep, recovery, schedule, light, food. |
| `family-household` | Family & Household | Extends from solo optimization to shared lifestyle operating system. |
| `actions-automation` | Actions & Automation | Prevents the library from being passive. Reminders, scheduling, workflows. |
| `mission-control` | Mission Control | Advanced operator layer. Best installable health mission-control surface. |
| `device-guides` | Device Guides | Device-first entry for Whoop, Oura, Garmin, Apple, CGM, Eight Sleep users. |

## SkillGraph Metadata Block

Each skill carries a `skillgraph` metadata block that the recommendation engine reads at runtime. Key fields:

- **`domains`** — broad health domains (sleep, recovery, nutrition, longevity)
- **`device_affinities`** — which connected devices make this skill better
- **`biomarker_affinities`** — which lab values the skill can interpret
- **`goals`** — outcomes the skill addresses (fat-loss, performance, longevity)
- **`actions_enabled`** — what the skill can route into (schedule, order, recommend, remind)
- **`connection_upsell`** — data sources that, if connected, would improve this skill
- **`complements`** — other skills frequently combined with this one
- **`persona_compatible`** — which persona overlays fit this skill
- **`evidence_bundles`** — reusable evidence packs the skill can cite
- **`listings_hooks`** — how to connect into products, venues, services
- **`venue_affinities`** — venue and brand contexts (Barry's, Equinox, Life Time)
- **`icp_affinities`** — ICP labels from the contact/coach layer
- **`user_segments`** — user identity labels (biohacker, new-parent, competitive-athlete)

## Persona Overlays

A persona overlay is an optional reasoning layer applied on top of a skill. It changes voice, decision style, evidence style, and risk posture — without changing the underlying skill definition.

Examples:
- `attia-longevity` — precision-first, mechanistic, long-horizon, risk-aware
- `galpin-performance` — training-block-aware, periodization-driven, evidence-graded
- `huberman-protocols` — protocol-structured, timing-explicit, foundational science

Overlays are defined separately (see `_persona-overlay.schema.json`) and referenced by skill ID in the `persona_compatible` field.

## Combination Rules

Skills combine when the graph finds overlapping `device_affinities`, shared `goals`, or explicit `complements` links. The combination engine produces a merged skill context — two skills running together with shared data, coordinated actions, and a unified output.

See `_combination-rules.md` for full combination logic, archetypes, and implementation phases.

## Design Principles

1. **Every skill should be actionable.** If a skill cannot route into at least one action, it is a knowledge card, not a skill.
2. **Device connections change the skill.** A skill without device data degrades gracefully and upsells the right connection.
3. **Categories are entry points, not silos.** A cycling skill lives in fitness-performance but connects to sleep-recovery, metabolic-cgm, and nutrition-food.
4. **Evidence is reusable.** Evidence bundles are shared across skills so the same study or protocol is not duplicated.
5. **Persona overlays are optional.** A skill works without a persona overlay. Overlays add depth for users who want a specific reasoning style.
