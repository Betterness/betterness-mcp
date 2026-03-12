# Biohacker Lab — Workspace

## Home View

The Biohacker Lab workspace opens to a single "status" view. Not a dashboard. Not tabs. One cohesive surface that answers the core question: **What changed, what matters, and what should I do next?**

### The Biomarker Status Card

The first thing the user sees is a biomarker status card:

```
┌─────────────────────────────────────────┐
│  🧬  Biomarker Status                  │
│                                         │
│  Last panel: Feb 14 (25 days ago)       │
│  Bio age: 33.1 → 32.4 (↓ 0.7 years)   │
│  Improving: Vitamin D, hsCRP, HbA1c    │
│  Watch: Ferritin trending down (3 draws)│
│                                         │
│  → Retest: ferritin, iron panel (due)   │
│  → Review: supplement stack impact      │
└─────────────────────────────────────────┘
```

Status views:
- **Latest Panel** — what changed on the most recent draw, ranked by significance
- **Trends** — directional movement across draws for all tracked markers
- **Gaps** — what is missing, stale, or overdue for retest
- **Protocol** — current stack and interventions mapped to target markers

The status card always leads with what changed and what to do. Not a table of numbers.

### Below the Status Card

After the biomarker status card, the workspace shows contextual modules based on what is relevant:

1. **Biomarker Review** (shown after new panel upload) — full panel interpretation with trend context
2. **Biological Age Trend** (always shown when 2+ draws exist) — PhenoAge trajectory with per-marker contribution
3. **Retest Planner** (shown when retests are due or overdue) — what to retest and when
4. **Protocol Tracker** (always shown) — active interventions and their target markers
5. **Supplement Stack** (shown when supplements are logged) — full inventory with quality and timing
6. **Lab Store** (shown on request) — browse and order panels through Betterness MCP
7. **Product Quality Checker** (shown on request) — validate supplement brands and formulations

### What Is NOT on the Home View

- A spreadsheet of every biomarker with reference ranges
- A navigation bar with tabs for each biomarker category
- A graph gallery with 20 charts
- A multi-agent routing visualization
- Generic supplement recommendations without protocol context

---

## Workspace Composition Rules

### Always visible
- Biomarker status card (latest panel summary)
- Biological age trend (when 2+ draws exist)
- Protocol tracker

### Conditionally visible
- Biomarker review — after a new panel is uploaded or reviewed
- Retest planner — when retests are due or overdue
- Supplement stack — when supplements are logged
- Lab store — when the user asks about ordering
- Product quality checker — when the user asks about a specific product or brand

### Never auto-shown
- Raw biomarker data tables
- Full reference range comparisons
- Historical panel PDFs
- Multi-agent routing visualization
- Generic supplement advice

---

## Interaction Model

The user interacts with Biohacker Lab primarily through natural conversation, not through clicking dashboard widgets.

### Common interactions

- **Panel review:** "What changed on my last panel?" → biomarker review with trend context
- **Specific marker:** "How's my ferritin trending?" → trajectory with protocol correlation
- **Retest planning:** "What should I retest next?" → prioritized retest recommendations
- **Protocol check:** "Is my vitamin D protocol working?" → before/after comparison with timeline
- **Stack review:** "Review my supplement stack" → full inventory with quality and effectiveness assessment
- **Bio age:** "What's my biological age doing?" → PhenoAge trend with per-marker drivers
- **Lab ordering:** "I need to order labs" → panel recommendations and ordering flow
- **Deep dive:** "Why is my homocysteine rising?" → cross-domain analysis via Betterness Graph
- **Product check:** "Is Thorne a good brand for magnesium?" → quality validation

### Conversation principles

1. Answer the question first, then offer to go deeper
2. Always include an action — retest, adjust, hold, or order
3. Reference personal trajectory, not population averages
4. Acknowledge protocol context before interpreting changes
5. Keep responses concise — expand only when asked

---

## OpenClaw-Native Integration

Biohacker Lab uses OpenClaw workspace primitives:

- **Workspace files** — AGENTS.md, SOUL.md, etc. define behavior
- **Skills** — biomarker-interpretation and retest-decision as workspace skills
- **Heartbeat** — morning context and weekly biomarker summaries
- **Cron** — retest reminders and protocol check-ins
- **Channels** — biomarker context persists across conversation sessions
- **Memory** — protocol state and supplement stack in `memory/`
- **Browser** — supplement research and product quality validation

The workspace should feel like OpenClaw made dramatically better for biomarker optimization — not a foreign framework attached to it.
