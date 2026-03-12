# Marathon Operator — Workspace

## Home View

The Marathon Operator workspace opens to a single "today" view anchored by the training phase. Not a dashboard. Not a run log. One cohesive surface that answers the daily question: **Where am I in my training, and what should I do today?**

### The Training Phase Card

The first thing the user sees is a training phase card:

```
+-------------------------------------------+
|  Build Phase -- Week 6 of 12              |
|                                           |
|  Long run Saturday: 18 mi @ 8:45/mi      |
|  Weekly volume: 42 of 48 mi target       |
|  Recovery: green -- ready for tomorrow's  |
|  tempo.                                   |
|                                           |
|  > Thursday tempo: 6 mi @ 7:50           |
|  > Fuel: extra 400 cal pre-long-run      |
+-------------------------------------------+
```

Phase states:
- **Base** — aerobic foundation, easy volume accumulation, building consistency
- **Build** — adding speed work and tempo runs, volume increasing toward peak
- **Peak** — highest volume weeks, race-specific workouts, managing fatigue
- **Taper** — controlled volume reduction, maintaining intensity briefly, sharpening
- **Race Week** — execution mode, logistics, fueling protocol, pacing strategy

The phase card always shows: current phase and week, the next key session, weekly volume progress, and recovery status as it relates to the upcoming workout.

### Below the Phase Card

After the training phase card, the workspace shows contextual modules based on what is relevant today:

1. **Recovery Gate** (shown on quality workout days) — should you push, modify, or rest based on recovery and training load?
2. **Training Load** (always shown) — weekly mileage vs target, intensity distribution, fatigue trend
3. **Long Run Planner** (shown 2 days before long run day) — distance, pace, fueling plan, route
4. **Fueling Calculator** (shown pre-long-run and race week) — calorie and hydration targets for upcoming efforts
5. **Taper Intelligence** (shown during taper phase) — expected volume, what is normal to feel, what not to do
6. **Race Week Protocol** (shown during race week) — daily countdown guidance
7. **Route Planner** (shown when route is relevant) — maps, elevation, distance confirmation

### What Is NOT on the Home View

- A wall of split times from every run this month
- A grid of 8+ metric tiles with no interpretation
- A Strava-style social feed
- A multi-agent routing visualization
- A settings page or device configuration screen as the first experience
- A generic "how's your recovery" card disconnected from training context

---

## Workspace Composition Rules

### Always visible
- Training phase card (phase, week, next key session, recovery status)
- Training load summary (volume vs target, intensity balance)

### Conditionally visible
- Recovery gate — on days with quality sessions (tempo, intervals, long run)
- Long run planner — 48 hours before scheduled long run day
- Fueling calculator — pre-long-run days and all of race week
- Taper intelligence — during taper phase (typically final 2-3 weeks)
- Race week protocol — during the 7 days before race day
- Route planner — when the user has an upcoming run with a new or specific route
- Biomarker overlay — when lab data is connected and relevant (e.g., ferritin for iron)

### Never auto-shown
- Raw GPS data or split tables
- Historical training log archives
- Device configuration UI
- Multi-agent routing visualization
- Comparison to other runners

---

## Interaction Model

The user interacts with Marathon Operator primarily through natural conversation, not through clicking dashboard widgets.

### Common interactions

- **Morning check-in:** "What's my training today?" — phase-aware session plan with recovery context
- **Pre-workout decision:** "Should I do the tempo?" — recovery gate with reasoning
- **Long run prep:** "Tell me about Saturday's long run" — distance, pace, fueling, route
- **Fueling question:** "What should I eat before my long run?" — calorie and timing plan
- **Taper concern:** "Am I losing fitness?" — taper intelligence with reassurance and data
- **Race week:** "Walk me through race week" — 7-day protocol with daily actions
- **Route planning:** "Plan a 16-mile route from my house" — route with elevation and hydration points
- **Trend question:** "How's my training going?" — phase progress, volume trends, readiness trajectory

### Conversation principles

1. Answer the question first, then offer to go deeper
2. Always frame the answer within the current training phase
3. Include an action — what to do, not just what happened
4. Reference personal paces and baselines, not generic training advice
5. Keep responses concise — expand only when asked
6. When in doubt about a hard session, recommend the conservative option

---

## OpenClaw-Native Integration

Marathon Operator uses OpenClaw workspace primitives:

- **Workspace files** — AGENTS.md, SOUL.md, etc. define behavior
- **Skills** — training-status and race-prep as workspace skills
- **Heartbeat** — morning training brief and post-run check-in
- **Cron** — weekly training summary and phase progression check
- **Channels** — training context persists across conversation sessions
- **Memory** — daily logs in `memory/YYYY-MM-DD.md`, race details in `memory/race.md`

The workspace should feel like OpenClaw made dramatically better for marathon training — not a foreign framework attached to it.
