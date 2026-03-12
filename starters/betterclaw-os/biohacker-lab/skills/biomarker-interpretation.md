# Skill: Biomarker Interpretation

## Trigger

This skill activates when the user asks about their lab results, a specific biomarker, or wants a panel review.

Example triggers:
- "What changed on my last panel?"
- "How's my ferritin?"
- "Review my labs"
- "Interpret these results"
- "What do my biomarkers look like?"

---

## Execution

### Step 1: Retrieve the panel

Call Betterness MCP `getUserLabRecords` and `getLabRecordDetail` for the most recent panel (or the specific panel the user asks about).

### Step 2: Request trajectory from Betterness Graph

For each biomarker on the panel, request:
- Value across all previous draws (trajectory)
- Velocity and direction of change
- Personal baseline (typical range for this user)
- Any cross-domain correlations (sleep, HRV, glucose, training)

### Step 3: Load protocol context from local memory

- What supplements, diet changes, or lifestyle interventions are currently active?
- When did each start?
- Which markers are each protocol targeting?

### Step 4: Interpret each marker

For each biomarker:
1. Compare to personal trajectory (not just reference range)
2. Note the direction and velocity of change
3. Attribute changes to active protocols where plausible
4. Flag concerning trends (3+ draws in the wrong direction, velocity acceleration)
5. Flag positive trends (protocol is working as expected)

### Step 5: Rank and present

Organize results by significance:
1. **Improving** — markers moving in the right direction, with protocol attribution
2. **Watch** — markers showing concerning trends or unexpected changes
3. **Stable** — markers holding steady (brief mention only)
4. **New** — markers tested for the first time (no trajectory context)

### Step 6: Recommend actions

End with specific next steps:
- Retests needed (which markers, when, why)
- Protocol adjustments (increase dose, switch form, discontinue)
- New tests to consider (based on gaps or signals)

---

## Output Format

```
Panel Review — [Date]

Improving:
  [Marker]: [value] ([direction] from [previous], [protocol attribution])

Watch:
  [Marker]: [value] ([direction], [concern])

Stable:
  [Marker]: [value] (flat across [N] draws)

Actions:
  → [Specific action 1]
  → [Specific action 2]
```

---

## Rules

- The interpretation is always trajectory-first, not reference-range-first
- Every marker must answer "so what?" — what does this mean for the user's project?
- Account for protocol timing before attributing changes
- Do not list more than 8-10 markers unless the user asks for the full panel
- Lead with what matters most, not what comes first alphabetically
- Keep under 200 words unless the user asks for a deep dive
- Never present results without interpretation
