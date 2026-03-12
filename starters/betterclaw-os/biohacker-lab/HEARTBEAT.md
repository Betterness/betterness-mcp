# Biohacker Lab — Heartbeat

## Overview

The heartbeat is Biohacker Lab's proactive intelligence loop. It runs on schedule without the user asking, delivering biomarker context at the moments that matter most.

Biomarker intelligence is not just about panel day. The morning context, weekly reviews, and retest reminders keep the user's optimization project moving between draws.

---

## Morning Heartbeat

**Trigger:** Daily, at the user's preferred morning time

**Purpose:** Provide daily context that connects wearable signals to the biomarker picture.

### What it does

1. Pull overnight recovery data from Betterness MCP (sleep, HRV, resting HR)
2. Check if any wearable signal is relevant to active protocols (e.g., sleep quality during a magnesium protocol)
3. Check for upcoming or overdue retests
4. Deliver a brief daily context note

### Morning output format

```
Morning context:

Sleep 7h 22m, HRV 54ms (baseline 52). Recovery solid.
Your magnesium glycinate protocol is at day 47 — next magnesium RBC retest in ~6 weeks.
No retests overdue.
```

### Morning output — retest due

```
Morning context:

Sleep 6h 48m, HRV 46ms (below baseline). Not a great night.
Reminder: your ferritin + iron panel retest is 2 weeks overdue.
Want me to find available panels and book?
```

---

## Weekly Heartbeat

**Trigger:** Sunday evening or Monday morning (user configurable)

**Purpose:** Summarize the biomarker and protocol picture for the week.

### What it does

1. Request current biomarker status from Betterness Graph
2. Check protocol durations against expected timelines
3. Identify any wearable trends that may relate to active protocols
4. Surface the most important biomarker insight of the week

### Weekly output format

```
Week in Biomarkers

Bio age: 32.4 years (stable since last draw Feb 14)
Active protocols: 4 (magnesium glycinate day 47, vitamin D day 112, omega-3 day 203, NAC day 28)

This week's signal: HRV has been trending up since you started NAC 4 weeks ago.
Too early to attribute — but worth watching on your next panel (hsCRP, glutathione).

Retests due: ferritin + iron panel (overdue by 14 days)
Next draw window: March 20-25 (aligns with NAC 8-week check)
```

---

## Retest Reminder Heartbeat

**Trigger:** When a retest becomes due or overdue (based on retest schedule)

**Purpose:** Ensure retests happen on time so protocol decisions are data-informed.

### What it does

1. Check the retest schedule from local memory
2. Identify markers that are due or overdue
3. Explain why the retest matters (protocol timing, velocity tracking, clinical relevance)
4. Offer to browse panels and book

### Retest output format

```
Retest due: Ferritin + Iron Panel

Your ferritin has declined across 3 draws (94 → 78 → 54 ng/mL).
This retest confirms whether the trend is continuing or stabilizing.
It also informs whether to add iron supplementation.

Betterness has panels starting at $29. Want me to show options?
```

---

## Heartbeat Configuration

### Timing
- Morning: user-configurable, default 7:30 AM
- Weekly: Sunday evening (default) or Monday morning
- Retest reminders: triggered by schedule, not fixed time

### Channels
- In-workspace (default)
- Telegram
- Notification push (if supported by OpenClaw environment)

### Sensitivity
- **Normal:** morning context daily, weekly summary, retest reminders when due
- **Minimal:** weekly summary only, retest reminders only when overdue
- **Verbose:** daily context with protocol status, wearable correlations, and upcoming milestones

Default: Normal.

---

## What the Heartbeat Never Does

- Send a wall of biomarker values without interpretation
- Alarm the user about normal fluctuations in wearable data
- Nag about retests more than once per week (unless overdue)
- Recommend medical interventions or diagnoses
- Report when nothing meaningful has changed (unless set to verbose)
