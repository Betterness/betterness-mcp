# Skill: Workspace Install — Magic Moment

```
  INSTALL FLOW:
  ┌─────────────────────────────────────────────────────────────────┐
  │  claw workspace install betterness/barrys-studio                │
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
  │ memory/health-snapshot.md ← recovery + activity     │
  │ memory/preferences.md ← class schedule, intensity   │
  │ HEARTBEAT.md ← schedule from wake patterns          │
  │ AGENTS.md ← activate relevant specialists           │
  │ .betterness/credentials ← token (chmod 600)         │
  │ .betterness/installed.json ← birth certificate      │
  └──────────┬──────────────────────────────────────────┘
             │
  Phase 4    ▼  HEALTH CARD (animated reveal)
  ┌─────────────────────────────────────────────────────┐
  │ Profile summary → Devices → Class readiness →       │
  │ Recovery + HRV sparkline →                          │
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
| `getUserHealthData` | Sleep, HRV, activity, strain, recovery score | Class readiness, intensity balance |
| `getUserLabData` | Lab panels, biomarker results | Flagged markers (cortisol, CRP) |
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
  │   → "Connect devices for class readiness"    │
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
- Studio preference (Barry's, Orangetheory, F45, etc.)
- Class frequency and preferred class types
- Connected devices

### Step 3.2 — Memory files

**memory/devices.md:**
```markdown
# Connected Devices
Last updated: {timestamp}

| Device | Type | Last Sync | Status |
|--------|------|-----------|--------|
| WHOOP 4.0 | Recovery / Strain | 2h ago | ✅ Active |
| Oura Ring Gen 3 | Sleep / HRV | 4h ago | ✅ Active |
| Apple Watch S9 | Heart rate / Activity | 1h ago | ✅ Active |
```

**memory/health-snapshot.md:**
```markdown
# Health Snapshot
Last updated: {timestamp}

## Class Activity
- Classes this week: {count} ({types})
- Weekly strain: {value} (WHOOP)
- Avg class HR: {value}bpm ({percent}% max)
- Recovery since last class: {hours}h

## Recovery
- HRV: {value}ms (7d avg: {avg}ms)
- Resting HR: {value}bpm
- Sleep: {hours}h (deep: {deep}h)
- Recovery score: {score}
- Body Battery: {value} (Garmin, if available)

## Intensity Balance
- High intensity this week: {count} classes
- Low/moderate: {count} classes or rest days
- Recommendation: {go hard / dial back / rest}

## Biomarkers
- Flagged: {list or "none"}
- Last panel: {date}
- Key for studio: cortisol {value}, CRP {value}
```

**memory/preferences.md:**
```markdown
# Preferences
- Studio: {inferred or "Barry's"}
- Preferred classes: {types}
- Weekly target: {count} classes
- Preferred class days: {inferred from activity patterns}
- Rest days: {inferred}
- Wake time: {inferred}
- Post-class nutrition: {enabled/disabled}
```

### Step 3.3 — System files

**HEARTBEAT.md:** Insert wake time and class schedule from activity patterns.

**AGENTS.md:** Activate relevant specialists:
- Class readiness specialist (always)
- Post-class recovery specialist (always)
- Nutrition specialist (if enabled)
- Intensity balance specialist (if 3+ classes/week)
- Body composition specialist (if Withings/InBody data)

**.betterness/installed.json:**
```json
{
  "workspace": "betterness/barrys-studio",
  "version": "1.0.0",
  "installed_at": "{ISO timestamp}",
  "token_prefix": "bk_****{last4}",
  "data_at_install": {
    "bio_age": null,
    "device_count": 3,
    "weekly_classes": 4,
    "avg_strain": 14.2,
    "lab_result_count": 8,
    "flagged_marker_count": 0
  }
}
```

---

## Phase 4: Health Card — Animated Reveal

The card renders in terminal with timed beats. Each beat appears after a pause to create anticipation.

**Beat 1 — Profile header** (immediate)
```
┌─────────────────────────────────────────────────┐
│  🏋️ STUDIO OPERATOR                              │
│                                                 │
│  {Name} · Bio Age {score} · {device_count} dev  │
```

**Beat 2 — Devices** (200ms pause)
```
│                                                 │
│  DEVICES        LAST SYNC    STATUS              │
│  WHOOP 4.0      2h ago       ✅ Active           │
│  Oura Ring      4h ago       ✅ Active           │
│  Apple Watch    1h ago       ✅ Active           │
```

**Beat 3 — Device warnings** (only if stale devices exist)
```
│                                                 │
│  ⚠️  Garmin hasn't synced in 10 days.            │
│     Open the Betterness app to reconnect it.    │
```

**Beat 4 — Class readiness** (300ms pause)
```
│                                                 │
│  CLASS READINESS                                │
│  This week: 3 classes (target: 4)               │
│  Last class: Tuesday (16h ago)                  │
│  Weekly strain: 38.2 (WHOOP)                    │
│  Intensity balance: 2 hard / 1 moderate         │
│  Next class call: 🟢 Go hard — fully recovered  │
```

**Beat 5 — Recovery + HRV sparkline** (300ms pause)
```
│                                                 │
│  RECOVERY TODAY                                  │
│  HRV: 58ms (your avg: 54ms) · Sleep: 7h 32m    │
│  Deep: 1h 52m · RHR: 56bpm                      │
│  HRV 7d: ▃▅▆▅▃▅▇ 58ms (↑0.6)                   │
│  Recovery: 🟢 Good — class today is a green light │
```

**Beat 6 — Footer** (300ms pause)
```
│                                                 │
│  🔑 bk_****{last4} · betterness.ai/settings     │
└─────────────────────────────────────────────────┘
```

**Beat 7 — Conversation starters** (500ms dramatic pause)
```
✨ Your Studio workspace is live!

Try asking:
  💬 "Should I go hard or dial back today?"
  💬 "What should I eat after class?"
  💬 "Am I overtraining this week?"
```

### HRV Sparkline generation

Convert 7 days of HRV values to an ASCII sparkline:

```
Given: [48, 52, 55, 52, 48, 52, 58]
Range: min=48, max=58
Map each value to one of 8 block characters: ▁▂▃▄▅▆▇█
Result: ▁▃▆▃▁▃█
Display: HRV 7d: ▁▃▆▃▁▃█ 58ms (↑0.6)
```

If fewer than 3 data points available, skip the sparkline.

### Conversation starter generation

Pick 3 questions based on the user's actual data:

| Data condition | Suggested question |
|---------------|-------------------|
| Class today (from schedule) | "Should I go hard or dial back today?" |
| Recovery score < 50% | "I'm not feeling recovered — should I skip class?" |
| 4+ high-intensity classes this week | "Am I overtraining this week?" |
| Has flagged biomarkers | "Why is my {marker} flagged?" |
| Cortisol high | "Is my cortisol too high from training?" |
| Post-class (< 2h after class) | "What should I eat right now?" |
| Has sleep data | "How did I sleep last night?" |
| Strain trending up week-over-week | "Is my weekly load sustainable?" |
| Body comp data available | "Is my body changing from studio training?" |
| No devices | "What wearable should I connect?" |

Always include a class readiness question if activity data exists.
Always include the most actionable flagged biomarker if one exists.
Fill remaining slots from the condition table above.

### Health card — minimal data variations

**No devices:**
```
│  DEVICES                                            │
│  No devices connected yet.                          │
│  Connect a wearable at betterness.ai/devices        │
```

**No activity data:**
```
│  CLASS READINESS                                    │
│  No class data yet.                                 │
│  Wear your device to class this week and check back.│
```

**No lab data:**
```
│  BIOMARKERS                                         │
│  No lab results yet.                                │
│  Ask: "What labs should I get as a studio athlete?" │
```

**No health data (brand new user):**
Skip class readiness section entirely. Replace with:
```
│  GETTING STARTED                                    │
│  1. Connect a wearable at betterness.ai/devices     │
│  2. Wear it to your next class                      │
│  3. Check back for your first class readiness report│
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
   ✅ searchBiomarkers("cortisol") — found
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
📊 Since you installed (30 days ago):
   Bio age: 31.2 → 30.4 (↓0.8!)
   Weekly classes: 3 → 4 (consistency up!)
   Avg strain: 12.1 → 14.2 (intensity up!)
   Devices: 2 → 3 (+1: Apple Watch)
   Lab results: 8 → 14 (+6 new results)
   Flagged markers: 1 → 0 (Cortisol normalized!)
```

If no meaningful deltas, skip this output.

---

## Rules

1. **Never crash.** Every error degrades to a less-personalized but functional workspace.
2. **Never fabricate health data.** If MCP returns empty, say "no data yet" — never invent values.
3. **Never log raw health data.** Progress output shows counts ("3 devices") not values ("HRV 58ms" is OK in the card, not in logs).
4. **Never overwrite user-edited files on re-install.** Smart refresh only touches data-driven files.
5. **Always show the transparency notice** when storing credentials.
6. **Always mask the token** in displayed output. Show `bk_****{last4}` only.
7. **Respect rate limits.** 7 install calls + 3 smoke tests = 10 total. Well under 50/min limit.
8. **The card is the product.** If you have to cut corners, cut the file personalization — never cut the health card.
9. **Conversation starters must be personalized.** Generic "ask me anything" defeats the purpose. Every starter references the user's actual data.
10. **The animated reveal is not decoration.** The pacing creates anticipation and makes data feel alive. Don't skip it unless terminal is non-interactive.
