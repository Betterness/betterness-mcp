# Skill: Post-Class Recovery & Nutrition Plan

## Trigger

User finishes a class or asks about post-workout recovery or nutrition. Examples:

- "Just finished class"
- "What should I eat after today's session?"
- "Post-workout plan?"
- "Done with my 7am Floor & Tread"
- Heartbeat fires 30 minutes after a scheduled class

## Input Requirements

Before responding, gather:

1. **Class details** — type (Floor & Tread, Lift, Double Floor, Run), time of day, estimated intensity
2. **Training context** — how many classes this week so far, next class scheduled
3. **Recovery state** — pre-class readiness level (if class-readiness skill was used), current recovery metrics
4. **Location** — current location for nearby food recommendations via OpenClaw Maps
5. **Dietary preferences** — from local memory (allergies, diet type, favorite spots, protein preferences)
6. **Time constraints** — morning class (rushing to work) vs evening class (more flexibility)

## Response Structure

### 1. Session Acknowledgment (1 sentence)
Note the class type and where it fits in their week. Example: "Third class this week — solid Lift session. One more booked Friday."

### 2. Nutrition Window (2–3 sentences)
Specific post-workout nutrition guidance based on class type and timing:

- **Floor & Tread / Run** — higher glycogen demand. Prioritize carbs + protein within 60 minutes. Target: 30–40g protein, 40–60g carbs.
- **Lift** — muscle protein synthesis priority. Protein within 90 minutes. Target: 30–40g protein, moderate carbs.
- **Double Floor** — highest recovery demand. Full meal within 60 minutes. Target: 40g protein, 50–70g carbs.
- **Morning class** — if rushing, suggest a quick option (shake, bar + banana). If time allows, suggest a sit-down spot.
- **Evening class** — full dinner recommendation from nearby options.

### 3. Nearby Food (1–3 options)
Query OpenClaw Maps for restaurants/cafes near the studio that match:
- Protein-forward menu options
- User's dietary preferences from memory
- Walking distance (< 10 min)
- Quick service if morning, sit-down if evening

Format each option as: **Name** — what to order — walk time.

### 4. Recovery Actions (2–3 bullets)
Based on this week's load and tomorrow's schedule:
- Hydration target (specific oz/mL based on class intensity)
- Sleep priority if tomorrow is another class day
- Mobility or stretching focus if specific muscle groups were hit
- Cold/heat therapy suggestion only if they have access (from memory)

### 5. Week Context (1 sentence)
Where they stand for the week: "That's 3 of your 4 planned classes done. Rest day tomorrow, then Friday Lift to close the week."

## What This Skill Never Does

- Recommend specific supplements without checking their current stack
- Give generic "eat protein and hydrate" advice — always include specific amounts and nearby options
- Ignore the time-of-day context (a 6am post-workout plan is very different from a 7pm one)
- Overload with information — this is a post-workout moment, keep it actionable and quick
- Forget dietary preferences the user has already shared
