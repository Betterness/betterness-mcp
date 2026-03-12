# Barry's / Studio Operator — Workspace

## Home View

The Studio Operator workspace opens to a single "today" view. Not a dashboard. Not tabs. One cohesive surface that answers the class-day question: **Am I ready, how hard should I go, and what do I do after?**

### The Class-Day Card

The first thing the user sees on a class day is a readiness card:

```
┌─────────────────────────────────────────┐
│  💪  Class Day — Go Hard               │
│                                         │
│  Recovery green. HRV above baseline.    │
│  Sleep was solid (7h 22m, deep sleep    │
│  above your average).                   │
│                                         │
│  → Full intensity today                 │
│  → Hydrate: 20oz before class           │
│  → Post-class plan ready when you're out│
└─────────────────────────────────────────┘
```

Readiness states:
- **Go Hard** — recovery strong, full intensity available
- **Dial to 80%** — recovery moderate, attend but manage effort
- **Skip & Recover** — recovery low, walk or rest instead of class

The card is always one sentence on how you recovered, and one clear call on what to do.

### Non-Class Day Card

On rest days, the home view shifts:

```
┌─────────────────────────────────────────┐
│  🧘  Rest Day                           │
│                                         │
│  Good call — your body is recovering    │
│  from Tuesday and Wednesday sessions.   │
│  HRV trending back up.                  │
│                                         │
│  → Walk or stretch today                │
│  → Next class: Friday 6:30 AM          │
│  → Cadence this week: 2 of 3 target    │
└─────────────────────────────────────────┘
```

### Below the Card

After the readiness card, the workspace shows contextual modules based on timing:

1. **Class-Day Readiness** (class day mornings) — detailed readiness with intensity recommendation
2. **Post-Workout Recovery** (after class) — hydration, protein, cooldown, sleep prep
3. **Nearby Nutrition** (after class) — healthy food options near the studio via maps
4. **Weekly Cadence Tracker** (always shown) — sessions this week vs target, upcoming classes
5. **Intensity Modulator** (class days) — how today's effort fits into the weekly intensity budget
6. **Studio Habit Tracker** (weekly view) — attendance streak, consistency patterns

### What Is NOT on the Home View

- A grid of HRV, resting HR, sleep stages, strain score, readiness score
- A calendar with 30 days of class history
- A "training load analysis" with acute:chronic ratios
- A multi-agent visualization
- Settings or device configuration as the first screen

---

## Workspace Composition Rules

### Always visible
- Readiness card (class day) or rest day card
- Weekly cadence tracker

### Conditionally visible
- Class-day readiness — morning of a class day
- Post-workout recovery — after a class (detected via wearable strain or user confirmation)
- Nearby nutrition — after class, when the user asks or automatically after workout detection
- Intensity modulator — class days, when the week has multiple sessions
- Studio habit tracker — in weekly summaries or when the user asks about consistency
- Body composition trend — when Withings or body comp data exists

### Never auto-shown
- Raw wearable data exports
- Historical data tables
- Multi-agent routing visualization
- Generic fitness advice unrelated to the studio habit

---

## Interaction Model

The user interacts with Studio Operator primarily through natural conversation, timed around the class experience.

### Common interactions

- **Pre-class check:** "I have class today — am I ready?" → readiness card with intensity call
- **Post-class:** "Just finished class" → recovery plan with hydration, food, and sleep prep
- **Food search:** "What's healthy near the studio?" → maps-powered nearby options
- **Week planning:** "How many classes should I do this week?" → cadence recommendation based on recovery
- **Intensity question:** "Should I do the double tomorrow?" → assessment based on current recovery trajectory
- **Streak check:** "How's my consistency?" → attendance patterns and habit tracking
- **Deep dive:** "Am I overtraining?" → cross-domain analysis via Betterness Graph

### Conversation principles

1. Answer the question first, then offer to go deeper
2. Every insight is timed to the class experience — before, after, or planning
3. Use the readiness framework (go hard / dial to 80% / skip) consistently
4. Reference personal recovery patterns, not generic fitness advice
5. Keep it warm and brief — this person is on their way to or from class

---

## OpenClaw-Native Integration

Studio Operator uses OpenClaw workspace primitives:

- **Workspace files** — AGENTS.md, SOUL.md, etc. define behavior
- **Skills** — class-readiness and post-class-plan as workspace skills
- **Heartbeat** — pre-class and post-class automated check-ins
- **Cron** — weekly cadence summaries
- **Maps** — nearby nutrition and healthy food options
- **Channels** — class-day context persists across conversation sessions
- **Memory** — daily logs and preferences in `memory/`

The workspace should feel like OpenClaw made dramatically better for studio-goers — not a foreign fitness app attached to it.
