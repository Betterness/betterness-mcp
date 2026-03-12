# Road Cycling Operator — Workspace

## Home View

The Road Cycling Operator workspace opens to a single "today" view anchored by ride readiness and power. Not a dashboard. Not a training log. One cohesive surface that answers the daily question: **What ride should I do today, at what watts, and is my body ready for it?**

### The Ride Readiness Card

The first thing the rider sees is a ride readiness card:

```
┌─────────────────────────────────────────┐
│  🟢  Ride Ready — Threshold Day         │
│                                         │
│  FTP: 271W  ·  W/kg: 3.87              │
│  Today: 2x20 min @ 265-275W (Z4)       │
│  Route: Mandeville Canyon out-and-back  │
│  Weather: 72F, NW 8mph                  │
│  Fuel: 60g carbs/hr, 1 gel at 40 min   │
│                                         │
│  → Kit up. Headwind going out.          │
└─────────────────────────────────────────┘
```

Readiness states:
- **Green** — recovery strong, target watts available, planned session is a go
- **Amber** — recovery moderate, swap to endurance or reduce interval targets by 5-10W
- **Red** — recovery low, recovery spin only or full rest day

The ride readiness card always shows: readiness verdict, FTP reference, today's ride with target watts and zones, route, weather, and fueling.

### Below the Ride Readiness Card

After the readiness card, the workspace shows contextual modules based on what is relevant today:

1. **Watts & Zone Tracker** (always shown) — FTP trend, current zones, recent ride NP vs targets
2. **Weekly Load Distribution** (always shown) — TSS by day, endurance/tempo/threshold/VO2/rest distribution vs plan
3. **Route Builder** (shown when ride has a route component) — map with elevation, wind, and segment targets
4. **Fueling Calculator** (shown pre-ride for sessions > 90 min) — carbs, hydration, timing based on duration, intensity, and temperature
5. **Recovery Gate** (shown on threshold/VO2 days) — should the hard session proceed, be modified, or become Z2?
6. **Equipment Tracker** (shown when service is due or approaching) — chain distance, tire wear, next service
7. **Ride Planner** (shown when planning future rides) — multi-day or week-level structure view

### What Is NOT on the Home View

- A wall of ride files and split tables from every ride this month
- A grid of 10 metric tiles with no interpretation (TSS, NP, IF, VI, EF, CTL, ATL, TSB, PMC...)
- A Strava-style social feed or segment leaderboard
- A multi-agent routing visualization
- A settings page or device configuration as the first experience
- Heart rate as the primary training signal (power is primary)

---

## Workspace Composition Rules

### Always visible
- Ride readiness card (verdict, FTP, today's ride, watts, route, weather, fueling)
- Watts & zone tracker (FTP trend, zone distribution)
- Weekly load distribution (TSS balance across the week)

### Conditionally visible
- Route builder — when today's ride or a planned ride involves a specific route
- Fueling calculator — for rides over 90 minutes or in hot conditions
- Recovery gate — on days with threshold, VO2max, or race-effort sessions
- Equipment tracker — when any component is within 10% of its service interval
- Ride planner — when planning a multi-day structure, event buildup, or training block
- Biomarker overlay — when lab data is connected (ferritin for iron, cortisol for overtraining)
- W/kg trend — when body composition data is available

### Never auto-shown
- Raw .fit file data or power curve charts without interpretation
- Historical ride log archives
- Device configuration UI
- Multi-agent routing visualization
- Comparison to other riders or Strava segments

---

## Interaction Model

The rider interacts with Road Cycling Operator primarily through natural conversation, not through clicking dashboard widgets.

### Common interactions

- **Morning check-in:** "What's my ride today?" → ride readiness card with watts, route, weather, fueling
- **Pre-ride decision:** "Should I do the intervals?" → recovery gate with reasoning and alternative
- **Route planning:** "Plan a 3-hour endurance ride from home" → route with elevation, weather, zone target, fueling
- **Power question:** "How's my FTP trending?" → power trend with context and next test recommendation
- **Fueling question:** "What should I eat on the 4-hour ride?" → carbohydrate plan scaled to duration, intensity, and temperature
- **Weekly planning:** "What does this week look like?" → daily structure with TSS targets and rationale
- **Equipment check:** "How's my chain?" → distance since last replacement, estimated remaining life
- **Post-ride debrief:** "How was that ride?" → NP vs target, zone distribution, fueling execution

### Conversation principles

1. Answer the question first, then offer to go deeper
2. Always include watts and zones — never prescribe intensity without numbers
3. Include weather and route context when relevant
4. Reference FTP as a living number — mention when zones may need updating
5. Keep responses concise — expand only when asked
6. When in doubt about a hard session, recommend endurance or recovery spin
