# Persona Overlays

Persona overlays are reasoning layers that change how the Betterness health agent thinks, speaks, and prioritizes information. They do not add new capabilities or tools — they modify the voice, evidence style, risk tolerance, and communication patterns of the underlying skills.

## What Persona Overlays Are

Think of a skill as **what** the agent does (analyze sleep, review biomarkers, compose a brief). A persona overlay defines **how** it does it:

- A **sports medicine overlay** makes the agent speak like a performance-focused clinician, cite exercise science literature, and prioritize recovery and readiness.
- A **longevity overlay** makes the agent focus on biological age, cite aging research, and flag long-term trends over short-term fluctuations.
- A **clinical overlay** makes the agent use formal medical terminology, cite clinical guidelines, and flag values that require physician review.

The same sleep analysis skill produces different outputs depending on which persona overlay is active:

| Persona | Same sleep data, different interpretation |
|---------|-------------------------------------------|
| Sports Medicine | "Your deep sleep was 18% of total — below the 20%+ target for recovery. Consider delaying your interval session." |
| Longevity | "Deep sleep trending down 12% over 90 days. This pattern correlates with accelerated epigenetic aging in Horvath clock studies." |
| Clinical | "Deep sleep: 1.2h (18.4% of TST). Below AASM reference range (20-25%). Recommend polysomnography if trend persists >30 days." |
| Wellness Coach | "Your deep sleep dipped a bit last night. No stress — try cutting screens 90 minutes before bed and see if it bounces back this week." |

## What They Are Not

Persona overlays are **not**:

- **Replacement skills** — They do not define new actions or tool calls. A persona overlay without an underlying skill does nothing.
- **Role-playing characters** — They are not fictional personalities. Each overlay is grounded in a real professional reasoning framework.
- **Prompt injections** — They are structured metadata that the skill composition system applies, not raw text prepended to prompts.

## Schema Fields

Persona overlays use the same SkillGraph metadata block as skills, with `node_type: PersonaOverlay` and additional overlay-specific fields:

```yaml
---
id: sports-medicine-overlay
name: Sports Medicine Overlay
version: 1.0.0
category: persona-overlays
description: >
  Applies sports medicine reasoning with focus on performance,
  recovery, and injury prevention

skillgraph:
  node_type: PersonaOverlay

  # What this overlay modifies
  voice: clinical-conversational     # Communication style
  priority_frame: performance        # What matters most
  evidence_style: exercise-science   # Type of citations
  risk_posture: conservative         # How cautious with recommendations

  # Skills this overlay is designed to work with
  overlays:
    - sleep-quality-analyzer
    - training-readiness-evaluator
    - biomarker-trend-reviewer
    - morning-brief-composer

  # Overlays that conflict (loading both would produce confused reasoning)
  conflicts_with:
    - clinical-overlay               # Different evidence standards

tags:
  - sports-medicine
  - performance
  - recovery
---
```

### Overlay-Specific Fields

| Field | Type | Values | Description |
|-------|------|--------|-------------|
| `voice` | string | `clinical-formal`, `clinical-conversational`, `coaching`, `peer`, `technical` | Communication tone and vocabulary |
| `priority_frame` | string | `performance`, `longevity`, `clinical-safety`, `wellness`, `business` | What the agent optimizes for |
| `evidence_style` | string | `exercise-science`, `aging-research`, `clinical-guidelines`, `holistic`, `data-driven` | What type of evidence is cited |
| `risk_posture` | string | `conservative`, `moderate`, `aggressive` | How cautious recommendations are |

## The 6 Launch Overlays

These are the persona overlays included in the initial Betterness MCP release. Find them in `skills/persona-overlays/`.

### 1. Sports Medicine Overlay (`sports-medicine-overlay`)

**Voice**: Clinical-conversational. Speaks like an experienced sports medicine physician who respects the athlete's knowledge.

**Priority frame**: Performance and recovery. Every data point is interpreted through the lens of "can you train today and how hard."

**Evidence style**: Exercise science. Cites research from ACSM, NSCA, and sports physiology journals.

**Best paired with**: `training-readiness-evaluator`, `sleep-quality-analyzer`, `morning-brief-composer`

### 2. Longevity Overlay (`longevity-overlay`)

**Voice**: Technical but accessible. Speaks like a longevity researcher who can explain complex concepts clearly.

**Priority frame**: Biological age and healthspan. Interprets everything through long-term aging trajectories.

**Evidence style**: Aging research. Cites Horvath, Sinclair, Attia, and epigenetic/metabolic aging studies.

**Best paired with**: `biomarker-trend-reviewer`, `lab-gap-detector`, `biological-age-tracker`

### 3. Clinical Overlay (`clinical-overlay`)

**Voice**: Clinical-formal. Uses proper medical terminology and structured reporting.

**Priority frame**: Clinical safety. Flags values outside reference ranges and recommends physician consultation.

**Evidence style**: Clinical guidelines. Cites AASM, AHA, ADA, USPSTF, and specialty society guidelines.

**Best paired with**: `biomarker-trend-reviewer`, `pre-visit-summarizer`, `lab-gap-detector`

### 4. Wellness Coach Overlay (`wellness-coach-overlay`)

**Voice**: Coaching. Warm, encouraging, focuses on behavior change and small wins.

**Priority frame**: Sustainable wellness. Interprets data through the lens of habit formation and lifestyle.

**Evidence style**: Holistic. Blends evidence-based recommendations with practical behavioral strategies.

**Best paired with**: `sleep-quality-analyzer`, `morning-brief-composer`, `training-readiness-evaluator`

### 5. Biohacker Overlay (`biohacker-overlay`)

**Voice**: Peer/technical. Speaks like a fellow self-quantifier who is deeply into the data.

**Priority frame**: Optimization. Looks for marginal gains and n=1 experiment opportunities.

**Evidence style**: Data-driven. Emphasizes personal trends and quantified self methodology alongside published research.

**Best paired with**: `biomarker-trend-reviewer`, `sleep-quality-analyzer`, `biological-age-tracker`

### 6. Business Overlay (`business-overlay`)

**Voice**: Executive briefing. Concise, action-oriented, respects time constraints.

**Priority frame**: Business performance. Connects health data to energy, focus, and professional output.

**Evidence style**: Data-driven. Emphasizes correlations between health metrics and productivity.

**Best paired with**: `morning-brief-composer`, `training-readiness-evaluator`

## How to Pair with Skills

### In Claude Desktop / Claude Code

When starting a conversation, specify which persona to use:

```
Use the sports medicine persona overlay. Analyze my sleep data from the past week
and tell me if I'm recovered enough for a hard interval session today.
```

The agent will load the `sports-medicine-overlay` and apply it to the `sleep-quality-analyzer` and `training-readiness-evaluator` skills.

### In Clawbot

Set the persona in your workspace configuration:

```json
{
  "persona": "longevity-overlay"
}
```

Or switch per-mission:

```json
{
  "missions": [
    {
      "name": "daily-brief",
      "persona": "sports-medicine-overlay"
    },
    {
      "name": "quarterly-lab-review",
      "persona": "clinical-overlay"
    }
  ]
}
```

### Programmatic (MCP SDK)

Include the persona in the tool call context:

```typescript
const result = await client.callTool({
  name: "getSleepData",
  arguments: { startDate: "2026-03-01", endDate: "2026-03-09" },
  _meta: {
    persona: "sports-medicine-overlay",
  },
});
```

## Creating Custom Persona Overlays

You can create custom overlays by following the schema in `_skillgraph.schema.json`. See the [Contribution Model](./contribution-model.md) for the full process.

Key requirements for persona overlays:

1. Must set `node_type: PersonaOverlay`
2. Must define `voice`, `priority_frame`, `evidence_style`, and `risk_posture`
3. Must list which skills it overlays via the `overlays` field
4. Must not define `tools` (overlays do not add tool capabilities)
5. Should include the reasoning prompt instructions in the body of the file (below the frontmatter)

## File Location

All persona overlays live in `skills/persona-overlays/`. Each overlay is a single Markdown file with YAML frontmatter:

```
skills/
  persona-overlays/
    sports-medicine-overlay.md
    longevity-overlay.md
    clinical-overlay.md
    wellness-coach-overlay.md
    biohacker-overlay.md
    business-overlay.md
```
