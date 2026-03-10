# Contributing Skills to Betterness MCP

This guide explains how to create and submit new skills or persona overlays for the Betterness MCP skill library.

## Overview

The Betterness MCP skill library is open to community contributions. Skills are reviewed for quality, safety, and correctness before being merged. Every skill must declare its MCP tools, define actionable outputs, and handle missing data gracefully.

## Step-by-Step Process

### 1. Fork the Repository

```bash
git clone https://github.com/betterness/mcp.git
cd mcp
git checkout -b skill/your-skill-name
```

### 2. Choose the Right Category Folder

Place your skill in the appropriate category under `skills/`:

| Folder | For |
|--------|-----|
| `skills/health-data/` | Skills that analyze health metrics (sleep, vitals, activity, body composition) |
| `skills/biomarkers/` | Skills that work with lab results and biomarker data |
| `skills/workflows/` | Skills that compose other skills into multi-step workflows |
| `skills/persona-overlays/` | Persona overlays that modify reasoning style |
| `skills/clinical/` | Skills intended for clinical or practitioner use |
| `skills/community/` | Skills for group health and community features |

If none of these fit, propose a new category in your PR description.

### 3. Create the Skill File

Create a Markdown file named with your skill's ID (kebab-case): `skills/{category}/{skill-id}.md`

The file has two parts: YAML frontmatter (SkillGraph metadata) and the body (prompt instructions).

#### Template

```markdown
---
id: your-skill-id
name: Your Skill Name
version: 1.0.0
category: health-data
description: >
  One-line description of what this skill does

skillgraph:
  node_type: Skill
  tools:
    - toolName1
    - toolName2
  requires:
    - type: Device
      category: sleep-tracker
      optional: false
  complements:
    - related-skill-id
  feeds_into:
    - consuming-skill-id
  compatible_personas:
    - sports-medicine-overlay
    - longevity-overlay
  conflicts_with: []

evidence_sources:
  - "Author, A. (Year). Title. Publisher."

tags:
  - relevant
  - tags
---

# Your Skill Name

## Purpose

What this skill does and when to use it.

## Instructions

Step-by-step reasoning instructions for the agent when this skill is active.

1. First, call `toolName1` to retrieve...
2. Analyze the data for...
3. If data is missing, explain what data would be needed and why.
4. Present findings as...

## Output Format

Describe the expected output structure.

## Missing Data Handling

How the skill should behave when data is unavailable.
```

### 4. Follow the SkillGraph Schema

Your frontmatter must validate against `_skillgraph.schema.json`. Validate locally:

```bash
# Extract frontmatter to JSON (manual or use a yaml-to-json tool)
npx ajv validate -s _skillgraph.schema.json -d your-frontmatter.json
```

### Required Fields

Every skill must include these fields:

| Field | Description |
|-------|-------------|
| `id` | Unique kebab-case identifier, must match filename |
| `name` | Human-readable name |
| `version` | Semantic version starting at `1.0.0` |
| `category` | Must match the folder the skill is placed in |
| `description` | One-line summary |
| `skillgraph.node_type` | `Skill` or `PersonaOverlay` |
| `skillgraph.tools` | Non-empty array of MCP tool names (required for skills, must be empty for overlays) |

### Optional But Recommended Fields

| Field | Why It Matters |
|-------|---------------|
| `skillgraph.requires` | Lets the system warn users when needed data sources are not connected |
| `skillgraph.complements` | Helps discovery — users find related skills |
| `skillgraph.feeds_into` | Enables automatic workflow composition |
| `skillgraph.compatible_personas` | Lets users know which personas work well |
| `evidence_sources` | Builds trust and enables fact-checking |
| `tags` | Improves search and categorization |

### 5. Create an Evidence Bundle (If Applicable)

If your skill makes health claims or cites research, create an evidence bundle:

```
skills/{category}/evidence/
  your-skill-id/
    references.json        # Structured citation data
    notes.md               # Key findings and methodology notes
```

`references.json` format:

```json
{
  "references": [
    {
      "id": "walker-2017",
      "type": "book",
      "authors": ["Walker, Matthew"],
      "title": "Why We Sleep: Unlocking the Power of Sleep and Dreams",
      "year": 2017,
      "publisher": "Scribner",
      "relevance": "Establishes deep sleep percentage targets for recovery"
    },
    {
      "id": "aasm-2020",
      "type": "guideline",
      "organization": "American Academy of Sleep Medicine",
      "title": "Clinical Practice Guideline for the Treatment of Insomnia",
      "year": 2020,
      "url": "https://aasm.org/...",
      "relevance": "Reference ranges for sleep stage percentages"
    }
  ]
}
```

Evidence bundles are not required for all skills, but are strongly encouraged for skills that:
- Recommend health interventions
- Define "normal" or "optimal" ranges
- Suggest supplement or medication interactions
- Make claims about disease risk

### 6. Test Your Skill

Before submitting, verify:

1. **Schema validation passes** — Frontmatter validates against `_skillgraph.schema.json`
2. **Tools exist** — Every tool in `skillgraph.tools` is a real Betterness MCP tool (check with `tools/list`)
3. **Actions are defined** — The skill body includes clear step-by-step instructions with specific tool calls
4. **Missing data is handled** — The skill explicitly describes what to do when data is unavailable
5. **Persona compatibility tested** — If you list `compatible_personas`, verify the skill produces reasonable output with each listed persona
6. **No hallucinated medical claims** — All health claims are either cited or qualified as general information

### 7. Submit a Pull Request

```bash
git add skills/{category}/your-skill-id.md
git add skills/{category}/evidence/your-skill-id/  # if applicable
git commit -m "Add skill: your-skill-name"
git push origin skill/your-skill-name
```

Open a PR against the `main` branch with:

- **Title**: `Add skill: Your Skill Name`
- **Description**: What the skill does, why it is useful, what MCP tools it uses
- **Testing notes**: How you verified the skill works correctly

## Quality Bar

Your skill will be reviewed against these criteria:

### Must Have

- [ ] Declares MCP tools in `skillgraph.tools` (non-empty for skills)
- [ ] Has actionable instructions in the body (not just a description)
- [ ] Handles missing data explicitly (what to do when a tool returns no data)
- [ ] Frontmatter validates against `_skillgraph.schema.json`
- [ ] File is placed in the correct category folder
- [ ] `id` matches the filename

### Should Have

- [ ] Evidence sources for health claims
- [ ] At least one `compatible_personas` entry
- [ ] `complements` or `feeds_into` edges connecting to existing skills
- [ ] Clear output format specification
- [ ] Tags for discoverability

### Must Not Have

- [ ] Specific medical diagnoses (skills should inform, not diagnose)
- [ ] Dosage recommendations for medications
- [ ] Claims that contradict established medical guidelines without strong evidence
- [ ] Tool names that do not exist in the Betterness MCP tool set
- [ ] Hardcoded reference ranges without citation (ranges vary by lab, age, sex)

## Review Process

1. **Automated checks** — CI validates schema, checks tool names, and verifies file structure
2. **Peer review** — At least one community reviewer checks the skill logic and evidence
3. **Medical review** — Skills making health claims are reviewed by a clinical advisor (this may take additional time)
4. **Merge** — Once approved, the skill is merged and available in the next release

## Updating Existing Skills

To update an existing skill:

1. Bump the `version` field (follow semantic versioning)
2. Document what changed in the PR description
3. If tools changed, verify the new tool list is correct
4. If evidence changed, update the evidence bundle

## Questions

- **Can I submit a persona overlay?** Yes, follow the same process but use `node_type: PersonaOverlay` and place it in `skills/persona-overlays/`. See [Persona Overlays](./persona-overlays.md) for overlay-specific fields.
- **Can I submit a workflow skill?** Yes, place it in `skills/workflows/` and use `COMPOSES` edges to reference the child skills.
- **What if my skill needs a tool that does not exist yet?** Open an issue describing the tool you need. Do not reference non-existent tools in your skill.
- **Can I use external APIs in my skill?** No. Skills can only use Betterness MCP tools. If you need external data, propose it as a new MCP tool.
