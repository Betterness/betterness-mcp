# SkillGraph: Graph-Connected Health Agent Skills

The SkillGraph is the Betterness MCP skill system. Unlike flat prompt libraries where skills are isolated text files, the SkillGraph models skills as nodes in a directed graph with typed edges that express dependencies, compositions, and data flows between skills.

## Why a Graph?

Flat prompt libraries have a fundamental problem: they treat each skill as independent. But health intelligence is inherently relational. A sleep analysis skill needs vitals data. A biomarker review skill should know about recent activity. A morning brief composes multiple skills together. A clinical persona changes how every skill reasons.

The SkillGraph makes these relationships explicit and machine-navigable.

**Flat library approach:**
```
skills/
  sleep-analysis.md       # standalone prompt
  biomarker-review.md     # standalone prompt
  morning-brief.md        # manually references others by name
```

**SkillGraph approach:**
```
sleep-quality-analyzer ──USES_TOOL──> getSleepData
                       ──USES_TOOL──> getSleepStages
                       ──COMPLEMENTS──> training-readiness-evaluator
                       ──FEEDS_INTO──> morning-brief-composer

biomarker-trend-reviewer ──USES_TOOL──> getUserLabRecords
                         ──USES_TOOL──> searchBiomarkers
                         ──REQUIRES──> lab-data-source
                         ──FEEDS_INTO──> morning-brief-composer

morning-brief-composer ──COMPOSES──> sleep-quality-analyzer
                       ──COMPOSES──> biomarker-trend-reviewer
                       ──COMPOSES──> training-readiness-evaluator
```

The graph lets the system automatically resolve what tools to load, what data is needed, what skills compose together, and what persona overlays are compatible.

## Node Types

Every entity in the SkillGraph is a node with a type.

| Node Type | Description | Example |
|-----------|-------------|---------|
| **Skill** | A health reasoning skill with prompt instructions, declared MCP tools, and actions | `sleep-quality-analyzer` |
| **PersonaOverlay** | A reasoning layer that modifies voice, priorities, and evidence style | `sports-medicine-overlay` |
| **Device** | A health data source (wearable, lab provider, manual) | `oura-ring`, `quest-labs` |
| **Biomarker** | A specific health metric that can be tracked | `vitamin-d`, `hrv`, `vo2max` |
| **LabPanel** | A group of biomarkers ordered together | `comprehensive-metabolic-panel` |
| **Mission** | A goal-oriented workflow composed of skills | `marathon-taper-mission` |
| **Tool** | An MCP tool exposed by the Betterness server | `getSleepData` |

## Edge Types

Edges are directed and typed. They express how nodes relate.

| Edge Type | From -> To | Meaning |
|-----------|-----------|---------|
| **USES_TOOL** | Skill -> Tool | This skill calls this MCP tool |
| **REQUIRES** | Skill -> Device or Biomarker | This skill needs this data source or metric to function |
| **COMPLEMENTS** | Skill -> Skill | These skills work well together but are not required |
| **FEEDS_INTO** | Skill -> Skill | Output of source skill is input to target skill |
| **COMPOSES** | Skill -> Skill | Parent skill orchestrates child skill |
| **OVERLAYS** | PersonaOverlay -> Skill | This persona modifies this skill's behavior |
| **TRACKS** | Device -> Biomarker | This device measures this biomarker |
| **INCLUDES** | LabPanel -> Biomarker | This panel includes this biomarker |
| **CONFLICTS_WITH** | Skill -> Skill | These skills should not be loaded simultaneously |

## How Composition Works

When a client loads a skill, the SkillGraph resolver walks the graph to determine what else is needed.

### Example: Loading `morning-brief-composer`

1. **Resolve direct dependencies**: Walk `COMPOSES` edges to find child skills:
   - `sleep-quality-analyzer`
   - `biomarker-trend-reviewer`
   - `training-readiness-evaluator`

2. **Resolve tool requirements**: Walk `USES_TOOL` edges from all resolved skills:
   - `getSleepData`, `getSleepStages` (from sleep analyzer)
   - `getUserLabRecords`, `searchBiomarkers` (from biomarker reviewer)
   - `getVitals`, `getActivityData`, `getBodyComposition` (from readiness evaluator)

3. **Resolve data requirements**: Walk `REQUIRES` edges to identify needed data sources:
   - Sleep-tracking device (Oura, Whoop, etc.)
   - Lab data source
   - Activity-tracking device

4. **Check persona compatibility**: If a persona overlay is active, verify it has `OVERLAYS` edges to the loaded skills. Warn if incompatible.

5. **Check conflicts**: Walk `CONFLICTS_WITH` edges. If any loaded skills conflict, warn the user and ask which to keep.

The client then loads only the MCP tools that the resolved skill set actually needs, rather than loading every available tool.

### Composition Modes

| Mode | Behavior |
|------|----------|
| **Sequential** | Child skills execute in order, each receiving the previous skill's output |
| **Parallel** | Child skills execute simultaneously, results are merged |
| **Conditional** | Child skills execute based on data availability or preceding results |

The `morning-brief-composer` uses conditional composition: it runs the sleep analyzer only if sleep data exists, the biomarker reviewer only if lab data exists, and always runs the readiness evaluator (which gracefully handles missing data).

## The SkillGraph Metadata Block

Every skill file includes a YAML frontmatter block that defines its position in the graph. Here are the fields:

```yaml
---
# === IDENTITY ===
id: sleep-quality-analyzer           # Unique identifier (kebab-case)
name: Sleep Quality Analyzer          # Human-readable name
version: 1.0.0                       # Semantic version
category: health-data                 # Folder/category this skill belongs to
description: >                        # One-line description
  Analyzes sleep data from wearables to assess quality, patterns, and recovery

# === SKILLGRAPH ===
skillgraph:
  node_type: Skill                    # Node type (Skill, PersonaOverlay, etc.)

  # Tools this skill declares it will use
  tools:
    - getSleepData
    - getSleepStages
    - getVitals                       # Optional: used for HRV correlation

  # What this skill requires to function
  requires:
    - type: Device
      category: sleep-tracker
      optional: false

  # Skills this works well with
  complements:
    - training-readiness-evaluator
    - biomarker-trend-reviewer

  # Skills that consume this skill's output
  feeds_into:
    - morning-brief-composer

  # Persona overlays known to work with this skill
  compatible_personas:
    - sports-medicine-overlay
    - longevity-overlay
    - clinical-overlay

  # Skills that conflict (should not be loaded together)
  conflicts_with: []

# === EVIDENCE ===
evidence_sources:
  - "Walker, M. (2017). Why We Sleep. Scribner."
  - "American Academy of Sleep Medicine Clinical Guidelines"

# === TAGS ===
tags:
  - sleep
  - recovery
  - wearables
  - hrv
---
```

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique identifier, must match filename (kebab-case) |
| `name` | string | Human-readable display name |
| `version` | string | Semantic version (major.minor.patch) |
| `category` | string | Category folder name |
| `description` | string | Brief description of what the skill does |
| `skillgraph.node_type` | string | Must be `Skill` for skills, `PersonaOverlay` for overlays |
| `skillgraph.tools` | array | List of MCP tool names this skill uses (must not be empty for skills) |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `skillgraph.requires` | array | Data source or biomarker dependencies |
| `skillgraph.complements` | array | IDs of complementary skills |
| `skillgraph.feeds_into` | array | IDs of skills that consume this skill's output |
| `skillgraph.compatible_personas` | array | IDs of persona overlays tested with this skill |
| `skillgraph.conflicts_with` | array | IDs of skills that should not coexist |
| `evidence_sources` | array | Academic or clinical references |
| `tags` | array | Searchable tags |

## Schema Validation

All SkillGraph metadata is validated against the JSON Schema at [`_skillgraph.schema.json`](../../_skillgraph.schema.json) in the repository root. Use this schema to:

- Validate skills before submitting a PR
- Auto-generate documentation
- Build tooling that navigates the graph

```bash
# Validate a skill file's frontmatter against the schema
npx ajv validate -s _skillgraph.schema.json -d extracted-frontmatter.json
```

## Design Principles

1. **Declare, don't assume** — Every skill explicitly lists the MCP tools it uses. No implicit tool access.
2. **Graceful degradation** — Skills must handle missing data. Mark requirements as `optional: true` when the skill can still provide value without them.
3. **Composability over monoliths** — Prefer small, focused skills that compose into larger workflows over single massive skills that try to do everything.
4. **Personas are overlays, not skills** — Persona overlays change reasoning style but do not add new tool capabilities. They modify how skills think, not what they can do.
5. **Evidence-backed** — Skills that make health claims should cite sources in `evidence_sources`.
