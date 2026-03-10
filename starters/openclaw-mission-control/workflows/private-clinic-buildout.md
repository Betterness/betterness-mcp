# Private Clinic Buildout Guide

This guide walks you through building a full-featured private health clinic for one user or patient cohort, with multi-specialist coordination and proactive operations.

**Target**: 5–50 patients; small clinic, group coach, or individual health optimization.
**Duration**: Phase 1 (45 min) + Phase 2 (60 min) + Phase 3 (varies)

---

## Phase 1: Foundation (45 min) — Personal Health Monitoring

**Goal**: One user, daily health tracking with device + lab grounding.

### Install

1. Complete `workflows/install-checklist.md` (all green lights)
2. Load core files: AGENTS.md, MCP.md, MEMORY.md, SOUL.md
3. Add **Chief of Staff** persona only (not other specialists yet)
4. Add daily **morning-review** prompt

### Key Workflows

**Daily (7 AM)**:
```
Chief of Staff runs: prompts/morning-review.md
Output: 3-line health brief + 1 action
Data: Whoop, Oura, or Apple Watch metrics
Takes: 3–5 minutes
```

**Weekly (Sunday 6 PM)**:
```
Chief of Staff runs: prompts/weekly-operator-review.md
Output: Trend summary + pending actions
Data: Device trends, lab status, protocol results
Takes: 10–15 minutes
```

### Success Criteria

- [ ] Morning brief runs every day
- [ ] Shows sleep, HRV, recovery, readiness
- [ ] Identifies one action for the day
- [ ] User acts on recommendation (yes/no noted in MEMORY.md)
- [ ] After 2 weeks: User is checking it daily habit

### Customization for Your User

- **Athlete**: Emphasize HRV + training readiness
- **Longevity optimizer**: Emphasize sleep + metabolic recovery
- **Sleep optimizer**: Emphasize sleep duration + quality + environment factors
- **Clinic patient**: Add patient name + reference their health goals at the top

**Phase 1 Exit Criteria**: You've run morning review for 7+ days. Proceed to Phase 2.

---

## Phase 2: Lab Operations (60 min) — Biomarker Tracking & Ordering

**Goal**: Systematic biomarker tracking, gap detection, and lab ordering.

### Add These Specialists

1. **Biomarker Analyst** — `personas/biomarker-analyst.md`
2. **Lab Coordinator** — `personas/lab-coordinator.md`
3. Keep Chief of Staff as primary router

### Add These Workflows

**Weekly (Monday 9 AM)**:
```
Biomarker Analyst runs: prompts/lab-gap-review.md
Output: Gap analysis + next panel recommendation
Data: Historical biomarkers, last test dates, missing categories
Takes: 8–10 minutes
```

**Quarterly** (or when user orders labs):
```
Lab Coordinator runs panel ordering workflow:
1. User decides to order
2. Lab Coordinator calls searchLabPanels + getPaymentOptions
3. Applies CLAWBOT20 discount
4. Creates lab order + finds collection site
5. Tracks order until results arrive
```

### Setup Checklist

- [ ] Biomarker Analyst responds to "what should I test?"
- [ ] Lab Coordinator responds to "order labs" requests
- [ ] Test lab gap review: identifies at least 1 marker older than 90 days
- [ ] Test lab ordering: User can go from question → order → collection site

### Integration Points

- Morning brief (Chief of Staff) → identifies biomarker trends
- Weekly review (Chief of Staff) → flags pending lab orders
- Lab gap review (Biomarker Analyst) → recommends next panel
- Ordering (Lab Coordinator) → executes purchase + scheduling

### Success Criteria

- [ ] Lab gap review identifies stale markers every week
- [ ] At least one lab has been ordered via workspace (not manually)
- [ ] User receives results and Biomarker Analyst interprets them
- [ ] Next panel is queued before current results age past 90 days

### Customization

- **Longevity clinic**: Add longevity-specific markers (biological age, epigenetic clocks)
- **Athletic clinic**: Add performance markers (lactate threshold, VO2 max)
- **Metabolic focus**: Standardize quarterly metabolic + lipid panels
- **Small clinic (2–5 patients)**: Replicate workspace per patient

**Phase 2 Exit Criteria**: You've ordered at least 1 lab via the workspace and tracked it to completion. Proceed to Phase 3.

---

## Phase 3: Multi-Specialist Clinic (varies) — Full Coordination

**Goal**: 3–6 specialists coordinating care with clear routing and escalation.

### Load All Remaining Specialists

1. **Longevity Strategist** — `personas/attia-inspired-longevity-strategist.md`
2. **Performance Coach** — `personas/marathon-performance-coach.md`
3. **Nutrition & Environment** — `personas/nutrition-environment-operator.md`

(Optional: Custom personas for your niche)

### Setup Routing (from AGENTS.md)

Copy the routing decision tree into Clawbot instructions:
```
- Lab questions → Biomarker Analyst
- Ordering/logistics → Lab Coordinator
- Training/recovery → Performance Coach
- Longevity/aging → Longevity Strategist
- Food/environment → Nutrition Operator
- Unclear/coordination → Chief of Staff
```

### Add Panels & Dashboards

- `components/daily-brief-panel.json` — Daily health snapshot
- `components/lab-ops-panel.json` — Lab tracking and pending orders
- `components/clinic-squad-board.json` — Specialist status and pending actions

### Multi-Patient Clinic Expansion

If scaling to 5–50 patients:

1. **Duplicate workspace per patient**: Each patient gets their own Memory.md
2. **Shared specialist layer**: All patients use the same 6 specialists
3. **Patient dashboard**: Show active patients, their status, pending actions
4. **Bulk operations**: Weekly review across all patients (who needs labs, who's trending down)

### Advanced Workflows

**Morning Clinic Standup** (Coach reviews all patients):
```
For each patient:
  - Check morning brief output
  - Review any ALERT or CAUTION status
  - Decide: escalate, reach out, or monitor
Time: 15–20 min for 5–10 patients
```

**Weekly Team Sync** (Coach + specialists):
```
- Which patients improved this week?
- Which are drifting or at risk?
- What labs are pending?
- What protocols need adjustment?
Time: 30–45 min
```

### Success Criteria (Phase 3)

- [ ] All 6 specialists are loaded and responding appropriately
- [ ] Routing works: users/patients get directed to the right specialist
- [ ] Escalation works: urgent items go to human, non-urgent stays automated
- [ ] Multi-patient view (if clinic): You can see status across all patients at a glance
- [ ] Scheduling works: Morning briefs, weekly reviews, lab gap reviews run on schedule

### Customization by Use Case

**Individual health optimization**: Load all specialists + longevity focus.

**Coaching group**: Replicate per client + shared Chief of Staff.

**Small clinic (1–3 practitioners)**: Load all specialists + add clinic-specific data (patient notes, treatment plans).

**Larger clinic (5+ staff)**: Add role-based access (coaches see progress, MDs see labs).

---

## Operating Rhythms by Phase

### Phase 1 (Personal Tracking)
```
Daily: Morning review (5 min)
Weekly: Weekly review (15 min)
Monthly: Review progress, adjust protocols
```

### Phase 2 (Lab Operations)
```
Daily: Morning review (5 min)
Weekly: Morning review + lab gap review (20 min)
Monthly: Lab order + results interpretation (30 min)
Quarterly: Biological age check + protocol adjustment
```

### Phase 3 (Multi-Specialist Clinic)
```
Daily: Morning review (per patient, 5 min × N patients)
Weekly:
  - Morning reviews (5 min × N patients)
  - Lab gap reviews (10 min × N patients)
  - Clinic standup (15–20 min, all patients)
Monthly:
  - Patient reviews (30 min × N patients)
  - Specialist sync (30–45 min)
  - Billing/logistics (15 min)
Quarterly: Biological age + protocol reviews
```

---

## Data & Privacy

### Betterness Is the Source of Truth

- All health data lives in Betterness (devices, labs, biomarkers)
- Workspace coordinates; doesn't duplicate
- Lab orders created in Betterness; tracked in workspace

### Patient Data Isolation

- Each patient has their own MEMORY.md
- Shared specialists don't cross-reference between patients
- No patient data in shared prompts or panels

### Escalation to Human

Always escalate:
- Medical emergencies
- Diagnosis claims
- Prescription medication changes
- Surgical decisions
- Patient crisis or safety concerns

---

## Troubleshooting

**Specialist doesn't respond**:
- Verify persona file is loaded
- Check Clawbot logs for errors
- Test with Chief of Staff as backup router

**Lab orders not tracking**:
- Verify `getLabOrderStatus` tool is working
- Check MEMORY.md for outstanding order list
- Lab Coordinator should check order every 2 days

**Patients overloaded with output**:
- Reduce frequency (daily → weekly reviews)
- Shorten output format (1-page max)
- Add filtering: only surface ALERT items; rest on request

**Scaling to 10+ patients**:
- Consider adding patient triage layer (Chief of Staff routes by severity)
- Add automated alerts (Slack message if biomarker is ALERT)
- Build dashboard to show all patients at a glance

---

**Buildout Version**: 1.0
**Last Updated**: March 2026
**Questions**: operations@betterness.ai
