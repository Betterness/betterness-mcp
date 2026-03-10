# SkillGraph Combination Rules

Skills combine when the graph finds meaningful overlap across shared inputs, goals, or explicit complement links. A combination produces a merged skill context: two (or more) skills running together with shared data access, coordinated actions, and a unified output surface.

This document defines what triggers combination, how combinations are structured, what archetypes exist, and how the system evolves across implementation phases.

---

## 1. Combination Engine Inputs

The combination engine reads seven input signals when deciding whether to activate a combined skill context.

### 1.1 Connected Devices

The user's connected wearables and sensors are the strongest combination trigger. When a device appears in the `device_affinities` of two or more skills, those skills are candidates for combination.

- Whoop connected → all skills with `"whoop"` in `device_affinities` are in the candidate pool
- Oura + CGM connected → sleep skills + metabolic skills become candidates
- Garmin + Apple Watch → redundant device handling (prefer higher-resolution source per metric)

### 1.2 Activity Types

The user's logged or declared activity type pulls skills from `activity_affinities`. When an activity appears across multiple skills, those skills combine.

- Cycling session logged → `cycling-hr-zone-optimizer` + `glucose-fueling-guide` + `whoop-recovery-operator` if all have `"cycling"` in `activity_affinities`
- Running → pace-zone skills + fueling skills + recovery skills

### 1.3 Missing Integrations

Absent data sources shape the combination by triggering connection upsells. When two complementary skills both list the same source in `connection_upsell`, the combined output includes a single unified upsell rather than two separate ones.

- Both a sleep skill and a recovery skill want Eight Sleep connected → one prompt surfaces, not two

### 1.4 Biomarker Availability

When a user has lab results in their profile, skills with matching `biomarker_affinities` activate at higher depth. Cross-biomarker skills combine when the available labs span multiple skill domains.

- ApoB + fasting insulin + HbA1c available → cardiovascular risk skill + metabolic risk skill combine into a coordinated lipid-metabolic panel interpretation

### 1.5 Goals

User goal profile (fat-loss, performance, longevity, etc.) drives which skills are surfaced and which combinations are prioritized. Goals are declared at onboarding and updated from usage signals.

- Goal = performance + longevity → training optimization skills combine with healthspan protocols
- Goal = fat-loss → CGM skill + nutrition skill + exercise skill form a standard triad

### 1.6 ICP Label (Coach Layer)

When a Betterness One coach is serving a client, the client's ICP label from the contact layer gates which combinations are relevant.

- ICP = `competitive-athlete` → performance + recovery combinations prioritized over longevity + daily-health
- ICP = `perimenopausal-woman` → women's health + sleep + metabolic combinations prioritized

### 1.7 Recent Skill Usage

The engine tracks which skills a user has recently activated. Frequently co-activated skills are promoted as a persistent combination. Rarely co-activated skills with explicit `complements` links are surfaced as discovery suggestions.

---

## 2. Combination Archetypes

Combinations cluster into four archetypes. Each archetype has a standard data flow, output format, and action routing pattern.

### 2.1 Device + Activity

**Trigger:** User has a wearable connected AND logs a specific activity type.

**Pattern:** The device skill reads sensor data; the activity skill interprets it in training context.

**Examples:**

- `whoop` + `cycling` → `whoop-recovery-operator` + `cycling-hr-zone-optimizer`
  - Whoop HRV and recovery score inform zone prescription for the day's ride
  - Combined output: "Your HRV is 12% below your 30-day baseline. Today's ride should stay in Zone 2. Here's your adjusted zone table."
  - Actions enabled: `adjust-training-plan`, `log-session`, `send-morning-brief`

- `oura` + `running` → `oura-readiness-reader` + `running-pace-zone-guide`
  - Oura readiness score gates effort level recommendation
  - Combined output: "Readiness 74. Easy effort today. Target pace: [calculated range]."

- `garmin` + `strength` → `garmin-load-tracker` + `strength-periodization-guide`
  - Weekly training load informs volume recommendations
  - Combined output: "Your acute:chronic load ratio is 1.4. Reduce volume by 20% this week."

### 2.2 Device + Biomarkers

**Trigger:** User has a wearable connected AND has uploaded or ordered lab results.

**Pattern:** The device skill provides real-time signal; the biomarker skill provides baseline clinical context.

**Examples:**

- `whoop` + labs (cortisol, testosterone) → `whoop-hrv-trend-analyzer` + `hormonal-recovery-interpreter`
  - HRV trend is interpreted against hormonal baselines, not just training load
  - Combined output: "Your HRV drop aligns with the cortisol elevation from your last panel. Protocol: 48-hour recovery block + reassess."

- `cgm-dexcom` + labs (HbA1c, fasting insulin) → `glucose-pattern-analyzer` + `metabolic-risk-interpreter`
  - CGM readings are contextualized against lab-confirmed insulin sensitivity
  - Actions enabled: `schedule-follow-up-labs`, `adjust-nutrition-protocol`, `refer-to-specialist`

- `oura` + labs (ApoB, hsCRP) → `sleep-quality-analyzer` + `cardiovascular-risk-contexter`
  - Sleep disruption patterns are flagged in the context of elevated inflammatory markers
  - Combined output includes a physician-review action when both signals are concerning

### 2.3 Venue + Food + Activity

**Trigger:** User has a gym, studio, or fitness venue affinity AND logs nutrition or food data.

**Pattern:** The venue skill provides schedule and class context; the nutrition skill provides fueling guidance timed to the session.

**Examples:**

- Barry's class booked + MyFitnessPal connected → `barrys-class-prep-guide` + `pre-workout-fueling-guide`
  - Pre-session meal timing and composition based on class type (treadmill-heavy vs. floor-heavy)
  - Post-session recovery nutrition based on class output

- HYROX training block + CGM connected → `hyrox-training-planner` + `glucose-fueling-guide`
  - Race-simulation fueling protocol built from glucose response data
  - Actions enabled: `set-meal-reminder`, `log-fueling-session`, `adjust-race-day-plan`

- Equinox membership + nutrition goal (fat-loss) → `equinox-class-optimizer` + `caloric-deficit-guide`
  - Class selection guidance weighted by caloric burn and recovery cost
  - Weekly class schedule built around nutrition deficit targets

### 2.4 Household / Social

**Trigger:** User has household members or partners linked, or has social wellness goals.

**Pattern:** Skills from the Family & Household and Social, Events & Community categories combine with individual optimization skills to produce shared or coordinated outputs.

**Examples:**

- Partner linked + sleep data → `sleep-quality-analyzer` (user) + `household-sleep-alignment-guide`
  - Bedtime alignment recommendations for couples with different chronotypes
  - Actions enabled: `set-shared-bedtime-reminder`, `adjust-thermostat-schedule`

- Family meal planning + children's nutrition → `family-meal-planner` + `childrens-nutrition-guide`
  - Single grocery list that covers both adult performance goals and age-appropriate child nutrition
  - Actions enabled: `generate-grocery-list`, `schedule-meal-prep`

- Local event discovery + running goal → `community-run-finder` + `running-training-planner`
  - Upcoming local races surface as goal anchors for the training plan
  - Actions enabled: `add-race-to-calendar`, `build-race-prep-block`

---

## 3. Implementation Phases

### Phase 1 — Static Complements + Device Affinities

**What ships:**
- `complements` field in each skill drives a static "Often paired with" suggestion in the UI
- `device_affinities` field drives a simple rule: if device is connected, increase skill rank in recommendations
- No runtime merging — skills run independently, displayed side by side

**Combination behavior:**
- UI shows: "You might also want: [complement skill name]"
- Device-connected skills appear first in category browsing
- Connection upsells surface from `connection_upsell` field when device is absent

**Example:**
- User opens `whoop-recovery-operator` → UI shows "Often paired with: cycling-hr-zone-optimizer"
- User has Whoop connected → recovery skill ranks above non-device skills in daily-health category

### Phase 2 — Recommendation Logic

**What ships:**
- Combination engine reads connected devices, declared goals, and activity log
- When a valid combination archetype is detected, a combined skill context is offered in the UI
- Shared data access: both skills read from the same user data context (no duplication)
- Actions are deduplicated — if both skills would trigger the same action, it fires once
- Connection upsells are merged — both skills wanting the same data source produce one prompt

**Combination behavior:**
- BETT-i surfaces: "Based on your Whoop data and today's cycling session, I'm running Recovery + Zone Optimizer together."
- Output is a single unified response, not two separate skill outputs
- The `persona_compatible` field gates which persona overlays apply to the combined context

**Example:**
- Whoop connected + cycling logged → `whoop-recovery-operator` + `cycling-hr-zone-optimizer` auto-combined
- Output: one response with recovery score context and zone prescription
- Action: one `send-morning-brief` call with both dimensions included

### Phase 3 — Learn from Usage

**What ships:**
- Usage tracking: which skills are activated together by the same user across sessions
- Combination promotion: frequently co-activated pairs are persisted as a named combination for that user
- Combination discovery: rarely co-activated pairs with `complements` links are surfaced as suggestions in low-activity periods
- Cross-user signals: anonymized co-activation patterns inform global combination recommendations (opt-in)

**Combination behavior:**
- After 5+ co-activations: "It looks like you usually run Recovery + Zone Optimizer together. Want to make this your default morning check-in?"
- Named user combinations appear in Mission Control as pinned workflows
- Combination suggestions appear in the homescreen digest on rest days or low-activity periods

**Example:**
- User consistently activates `glucose-pattern-analyzer` + `nutrition-logging-guide` after CGM spikes
- System creates a named combination: "Spike Response Protocol"
- BETT-i proactively runs "Spike Response Protocol" on next CGM spike without being asked

---

## 4. Combination Output Format

A combined skill output always includes:

1. **Context line** — which skills are active and what data was used
2. **Unified insight** — one coherent response, not two separate answers
3. **Coordinated actions** — deduplicated, ordered by priority
4. **Connection upsell** (if applicable) — one prompt for any missing data sources
5. **Complement suggestion** (if applicable) — one adjacent skill not yet in the combination

**Format example:**

```
[Whoop Recovery + Cycling Zone Optimizer]
Data: HRV 58ms (↓12% vs. 30-day baseline), Resting HR 52bpm, Recovery Score 61%

Today's session: Zone 2 only. Your recovery score is below your threshold for quality hard work.

Zone targets (based on your LTHR 168bpm):
  Zone 1: <126bpm | Zone 2: 126–143bpm | Zone 3: 143–155bpm

Suggested duration: 60–75 min. No intervals today.

→ Log this session
→ Send to training calendar
→ Connect Eight Sleep to improve recovery scoring accuracy
```

---

## 5. Combination Constraints

- **Maximum 4 skills in a single combination.** Beyond 4, output quality degrades.
- **Persona overlays apply to the combination as a whole,** not per-skill. If skills have incompatible `persona_compatible` lists, the overlay with broadest compatibility wins.
- **Actions must be available to the user's connected MCP tools.** A combination cannot promise an action the user's tool set cannot fulfill.
- **Combinations do not override safety guardrails.** Any skill in the combination that flags a clinical concern surfaces that concern in the combined output, regardless of other skills' outputs.
