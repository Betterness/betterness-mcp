# Skill: Workspace Install — Magic Moment

```
  INSTALL FLOW:
  ┌─────────────────────────────────────────────────────────────────┐
  │  claw workspace install betterness/road-cycling                 │
  └──────────┬──────────────────────────────────────────────────────┘
             │
  Phase 1    ▼  AUTH
  ┌─────────────────────────────┐
  │ Check @betterness/cli token │──→ found? use it
  │ Otherwise: paste prompt     │──→ validate with getUserProfile
  └──────────┬──────────────────┘
             │
  Phase 2    ▼  DATA PULL (parallel after profile validates)
  ┌─────────────────────────────────────────────────────┐
  │ getUserProfile ──→ then parallel:                   │
  │   getProfileStats | listConnectedDevices |          │
  │   getUserHealthData | getUserLabData |              │
  │   getBiologicalAge | flagOutOfRangeMarkers          │
  └──────────┬──────────────────────────────────────────┘
             │
  Phase 3    ▼  PERSONALIZE FILES
  ┌─────────────────────────────────────────────────────┐
  │ IDENTITY.md ← profile + goals                      │
  │ memory/devices.md ← connected devices               │
  │ memory/health-snapshot.md ← power + labs            │
  │ memory/preferences.md ← FTP, zones, W/kg           │
  │ HEARTBEAT.md ← schedule from wake patterns          │
  │ AGENTS.md ← activate relevant specialists           │
  │ .betterness/credentials ← token (chmod 600)         │
  │ .betterness/installed.json ← birth certificate      │
  └──────────┬──────────────────────────────────────────┘
             │
  Phase 4    ▼  HEALTH CARD (animated reveal)
  ┌─────────────────────────────────────────────────────┐
  │ Profile summary → Devices → Power profile →         │
  │ Ride readiness + HRV sparkline →                    │
  │ Conversation starters                               │
  └──────────┬──────────────────────────────────────────┘
             │
  Phase 5    ▼  SMOKE TESTS
  ┌─────────────────────────────────────────────────────┐
  │ listConnectedDevices ✓ | getUserLabData ✓ |         │
  │ searchBiomarkers ✓                                  │
  └──────────┬──────────────────────────────────────────┘
             │
             ▼  DONE ✨
```

---

## Phase 1: Authentication

### Step 1.1 — Check for existing token

Look for a Betterness API token in this order:
1. `~/.betterness/credentials` (global CLI config)
2. `.betterness/credentials` (workspace-local, from prior install)
3. Environment variable `BETTERNESS_TOKEN`

If found, validate by calling `getUserProfile`. If valid → skip to Phase 2.
If expired/invalid → fall through to paste prompt.

### Step 1.2 — Paste prompt (fallback)

```
🔑 Betterness API Token Required

Get your token at: betterness.ai/settings → API Keys → Generate

Paste token: ▌
```

Validate the pasted token:
- Must start with `bk_`
- Must be 40+ characters
- Validate against `getUserProfile`

On invalid token:
```
❌ That token didn't work. Check betterness.ai/settings for a valid key.
```

Max 3 attempts, then exit with:
```
❌ Could not authenticate. Visit betterness.ai/settings to generate a new token.
```

### Step 1.3 — Token storage

Write `.betterness/credentials` with `chmod 600`.

Display:
```
🔐 Token stored in .betterness/credentials (600 permissions)
   This file is gitignored. Your token never leaves this machine.
```

---

## Phase 2: Data Pull

### Step 2.1 — Sequential: getUserProfile

First call. This validates the token and retrieves:
- Name, email
- Profile preferences
- Account tier

If this fails, the token is invalid → return to Phase 1.

### Step 2.2 — Parallel: 6 calls

After profile validates, fire all 6 in parallel:

| Call | What it gets | Used for |
|------|-------------|----------|
| `getProfileStats` | Health summary, bio age, activity trends | Profile header |
| `listConnectedDevices` | Connected wearables, last sync timestamps | Device list, warnings |
| `getUserHealthData` | Sleep, HRV, activity, power, training load | Power profile, ride readiness |
| `getUserLabData` | Lab panels, biomarker results | Flagged markers (iron, ferritin, cortisol) |
| `getBiologicalAge` | Bio age score + trend direction | Profile header |
| `flagOutOfRangeMarkers` | Currently flagged biomarkers | Health card, conversation starters |

### Step 2.3 — Graceful degradation

```
  DEGRADATION LADDER:
  ┌──────────────────────────────────────────────┐
  │ Level 0: All calls succeed                   │
  │   → Full personalization, complete card       │
  ├──────────────────────────────────────────────┤
  │ Level 1: Some calls fail                     │
  │   → Partial card, skip missing sections      │
  │   → "⚠️ Some data unavailable"               │
  ├──────────────────────────────────────────────┤
  │ Level 2: Only profile succeeds               │
  │   → Name-only card, everything else generic  │
  │   → "Connect devices for full power profile" │
  ├──────────────────────────────────────────────┤
  │ Level 3: Profile also fails (token valid)    │
  │   → Clean template with no personalization   │
  │   → "Your workspace is ready. Data will sync │
  │      when Betterness servers are available."  │
  └──────────────────────────────────────────────┘
```

Never crash. Always install something.

---

## Phase 3: Personalize Files

### Step 3.1 — IDENTITY.md

Inject into the identity template:
- User name, location (if shared)
- FTP (if Garmin data available), target events, training goals
- Connected devices

### Step 3.2 — Memory files

**memory/devices.md:**
```markdown
# Connected Devices
Last updated: {timestamp}

| Device | Type | Last Sync | Status |
|--------|------|-----------|--------|
| Garmin Edge 840 | Power meter / GPS | 2h ago | ✅ Active |
| WHOOP 4.0 | Recovery | 4h ago | ✅ Active |
| Oura Ring Gen 3 | Sleep / HRV | 6h ago | ✅ Active |
```

**memory/health-snapshot.md:**
```markdown
# Health Snapshot
Last updated: {timestamp}

## Power Profile
- FTP: {value}W ({W/kg}W/kg)
- CTL (fitness): {value}
- ATL (fatigue): {value}
- TSB (form): {value}
- Weekly TSS: {value} (target: {value})

## Recovery
- HRV: {value}ms (7d avg: {avg}ms)
- Resting HR: {value}bpm
- Sleep: {hours}h (deep: {deep}h)
- Recovery score: {score}

## Biomarkers
- Flagged: {list or "none"}
- Last panel: {date}
- Key for cycling: ferritin {value}, iron {value}, cortisol {value}
```

**memory/preferences.md:**
```markdown
# Preferences
- FTP: {value}W (last tested: {date})
- Weight: {value}kg → W/kg: {ratio}
- Training zones: {auto-calculated from FTP}
- Preferred ride days: {inferred from activity patterns}
- Long ride day: {day}
- Rest day: {day}
- Wake time: {inferred}
- Target events: {from profile or "none set"}
```

### Step 3.3 — System files

**HEARTBEAT.md:** Insert wake time and preferred ride times from activity patterns.

**AGENTS.md:** Activate relevant specialists:
- Power analysis specialist (always)
- Route planner specialist (always)
- Nutrition specialist (if training load data available)
- Recovery specialist (if HRV/sleep data available)
- Equipment specialist (if device data includes bike sensors)

**.betterness/installed.json:**
```json
{
  "workspace": "betterness/road-cycling",
  "version": "1.0.0",
  "installed_at": "{ISO timestamp}",
  "token_prefix": "bk_****{last4}",
  "data_at_install": {
    "bio_age": null,
    "device_count": 3,
    "ftp": 265,
    "ctl": 72,
    "lab_result_count": 12,
    "flagged_marker_count": 1
  }
}
```

---

## Phase 4: Health Card — Animated Reveal

The card renders in terminal with timed beats. Each beat appears after a pause to create anticipation.

**Beat 1 — Profile header** (immediate)
```
┌─────────────────────────────────────────────────┐
│  🚴 ROAD CYCLING OPERATOR                       │
│                                                 │
│  {Name} · FTP {ftp}W ({w_kg} W/kg) · Bio Age {score} │
```

**Beat 2 — Devices** (200ms pause)
```
│                                                 │
│  DEVICES        LAST SYNC    STATUS              │
│  Garmin Edge    2h ago       ✅ Active           │
│  WHOOP 4.0      4h ago       ✅ Active           │
│  Oura Ring      6h ago       ✅ Active           │
```

**Beat 3 — Device warnings** (only if stale devices exist)
```
│                                                 │
│  ⚠️  Withings hasn't synced in 21 days.         │
│     Open the Betterness app to reconnect it.    │
```

**Beat 4 — Power profile** (300ms pause)
```
│                                                 │
│  POWER PROFILE                                  │
│  FTP: 265W (3.8 W/kg)                           │
│  CTL (fitness): 72 · ATL (fatigue): 58          │
│  TSB (form): +14 → fresh legs                    │
│  Weekly TSS: 480 (target: 550)                   │
│  Zone focus this week: Sweet Spot (88-94% FTP)  │
```

**Beat 5 — Ride readiness + HRV sparkline** (300ms pause)
```
│                                                 │
│  RIDE READINESS                                  │
│  HRV: 62ms (your avg: 58ms) · Sleep: 7h 12m    │
│  Deep: 1h 48m · RHR: 52bpm                      │
│  HRV 7d: ▃▅▇▅▄▆█ 62ms (↑0.8)                   │
│  Verdict: 🟢 Legs are fresh — go for watts       │
```

**Beat 6 — Footer** (300ms pause)
```
│                                                 │
│  🔑 bk_****{last4} · betterness.ai/settings     │
└─────────────────────────────────────────────────┘
```

**Beat 7 — Conversation starters** (500ms dramatic pause)
```
✨ Your Road Cycling workspace is live!

Try asking:
  💬 "What should my ride look like today?"
  💬 "Why is my ferritin flagged?"
  💬 "Plan a 3-hour endurance ride for Saturday"
```

### HRV Sparkline generation

Convert 7 days of HRV values to an ASCII sparkline:

```
Given: [48, 52, 58, 52, 50, 55, 62]
Range: min=48, max=62
Map each value to one of 8 block characters: ▁▂▃▄▅▆▇█
Result: ▁▃▇▃▂▅█
Display: HRV 7d: ▁▃▇▃▂▅█ 62ms (↑2.3)
```

If fewer than 3 data points available, skip the sparkline.

### Conversation starter generation

Pick 3 questions based on the user's actual data:

| Data condition | Suggested question |
|---------------|-------------------|
| TSB > +15 (very fresh) | "I'm feeling strong — plan a breakthrough ride" |
| TSB < -10 (deep fatigue) | "I'm buried — when should I expect to feel fresh?" |
| Has flagged biomarkers | "Why is my {marker} flagged and what does it mean for cycling?" |
| Iron/ferritin low | "How does low ferritin affect my power output?" |
| CTL trending down | "My fitness is dropping — how do I reverse this?" |
| Has target event | "Build me a taper plan for {event}" |
| Weekly TSS < target | "I'm behind on volume — what should I do this weekend?" |
| Has sleep data | "How did I sleep and should I ride hard today?" |
| Has route history | "Plan a route matching today's training intent" |
| No power data | "How do I connect my power meter?" |
| No devices | "What cycling devices should I connect?" |

Always include a ride/training question if activity data exists.
Always include the most actionable flagged biomarker if one exists.
Fill remaining slots from the condition table above.

### Health card — minimal data variations

**No devices:**
```
│  DEVICES                                            │
│  No devices connected yet.                          │
│  Connect a power meter at betterness.ai/devices     │
```

**No power data:**
```
│  POWER PROFILE                                      │
│  No power data yet.                                 │
│  Connect a Garmin or power meter to get started.    │
│  We'll calculate your FTP and training zones.       │
```

**No lab data:**
```
│  BIOMARKERS                                         │
│  No lab results yet.                                │
│  Cycling tip: "What labs should a cyclist get?"      │
```

**No health data (brand new user):**
Skip ride readiness section entirely. Replace with:
```
│  GETTING STARTED                                    │
│  1. Connect your Garmin at betterness.ai/devices    │
│  2. Ride with your power meter this week            │
│  3. Check back for your first ride readiness report │
```

**Bio age null:**
Omit bio age from the profile header:
```
│  {Name} · FTP {ftp}W ({w_kg} W/kg) · {device_count} devices │
```

**FTP null:**
```
│  {Name} · Bio Age {score} · {device_count} devices  │
│  (Connect a power meter to calculate FTP)            │
```

---

## Phase 5: Smoke Tests

Run 3 verification calls to confirm the workspace is properly connected:

```
🧪 Running smoke tests...
   ✅ listConnectedDevices — {n} devices found
   ✅ getUserLabData — {n} results found
   ✅ searchBiomarkers("ferritin") — found
```

If any smoke test fails:
```
   ⚠️ searchBiomarkers — failed (API returned 500)
   Your workspace is installed but some features may be limited.
   Try again later: "Run smoke tests"
```

Smoke test failure does NOT block the install. It's informational.

---

## Phase 6: Birth Certificate

Write `.betterness/installed.json` (see Step 3.3 for format).

On **refresh** (when installed.json already exists), calculate and display deltas:

```
📊 Since you installed (42 days ago):
   Bio age: 28.3 → 27.1 (↓1.2!)
   FTP: 255W → 265W (↑10W!)
   CTL: 58 → 72 (fitness up!)
   Devices: 2 → 3 (+1: Oura Ring)
   Lab results: 12 → 18 (+6 new results)
   Flagged markers: 2 → 1 (Ferritin now normal!)
```

If no meaningful deltas, skip this output.

---

## Rules

1. **Never crash.** Every error degrades to a less-personalized but functional workspace.
2. **Never fabricate health data.** If MCP returns empty, say "no data yet" — never invent values.
3. **Never log raw health data.** Progress output shows counts ("3 devices") not values ("FTP 265W" is OK in the card, not in logs).
4. **Never overwrite user-edited files on re-install.** Smart refresh only touches data-driven files.
5. **Always show the transparency notice** when storing credentials.
6. **Always mask the token** in displayed output. Show `bk_****{last4}` only.
7. **Respect rate limits.** 7 install calls + 3 smoke tests = 10 total. Well under 50/min limit.
8. **The card is the product.** If you have to cut corners, cut the file personalization — never cut the health card.
9. **Conversation starters must be personalized.** Generic "ask me anything" defeats the purpose. Every starter references the user's actual data.
10. **The animated reveal is not decoration.** The pacing creates anticipation and makes data feel alive. Don't skip it unless terminal is non-interactive.
