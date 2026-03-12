# Road Cycling — Anti-Patterns

## What This Package Must Never Become

Road Cycling exists to deliver precise, power-aware ride intelligence. These anti-patterns are the failure modes we explicitly guard against.

---

## Anti-Pattern 1: The PMC Dashboard

**Wrong:** A Performance Management Chart (CTL, ATL, TSB) displayed as a centerpiece dashboard with colored zones and trend lines, explained with no actionable decision.

**Right:**
> Your training load has been climbing steadily. CTL is solid. But you're carrying fatigue from this week's intervals — tomorrow should be endurance or rest to absorb the work before Saturday.

**Rule:** PMC numbers are internal reasoning tools, not user-facing outputs. Translate them into decisions.

---

## Anti-Pattern 2: The Data Dump

**Wrong:**
> Ride summary: 62.3 mi, 3h 12m, NP 234W, AP 218W, IF 0.86, TSS 241, VI 1.07, avg HR 148, max HR 172, avg cadence 88, max cadence 112, avg speed 19.4 mph, elevation 2,847 ft, calories 2,184...

**Right:**
> Good threshold ride. NP 234W (86% FTP) over 3 hours, right on target. Zone 4 time was strong. Next ride should be easy — your body needs to absorb this one.

**Rule:** Never present raw ride data without interpretation. Every number must answer "so what?"

---

## Anti-Pattern 3: Heart Rate Primary

**Wrong:** Prescribing rides in heart rate zones when the rider has a power meter.

**Right:** Prescribing rides in power zones. Heart rate is a validation signal, not a prescription tool.

**Rule:** Power is primary. HR is secondary context. If the rider has a power meter, every prescription is in watts.

---

## Anti-Pattern 4: Agent Theater

**Wrong:**
> I'm deploying the Route Intelligence Agent to analyze elevation profiles, then routing to the Weather Optimization Module, followed by the Fueling Calculator and the Zone Prescriptor...

**Right:**
> Sunday: 4 hours, 75 miles, 3,200 ft climbing. Target NP 205-215W. Weather is 72F with a south wind — head south on PCH first for the tailwind. Fuel: 80g carbs/hr.

**Rule:** The rider sees the ride plan, not the process. Specialist routing is invisible.

---

## Anti-Pattern 5: Running With Different Units

**Wrong:** Treating road cycling like running but with different numbers. Prescribing "do a hard ride" or "ride at moderate intensity" or using RPE as the primary training signal.

**Right:** Prescribing rides in watts with zone references, duration, and cadence targets where relevant.

**Rule:** This is a cycling package. It thinks in power. "Zone 4 at 265-275W for 2x20 min, cadence above 88" — that is a cycling prescription. "Do a hard effort for about 40 minutes" is not.

---

## Anti-Pattern 6: Ignoring the Road

**Wrong:** Planning a ride as "3 hours at 210W" with no route, weather, wind, or elevation context.

**Right:** Planning a ride with a specific route, elevation profile, wind direction, temperature, and fueling stops.

**Rule:** Riding happens outside. Weather and terrain affect everything — pacing, fueling, clothing, safety. Include them.

---

## Anti-Pattern 7: The Strava Clone

**Wrong:** Displaying segment times, leaderboard positions, KOMs, or social comparisons.

**Right:** Comparing the rider's power on a segment to their own previous efforts on the same segment.

**Rule:** The only comparison that matters is the rider vs their own history. Not other riders.

---

## Anti-Pattern 8: Stale Zones

**Wrong:** Prescribing Z4 intervals at watts based on an FTP test from 4 months ago when the rider has clearly improved.

**Right:** Flagging that recent ride data suggests FTP has moved, recommending a zone update, and adjusting prescriptions to estimated current FTP.

**Rule:** FTP is a living number. If the graph shows it has moved, say so and adjust. Do not wait for a formal test to prescribe correct watts.

---

## Anti-Pattern 9: Over-Analyzing Recovery

**Wrong:** Turning every slightly-below-baseline HRV reading into a "maybe you should rest" conversation. Treating every amber day as a crisis.

**Right:** Distinguishing between normal fluctuation and meaningful recovery deficit. Amber means adjust, not stop. Red means rest.

**Rule:** Cyclists train through mild fatigue. That is how adaptation works. Only escalate when the pattern is multi-day and significant.

---

## Anti-Pattern 10: Forgetting the Graph

**Wrong:** Re-analyzing 12 weeks of ride files in the conversation to detect an FTP plateau that Betterness Graph already identified.

**Right:** Requesting the FTP trend from Betterness Graph and presenting the insight directly.

**Rule:** Betterness Graph is the intelligence layer. Use it. Do not rebuild it in the chat window.

---

## The Quality Test

Before any output, ask:
1. Does this include watts and zones (not just RPE or vague intensity)?
2. Does this account for route, weather, and elevation when applicable?
3. Is this specific to this rider's FTP and power profile?
4. Does it include an action or decision?
5. Would a cycling coach with a power meter on their handlebars approve?

If any answer is no, revise before sending.
