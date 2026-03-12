# Skill: Sleep Analysis

## Trigger

This skill activates when the user asks about last night's sleep, sleep quality, sleep patterns, or anything related to sleep architecture.

Example triggers:
- "How did I sleep?"
- "How was my sleep last night?"
- "Tell me about my sleep"
- "Why didn't I sleep well?"
- "What happened with my deep sleep?"

---

## Execution

### Step 1: Retrieve overnight sleep data

Call Betterness MCP `getWearableData` for the most recent sleep session:
- Total sleep duration
- Deep sleep duration
- REM sleep duration
- Light sleep duration
- Awakenings count
- Sleep latency (time to fall asleep)
- Time in bed vs actual sleep (sleep efficiency)

### Step 2: Retrieve personal baselines

Request from Betterness Graph:
- 30-day average for each sleep stage
- Personal deep sleep baseline
- Personal REM baseline
- Typical sleep efficiency

### Step 3: Compare and interpret

For each metric, determine:
- Is it above, at, or below this user's personal baseline?
- Is the deviation meaningful (>15% from baseline) or within normal range?
- What is the most significant finding?

### Step 4: Deliver the summary

Format:

```
Sleep Summary — [date]

[One sentence: overall quality vs baseline]

Deep sleep: [duration] ([above/below/at] your [X min] baseline)
REM: [duration] ([above/below/at] your [X min] baseline)
Awakenings: [count]
Efficiency: [percentage]

[One sentence: what this means for today]
```

### Step 5: Offer to go deeper

If something notable emerged:
- "Your deep sleep has been below baseline for 3 nights. Want me to look at what might be causing it?"
- "Your REM was unusually high — often a sign of recovery catch-up. Want to see the trend?"

---

## Rules

- Always compare to personal baselines, never population averages
- Lead with the most meaningful finding, not a list of all metrics
- Include an action implication ("good day for intensity" or "protect sleep tonight")
- Do not present raw data without interpretation
- Keep the summary under 100 words unless the user asks for more detail
