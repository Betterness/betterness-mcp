# Skill: Workspace Install — Magic Moment

```
  INSTALL FLOW:
  ┌─────────────────────────────────────────────────────────────────┐
  │  claw workspace install betterness/biohacker-lab                │
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
  │ memory/health-snapshot.md ← biomarkers + wearables  │
  │ memory/preferences.md ← protocols, supplements      │
  │ HEARTBEAT.md ← schedule from wake patterns          │
  │ AGENTS.md ← activate relevant specialists           │
  │ .betterness/credentials ← token (chmod 600)         │
  │ .betterness/installed.json ← birth certificate      │
  └──────────┬──────────────────────────────────────────┘
             │
  Phase 4    ▼  HEALTH CARD (animated reveal)
  ┌─────────────────────────────────────────────────────┐
  │ Profile summary → Devices → Biomarker dashboard →   │
  │ Bio age trend + HRV sparkline →                     │
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
| `getProfileStats` | Health summary, bio age, activity trends | Profile header, bio age trend |
| `listConnectedDevices` | Connected wearables and data sources, last sync | Device list, warnings |
| `getUserHealthData` | Sleep, HRV, activity | Recovery context for biomarker interpretation |
| `getUserLabData` | Lab panels, biomarker values, draw dates | Biomarker dashboard (primary card) |
| `getBiologicalAge` | Bio age score, trend, component breakdown | Bio age trend card |
| `flagOutOfRangeMarkers` | Currently flagged biomarkers | Dashboard flagging, conversation starters |

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
  │   → "Upload labs for full biomarker dashboard"│
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
- Number of lab panels on file
- Active protocols/supplements (if tracked)
- Connected devices and data sources

### Step 3.2 — Memory files

**memory/devices.md:**
```markdown
# Connected Devices & Data Sources
Last updated: {timestamp}

| Source | Type | Last Sync | Status |
|--------|------|-----------|--------|
| Betterness Labs | Lab panels | 12d ago | ✅ Active |
| Oura Ring Gen 3 | Sleep / HRV | 4h ago | ✅ Active |
| Dexcom G7 | CGM / Glucose | 5m ago | ✅ Active |
| WHOOP 4.0 | Recovery | 2h ago | ✅ Active |
```

**memory/health-snapshot.md:**
```markdown
# Health Snapshot
Last updated: {timestamp}

## Biomarker Dashboard
### Flagged (out of range)
| Marker | Value | Range | Status | Trend |
|--------|-------|-------|--------|-------|
| Vitamin D | 28 ng/mL | 40-80 | ⚠️ Low | ↑ improving |
| Ferritin | 22 ng/mL | 30-200 | ⚠️ Low | → flat |

### Improving (previously flagged, trending into range)
| Marker | Value | Previous | Status |
|--------|-------|----------|--------|
| hsCRP | 0.8 mg/L | 1.4 mg/L | ✅ Normalized |

### Stale (>90 days since last draw)
- Testosterone (last: 142 days ago)
- Cortisol AM (last: 142 days ago)

## Bio Age
- Current: {score} (chronological: {age})
- Trend: {direction} over last {N} draws
- Key drivers: {top 2-3 contributing markers}

## Recovery Context
- HRV: {value}ms (7d avg: {avg}ms)
- Sleep: {hours}h (deep: {deep}h)
- Resting HR: {value}bpm

## Glucose (if CGM connected)
- Avg glucose (7d): {value} mg/dL
- Time in range: {percent}%
- Fasting avg: {value} mg/dL
```

**memory/preferences.md:**
```markdown
# Preferences
- Lab cadence: {quarterly / monthly / custom}
- Active protocols: {list or "none tracked"}
- Supplement stack: {list or "not logged"}
- Priority markers: {user-flagged or auto-detected}
- CGM: {connected / not connected}
- Wake time: {inferred}
- Preferred lab provider: {if known}
```

### Step 3.3 — System files

**HEARTBEAT.md:** Insert wake time. Set lab retest reminders based on stale markers.

**AGENTS.md:** Activate relevant specialists:
- Biomarker interpretation specialist (always)
- Retest decision specialist (always)
- Protocol/supplement specialist (if protocols tracked)
- Bio age specialist (if bio age data available)
- Glucose specialist (if CGM connected)
- Recovery specialist (if wearable data available)

**.betterness/installed.json:**
```json
{
  "workspace": "betterness/biohacker-lab",
  "version": "1.0.0",
  "installed_at": "{ISO timestamp}",
  "token_prefix": "bk_****{last4}",
  "data_at_install": {
    "bio_age": 27.3,
    "device_count": 4,
    "lab_panel_count": 6,
    "lab_result_count": 47,
    "flagged_marker_count": 2,
    "stale_marker_count": 2
  }
}
```

---

## Phase 4: Health Card — Animated Reveal

The card renders in terminal with timed beats. Each beat appears after a pause to create anticipation.

**Beat 1 — Profile header** (immediate)
```
┌─────────────────────────────────────────────────┐
│  🧬 BIOHACKER LAB                               │
│                                                 │
│  {Name} · Bio Age {score} (chrono: {age})       │
│  {panel_count} panels · {result_count} results  │
```

**Beat 2 — Devices & data sources** (200ms pause)
```
│                                                 │
│  DATA SOURCES     LAST SYNC    STATUS            │
│  Betterness Labs  12d ago      ✅ Active         │
│  Oura Ring        4h ago       ✅ Active         │
│  Dexcom G7        5m ago       ✅ Active         │
│  WHOOP 4.0        2h ago       ✅ Active         │
```

**Beat 3 — Device warnings** (only if stale devices exist)
```
│                                                 │
│  ⚠️  Withings hasn't synced in 30 days.          │
│     Open the Betterness app to reconnect it.    │
```

**Beat 4 — Biomarker dashboard** (300ms pause)
```
│                                                 │
│  BIOMARKER DASHBOARD                            │
│                                                 │
│  ⚠️  FLAGGED                                     │
│  Vitamin D    28 ng/mL    ⚠️  Low   ↑ improving │
│  Ferritin     22 ng/mL    ⚠️  Low   → flat      │
│                                                 │
│  ✅ IMPROVING                                    │
│  hsCRP        0.8 mg/L    ✅ (was 1.4)          │
│                                                 │
│  ⏰ STALE (retest recommended)                   │
│  Testosterone  — last draw: 142 days ago        │
│  Cortisol AM   — last draw: 142 days ago        │
```

**Beat 5 — Bio age trend + HRV sparkline** (300ms pause)
```
│                                                 │
│  BIO AGE TREND                                   │
│  27.3 years (chrono: 34)                         │
│  Δ6mo: ↓0.8 years — protocol is working         │
│  Key drivers: hsCRP ↓, glucose ↓, albumin ↑     │
│                                                 │
│  HRV 7d: ▃▅▇▅▄▆█ 62ms (↑0.8)                   │
│  Sleep: 7h 22m · Deep: 1h 44m                   │
```

**Beat 6 — Footer** (300ms pause)
```
│                                                 │
│  🔑 bk_****{last4} · betterness.ai/settings     │
└─────────────────────────────────────────────────┘
```

**Beat 7 — Conversation starters** (500ms dramatic pause)
```
✨ Your Biohacker Lab workspace is live!

Try asking:
  💬 "Why is my Vitamin D still low?"
  💬 "When should I retest testosterone?"
  💬 "Is my protocol working?"
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
| Has flagged biomarkers | "Why is my {marker} {status} and what should I do?" |
| Has stale markers (>90d) | "When should I retest {marker}?" |
| Bio age improving | "What's driving my bio age improvement?" |
| Bio age worsening | "Why is my bio age trending up?" |
| Has active protocols | "Is my {protocol} working based on the latest labs?" |
| Multiple draws available | "Show me the trend for {most-changed marker}" |
| Iron/ferritin flagged | "What form of iron should I take?" |
| Vitamin D flagged | "What's the best Vitamin D protocol for my level?" |
| Has CGM data | "How is my glucose trending this week?" |
| No lab data | "What labs should I order for a baseline?" |
| No devices | "What wearable should I connect?" |
| Has sleep data | "Is my sleep affecting my biomarkers?" |

Always include the most actionable flagged biomarker if one exists.
Always include a retest recommendation if stale markers exist.
Fill remaining slots from the condition table above.

### Health card — minimal data variations

**No lab data:**
```
│  BIOMARKER DASHBOARD                                │
│  No lab results yet.                                │
│  Upload your first panel: "What labs should I get?" │
│  Or order through Betterness: betterness.ai/labs    │
```

**No devices:**
```
│  DATA SOURCES                                       │
│  No wearables connected yet.                        │
│  Connect a device at betterness.ai/devices          │
│  (Labs work without wearables — wearables add       │
│   recovery context to biomarker interpretation)     │
```

**No bio age:**
```
│  BIO AGE                                            │
│  Not enough lab data for bio age calculation.       │
│  Need: CBC, CMP, lipid panel (9 markers minimum)   │
│  Ask: "What labs do I need for bio age?"            │
```

**No health data (brand new user):**
Skip bio age and recovery sections. Replace with:
```
│  GETTING STARTED                                    │
│  1. Upload labs at betterness.ai/labs               │
│  2. Connect a wearable for recovery context         │
│  3. Ask: "Interpret my latest panel"                │
```

**Bio age null:**
Omit bio age from the profile header:
```
│  {Name} · {panel_count} panels · {result_count} results │
```

---

## Phase 5: Smoke Tests

Run 3 verification calls to confirm the workspace is properly connected:

```
🧪 Running smoke tests...
   ✅ listConnectedDevices — {n} devices found
   ✅ getUserLabData — {n} results ({n} panels)
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
📊 Since you installed (90 days ago):
   Bio age: 28.1 → 27.3 (↓0.8!)
   Lab panels: 4 → 6 (+2 new draws)
   Lab results: 32 → 47 (+15 new results)
   Flagged markers: 4 → 2 (hsCRP, homocysteine normalized!)
   Stale markers: 0 → 2 (testosterone, cortisol due for retest)
   Devices: 3 → 4 (+1: Dexcom G7)
```

If no meaningful deltas, skip this output.

---

## Rules

1. **Never crash.** Every error degrades to a less-personalized but functional workspace.
2. **Never fabricate health data.** If MCP returns empty, say "no data yet" — never invent values.
3. **Never log raw health data.** Progress output shows counts ("47 results") not values ("Vitamin D 28 ng/mL" is OK in the card, not in logs).
4. **Never overwrite user-edited files on re-install.** Smart refresh only touches data-driven files.
5. **Always show the transparency notice** when storing credentials.
6. **Always mask the token** in displayed output. Show `bk_****{last4}` only.
7. **Respect rate limits.** 7 install calls + 3 smoke tests = 10 total. Well under 50/min limit.
8. **The card is the product.** If you have to cut corners, cut the file personalization — never cut the health card.
9. **Conversation starters must be personalized.** Generic "ask me anything" defeats the purpose. Every starter references the user's actual data.
10. **The animated reveal is not decoration.** The pacing creates anticipation and makes data feel alive. Don't skip it unless terminal is non-interactive.
11. **Lab data is the primary surface.** Unlike other workspaces that lead with wearable data, biohacker-lab leads with biomarkers. The dashboard is the hero, not recovery.
