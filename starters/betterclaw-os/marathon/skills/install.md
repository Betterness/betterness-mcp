# Skill: Workspace Install — Magic Moment

```
  INSTALL FLOW:
  ┌─────────────────────────────────────────────────────────────────┐
  │  claw workspace install betterness/marathon                    │
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
  │ memory/health-snapshot.md ← training + labs         │
  │ memory/preferences.md ← race date, pace, plan      │
  │ HEARTBEAT.md ← schedule from wake patterns          │
  │ AGENTS.md ← activate relevant specialists           │
  │ .betterness/credentials ← token (chmod 600)         │
  │ .betterness/installed.json ← birth certificate      │
  └──────────┬──────────────────────────────────────────┘
             │
  Phase 4    ▼  HEALTH CARD (animated reveal)
  ┌─────────────────────────────────────────────────────┐
  │ Profile summary → Devices → Training status →       │
  │ Race readiness + HRV sparkline →                    │
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

## Trigger

This skill runs once during `claw workspace install betterness/marathon`. It is the first-run personalization experience.

Also activates on:
- "Set up my workspace"
- "Connect my Betterness account"
- "Personalize this workspace"

On re-run (workspace already exists), activates **smart refresh mode** — updates data files, preserves user edits.

---

## Constants

```
MCP_ENDPOINT    = https://api.betterness.ai/mcp
TOKEN_PREFIX    = bk_
MAX_RETRIES     = 3
RETRY_BACKOFF   = [1s, 3s, 10s]
TIMEOUT         = 10s
MAX_DEVICES     = 5        # show top 5 by last-sync in health card
MAX_BIOMARKERS  = 5        # show top 5 flagged in health card
STALE_SYNC_DAYS = 7        # warn if device hasn't synced in this many days
SPARKLINE_DAYS  = 7        # HRV trend window
SPARKLINE_CHARS = ▁▂▃▄▅▆▇█
```

---

## Phase 1: Token Bootstrap

### Step 1.1: Check for existing token

```
Look for token in these locations (in order):
1. .betterness/credentials    (this workspace — from previous install)
2. ~/.betterness/credentials  (global — shared across workspaces)
3. ~/.config/betterness/token (CLI config — from `betterness auth login`)
```

If a token is found:
```
🔑 Found saved Betterness token.
```

If no token is found, proceed to Step 1.2.

### Step 1.2: Interactive token prompt

```
🔑 Connect your Betterness account

   Paste your token from betterness.ai/settings → MCP Keys
   (starts with bk_):
```

Input handling:
- Trim whitespace from pasted input
- Mask display: show `bk_****` + last 4 characters while typing
- Validate prefix: must start with `bk_`
- If empty or missing prefix → "That doesn't look like a Betterness token. It should start with bk_"
- Max 2 retries before: "Get your token at betterness.ai/settings → MCP Keys"

### Step 1.3: Validate token

Call `getUserProfile` with the token.

- **200 OK** → Token valid. Extract user name. Print: `✅ Welcome, {name}!`
- **401** → "❌ Token invalid or expired. Try again:" (retry, max 2)
- **429** → Wait 60s, retry once. "⏳ Rate limited, retrying..."
- **500** → Retry once. If still fails: "⚠️ Betterness API is having issues. Installing basic workspace."
- **Timeout (>10s)** → Retry once. If still fails: same degraded message.
- **Network error** → "⚠️ Can't reach Betterness. Installing basic workspace without health data."

On validation success, store the profile response for Phase 3.

---

## Phase 2: Data Pull

### Step 2.1: Parallel MCP calls

After getUserProfile succeeds, run these 6 calls **in parallel**:

| Call | Data Retrieved | Used For |
|------|---------------|----------|
| `getProfileStats` | Age, gender, location, health summary | IDENTITY.md, health card |
| `listConnectedDevices` | All paired wearables | memory/devices.md, health card, warnings |
| `getUserHealthData` | Recent sleep, HRV, activity, resting HR | memory/health-snapshot.md, health card, sparkline |
| `getUserLabData` | Lab panels and results | memory/health-snapshot.md, health card |
| `getBiologicalAge` | Bio age score and trend | health card |
| `flagOutOfRangeMarkers` | Out-of-range biomarkers | health card, conversation starters |

### Step 2.2: Handle partial failures

Each call can succeed or fail independently. Track results:

```
📡 Pulling your health data...
   ✅ Profile loaded
   ✅ 2 devices found (Garmin Forerunner 965, Apple Watch)
   ✅ Health data loaded (sleep, HRV, activity)
   ✅ 23 lab results loaded (last: 2026-03-01)
   ✅ Bio age: 29.1 (↓0.8 from 6 months ago)
   ✅ 1 flagged biomarker found
```

Error handling per call:
- **401** → Should not happen (token validated in Phase 1). If it does: "Token expired mid-install. Re-authenticate."
- **429** → Backoff and retry (max 3 times with exponential backoff)
- **500** → Retry once. If still fails: skip this data source, note it.
- **Timeout** → Retry once. If still fails: skip this data source.
- **Empty response (200 but no data)** → Not an error. Note it: "No devices connected yet" / "No lab data yet"

### Degradation Ladder

```
  Level 0: Full magic     ← All 7 calls succeed
  Level 1: Partial magic  ← Profile works, some data calls fail
  Level 2: Name only      ← getUserProfile works, everything else fails
  Level 3: Clean install  ← All calls fail, template installed as-is
```

Never crash. Always install something usable.

---

## Phase 3: Personalize Files

### Step 3.0: Detect re-install

Check if `.betterness/installed.json` exists:
- If YES → **Smart refresh mode**:
  - Update only data-driven files (see list below)
  - Preserve user-edited files
  - Print: "🔄 Refreshing your workspace data..."
- If NO → **Fresh install mode**:
  - Personalize all files
  - Print: "📝 Personalizing your workspace..."

### Data-driven files (refreshed on re-install):

| File | Source | Content |
|------|--------|---------|
| `.betterness/credentials` | Token from Phase 1 | Token string, chmod 600 |
| `memory/devices.md` | listConnectedDevices | Device name, type, last sync, status |
| `memory/health-snapshot.md` | getUserHealthData + getUserLabData | Training metrics, weekly mileage, race countdown, recent labs, flagged markers |
| `memory/preferences.md` | Inferred from data | Race date, target pace, training plan week, preferred run days. On re-install: MERGE — add new devices, keep existing user preferences. |

### User-owned files (NEVER overwritten on re-install):

| File | Source | Content |
|------|--------|---------|
| `IDENTITY.md` | getUserProfile + getProfileStats | Rewrite with user's name, race goals, age, connected devices, training context |
| `HEARTBEAT.md` | getUserHealthData (wake patterns) | Customize morning heartbeat time based on typical wake time. If no sleep data, default to 6:00 AM (earlier for runners). |
| `AGENTS.md` | listConnectedDevices + getUserLabData | Activate relevant specialists: if Garmin/COROS → training load analyst active. If lab data → biomarker analyst active. If activity data → race readiness gate active. |

### Step 3.1: Write data files

Create `memory/` directory if it doesn't exist.

**memory/devices.md:**
```markdown
# Connected Devices

Last updated: {date}

| Device | Type | Last Sync | Status |
|--------|------|-----------|--------|
| Garmin Forerunner 965 | Watch | 2h ago | ✅ Active |
| Apple Watch S9 | Watch | 6h ago | ✅ Active |

Primary training device: Garmin Forerunner 965 (GPS + running dynamics)
```

**memory/health-snapshot.md:**
```markdown
# Health Snapshot

Last updated: {date}

## Training Status
- Weekly mileage: 42 mi (plan: 45 mi)
- Long run: 16 mi (last Saturday)
- Training load: 72% of target
- Streak: 14 consecutive training weeks

## Race
- Target: Boston Marathon
- Date: 2026-04-20
- Days out: 28
- Phase: Peak · Week 14 of 18

## Recent Metrics
- HRV: 58ms (7-day avg: 55ms)
- Resting HR: 48 bpm
- Deep sleep: 1h 55m (last night)
- Sleep duration: 7h 30m

## Most Recent Lab Panel
Date: 2026-03-01
Panel: Inflammation Panel

## Flagged Biomarkers
| Marker | Value | Range | Status |
|--------|-------|-------|--------|
| Ferritin | 28 ng/mL | 30-400 | ⚠️ Low |

## Bio Age
Score: 29.1 (chronological: 32)
Trend: ↓0.8 over past 6 months
```

**memory/preferences.md** (fresh install):
```markdown
# Preferences

## Race
Target race: {from profile or "not set"}
Race date: {from profile or "not set"}
Target pace: {inferred from activity data, or "not set"}

## Training
Plan week: {inferred from activity pattern, or "not set"}
Long run day: {inferred from activity data, or "Saturday"}
Easy run pace: {inferred or "not set"}
Rest days: {inferred from activity gaps, or "Monday"}

## Sleep
Primary tracker: {device with best sleep data}
Target bedtime: {inferred from sleep data, or "not set"}
Target wake time: {inferred from sleep data, or "not set"}

## Notifications
Morning heartbeat: {wake_time + 15 min}
Pre-long-run brief: {long_run_day - 1 evening}
Weekly summary: Sunday evening
```

### Step 3.2: Write user-owned files (fresh install only)

**IDENTITY.md** — Rewrite the template with real data:
- Replace generic descriptions with user's name, race goals, training context
- List their actual connected devices
- Reference their current training phase if activity data is available
- Keep the structure and headings from the template

**HEARTBEAT.md** — Customize the schedule:
- Morning heartbeat: set to {wake_time + 15 min}, default 6:00 AM
- Pre-long-run brief: evening before long run day
- Keep all other content from the template

**AGENTS.md** — Activate relevant specialists:
- If GPS watch connected → "Training Load Analyst: ACTIVE"
- If lab data exists → "Biomarker Analyst: ACTIVE"
- If activity data exists → "Race Readiness Gate: ACTIVE"
- If no race date → add note: "Race Strategist: PENDING — set your race date to activate"

### Step 3.3: Write credentials and birth certificate

**.betterness/credentials:**
```
{token}
```
Set file permissions to 0600. Add `.betterness/` to `.gitignore` if not already present.

Print transparency notice:
```
🔐 Token saved to .betterness/credentials (gitignored)
   This file is stored in plain text on this machine.
   Revoke anytime at betterness.ai/settings
```

**.betterness/installed.json:**
```json
{
  "installed_at": "2026-03-17T06:30:00Z",
  "version": "1.0.0",
  "workspace": "marathon",
  "user_id": "{from getUserProfile}",
  "user_name": "{name}",
  "bio_age_at_install": 29.1,
  "devices_at_install": ["Garmin Forerunner 965", "Apple Watch S9"],
  "device_count": 2,
  "lab_result_count": 23,
  "flagged_markers": ["Ferritin"],
  "degradation_level": 0,
  "race_date": "2026-04-20",
  "race_name": "Boston Marathon"
}
```

---

## Phase 4: Health Card (Animated Reveal)

The health card is the signature moment. Each section appears with a brief pause between sections (300-500ms) to create the feeling of data materializing.

### Reveal sequence:

**Beat 1 — Profile header** (appears first)
```
┌─────────────────────────────────────────────────────┐
│  🏃  YOUR MARATHON HEALTH CARD                      │
│                                                     │
│  {Name} · Bio Age {score} · {device_count} devices  │
```

**Beat 2 — Devices** (300ms pause, then appear one by one)
```
│                                                     │
│  DEVICES         LAST SYNC     STATUS               │
│  Garmin FR 965   2h ago        ✅ Active             │
│  Apple Watch     6h ago        ✅ Active             │
```

**Beat 3 — Device warnings** (only if stale devices exist)
```
│                                                     │
│  ⚠️  Apple Watch hasn't synced in 14 days.          │
│     Open the Betterness app to reconnect it.        │
```

**Beat 4 — Training status** (300ms pause)
```
│                                                     │
│  TRAINING STATUS                                    │
│  Weekly mileage:  42 mi (plan: 45 mi)               │
│  Long run:        16 mi (Saturday)                   │
│  Training load:   ██████░░░░ 72%                     │
│  Race:            Boston Marathon · 28 days out       │
│  Phase:           Peak · Week 14 of 18               │
```

**Beat 5 — Race readiness + HRV sparkline** (300ms pause)
```
│                                                     │
│  RACE READINESS                                     │
│  HRV: 58ms (your avg: 55ms) · Sleep: 7h 30m        │
│  Resting HR: 48bpm · Trend: stable                  │
│  HRV 7d: ▃▅▆▅▄▅▇ 58ms (↑0.5)                      │
│  Status: 🟢 On track                                │
```

**Beat 6 — Footer** (300ms pause)
```
│                                                     │
│  🔑 bk_****{last4} · betterness.ai/settings        │
└─────────────────────────────────────────────────────┘
```

**Beat 7 — Conversation starters** (500ms dramatic pause)
```
✨ Your Marathon workspace is live!

Try asking:
  💬 "Am I ready for my long run Saturday?"
  💬 "Should I adjust my pace for the heat?"
  💬 "What's my taper plan look like?"
```

### HRV Sparkline generation

```
Given: [50, 52, 55, 52, 50, 52, 58]
Range: min=50, max=58
Map each value to one of 8 block characters: ▁▂▃▄▅▆▇█
Result: ▁▃▆▃▁▃█
Display: HRV 7d: ▁▃▆▃▁▃█ 58ms (↑0.5)
```

If fewer than 3 data points available, skip the sparkline.

### Conversation starter generation

Pick 3 questions based on the user's actual data:

| Data condition | Suggested question |
|---------------|-------------------|
| Race date set | "How many days until my race?" |
| Long run this week | "Am I ready for my long run {day}?" |
| Training load high (>80%) | "Should I dial back this week?" |
| Taper phase active | "What's my taper plan look like?" |
| HRV trending down (7d) | "Why has my HRV dropped this week?" |
| Has sleep data | "How's my recovery for training?" |
| Has flagged biomarkers | "Why is my {marker} flagged?" |
| Weather data available | "Should I adjust my pace for the heat?" |
| No race date | "How do I set my target race?" |
| No devices | "What GPS watch should I connect?" |

Always include one training question if activity data exists.
Always include the most actionable flagged biomarker if one exists.
Fill remaining slots from the condition table above.

### Health card — minimal data variations

**No devices:**
```
│  DEVICES                                            │
│  No devices connected yet.                          │
│  Connect a GPS watch at betterness.ai/devices       │
```

**No activity data:**
```
│  TRAINING STATUS                                    │
│  No training data yet.                              │
│  Connect a device and run to see your status.       │
```

**No race date:**
```
│  RACE                                               │
│  No target race set.                                │
│  Tell me your race: "I'm training for Boston 2026"  │
```

**Bio age null:**
Omit bio age from the profile header:
```
│  {Name} · {device_count} devices                    │
```

---

## Phase 5: Smoke Tests

Run 3 verification calls to confirm the workspace is properly connected:

```
🧪 Running smoke tests...
   ✅ listConnectedDevices — {n} devices found
   ✅ getUserLabData — {n} results found
   ✅ searchBiomarkers("vitamin d") — found
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
   Bio age: 29.1 → 28.5 (↓0.6!)
   Devices: 2 → 3 (+1: COROS PACE 3)
   Lab results: 23 → 31 (+8 new results)
   Weekly mileage: 42 → 48 (peak week!)
```

If no meaningful deltas, skip this output.

---

## Rules

1. **Never crash.** Every error degrades to a less-personalized but functional workspace.
2. **Never fabricate health data.** If MCP returns empty, say "no data yet" — never invent values.
3. **Never log raw health data.** Progress output shows counts ("2 devices") not values ("HRV 58ms" is OK in the card, not in logs).
4. **Never overwrite user-edited files on re-install.** Smart refresh only touches data-driven files.
5. **Always show the transparency notice** when storing credentials.
6. **Always mask the token** in displayed output. Show `bk_****{last4}` only.
7. **Respect rate limits.** 7 install calls + 3 smoke tests = 10 total. Well under 50/min limit.
8. **The card is the product.** If you have to cut corners, cut the file personalization — never cut the health card.
9. **Conversation starters must be personalized.** Generic "ask me anything" defeats the purpose. Every starter references the user's actual data.
10. **The animated reveal is not decoration.** The pacing creates anticipation and makes data feel alive. Don't skip it unless terminal is non-interactive.
