# Contributing to Betterness Skills

Welcome to the SkillGraph -- the largest graph-connected health agent skill library. Every skill you contribute makes BETT-i smarter for millions of users. Whether you are adding a new skill, refining a persona overlay, or submitting an evidence bundle, your work directly shapes how AI health agents reason, adapt, and act.

## How to Contribute a Skill

1. **Fork the repo** and create a feature branch.
2. **Create a new `.md` file** in the appropriate category folder (e.g., `sleep-recovery/`, `nutrition-food/`). Use kebab-case for the filename: `my-new-skill.md`.
3. **Include required YAML frontmatter** at the top of the file with the following fields:

```yaml
---
name: "Your Skill Name"
description: "One-line description of what this skill does."
version: "1.0.0"
author: "Your Name <your@email.com>"
category: "sleep-recovery"
requires:
  tools:
    - tool_name_1
    - tool_name_2
  data:
    - data_source_1
skillgraph:
  domains:
    - sleep
    - recovery
  device_affinities:
    - whoop
    - oura
  goals:
    - optimize-recovery
  actions_enabled:
    - schedule
    - remind
  connection_upsell:
    - eight-sleep
  complements:
    - related-skill-id
  persona_compatible:
    - attia-longevity
  evidence_bundles:
    - huberman-sleep-light-stress
---
```

4. **Write the skill instructions in markdown** below the frontmatter. This is the prompt template that BETT-i uses when the skill is activated.
5. **Submit a pull request** with a clear description of what your skill does and why it belongs in the chosen category.

## Required Fields Checklist

Every skill **must** include these frontmatter fields:

- [ ] `name` -- human-readable skill name
- [ ] `description` -- one-line summary
- [ ] `version` -- semver (start with `1.0.0`)
- [ ] `author` -- name and email
- [ ] `category` -- must match one of the 16 category IDs in `_categories.json`
- [ ] `requires.tools` -- at least one MCP tool binding
- [ ] `requires.data` -- data sources the skill reads
- [ ] `skillgraph` block -- at minimum `domains`, `goals`, and `actions_enabled`

## Skill Quality Bar

Every skill must meet these standards to be merged:

- **Must declare at least one MCP tool.** Skills that cannot call a tool are knowledge cards, not skills. If your skill only explains a concept, it does not belong here.
- **Must handle missing data gracefully.** If a user has not connected Whoop, the skill should degrade to manual input or surface a connection upsell -- never fail silently or produce empty output.
- **Must include at least one action pathway.** Every skill should route into at least one concrete action: schedule an appointment, set a reminder, order a lab, recommend a product, or refer to a coach.
- **Must include connection upsell suggestions.** If additional data sources would improve the skill, declare them in `connection_upsell` so BETT-i can prompt users to connect them.

## How to Contribute a Persona Overlay

Persona overlays live in `persona-overlays/` as subfolders. Each overlay modifies reasoning style, voice, evidence preference, and risk posture without changing the underlying skill.

1. Create a new folder in `persona-overlays/` named with kebab-case (e.g., `galpin-performance-coach`).
2. Include a `README.md` that defines the overlay with fields matching `_persona-overlay.schema.json`.
3. Describe the persona's voice, decision framework, evidence style, and risk tolerance.
4. List which skill categories and domains the overlay is compatible with.

## How to Contribute an Evidence Bundle

Evidence bundles live in `_evidence-bundles/` as subfolders. Each bundle is a reusable collection of studies, protocols, and citations that skills can reference.

1. Create a new folder in `_evidence-bundles/` named with kebab-case (e.g., `strength-hypertrophy`).
2. Include a `README.md` with the bundle definition: title, domain, key studies, protocol summaries, and citation format.
3. Reference your bundle from skills using the `evidence_bundles` field in the skillgraph block.

## PR Review Process

1. **Automated checks** -- frontmatter schema validation, required fields, category ID match.
2. **Maintainer review** -- a Betterness team member reviews for quality bar compliance, graph connectivity, and consistency with existing skills.
3. **Merge** -- once approved, your skill is live in the SkillGraph and available to BETT-i.

Typical review time is 3-5 business days. For faster review, ensure your PR description explains the skill's purpose, target user segment, and which existing skills it complements.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). By participating, you agree to uphold a welcoming, inclusive, and respectful environment for everyone.
