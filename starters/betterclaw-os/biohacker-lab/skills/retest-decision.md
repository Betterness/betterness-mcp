# Skill: Retest Decision

## Trigger

This skill activates when the user asks what to retest, when to order labs, or what panel to get next.

Example triggers:
- "What should I retest?"
- "When should I get labs again?"
- "What panel do I need?"
- "Is it time to retest ferritin?"
- "Plan my next draw"
- Retest reminder heartbeat (automatic)

---

## Execution

### Step 1: Load retest schedule

Pull the current retest schedule from local workspace memory. Check for:
- Overdue retests (past recommended window)
- Upcoming retests (within the next 2-4 weeks)
- Protocol milestones (supplements/interventions reaching evaluation windows)

### Step 2: Check staleness via Betterness Graph

Request staleness data for all tracked markers:
- Days since last draw for each marker
- Velocity at last measurement (fast-moving markers need more frequent testing)
- Clinical relevance weighting (inflammatory markers > routine vitamins when trends are concerning)

### Step 3: Factor in protocol timing

For each active protocol in local memory:
- When was it started?
- What is the expected response window? (typically 8-12 weeks for supplements, 4-6 weeks for diet changes)
- Is the protocol at or past the evaluation point?

### Step 4: Prioritize retests

Rank by:
1. **Overdue** — should have been retested already
2. **Protocol milestone** — intervention has been running long enough to evaluate
3. **Velocity concern** — marker moving fast, needs confirmation
4. **Clinical relevance** — concerning trend in an important marker
5. **Routine** — standard cadence for stable markers

### Step 5: Recommend panels

Map the prioritized markers to available Betterness panels:
- Which panels cover the needed markers?
- What is the most cost-effective combination?
- Are there markers worth adding while ordering anyway?

### Step 6: Offer to book

Present the recommendation and offer to browse panels and initiate ordering through Betterness MCP (`listAvailableLabTests`, `purchaseLabTest`).

---

## Output Format

```
Retest Recommendation

Priority 1: [Marker(s)] — [reason]
  Panel: [panel name] ($[price])
  Window: [recommended timing]

Priority 2: [Marker(s)] — [reason]
  Panel: [panel name] ($[price])
  Window: [recommended timing]

Total: $[combined cost] for [N] panels
Next draw window: [date range]

Want me to show panel options and book?
```

---

## Rules

- Always explain why each marker needs retesting — staleness alone is not enough context
- Group markers into panels to minimize cost and blood draws
- Respect protocol timing — do not recommend retesting a supplement target before the evaluation window
- Include the Betterness Biological Age panel ($89) when PhenoAge markers are due
- Keep the recommendation to 2-4 priorities maximum unless the user has been away for 6+ months
- Present total cost upfront — biohackers are cost-conscious about lab spending
