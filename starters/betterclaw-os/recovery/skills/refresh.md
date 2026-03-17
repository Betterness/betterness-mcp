# Skill: Health Data Refresh

```
  REFRESH FLOW:
  ┌───────────────────────────────────────────┐
  │  Heartbeat trigger (morning, before       │
  │  recovery verdict) or manual request      │
  └──────────┬────────────────────────────────┘
             │
  Step 1     ▼  READ TOKEN
  ┌───────────────────────────────────────────┐
  │  .betterness/credentials → bk_*           │
  │  Missing? → "Run claw workspace install"  │
  └──────────┬────────────────────────────────┘
             │
  Step 2     ▼  PULL DATA (6 calls in parallel)
  ┌───────────────────────────────────────────┐
  │  getProfileStats | listConnectedDevices | │
  │  getUserHealthData | getUserLabData |     │
  │  getBiologicalAge | flagOutOfRangeMarkers │
  └──────────┬────────────────────────────────┘
             │
  Step 3     ▼  UPDATE DATA FILES (only)
  ┌───────────────────────────────────────────┐
  │  memory/devices.md ← refreshed            │
  │  memory/health-snapshot.md ← refreshed    │
  │  memory/preferences.md ← merged           │
  └──────────┬────────────────────────────────┘
             │
  Step 4     ▼  BIRTH CERTIFICATE DELTA
  ┌───────────────────────────────────────────┐
  │  Compare .betterness/installed.json       │
  │  to current data → show improvements      │
  └──────────┬────────────────────────────────┘
             │
  Step 5     ▼  COMPACT HEALTH CARD
  ┌───────────────────────────────────────────┐
  │  Quick summary: devices, flagged markers, │
  │  recovery status, device warnings         │
  └─────────────────────────────────────────  ┘
```

## Trigger

This skill activates:
- **Automatically** via HEARTBEAT.md morning cron (runs before the recovery verdict skill)
- **Manually** when the user says:
  - "Refresh my health data"
  - "Update my data"
  - "Sync my workspace"
  - "Pull latest data"

---

## Execution

### Step 1: Read token

Read `.betterness/credentials` from the workspace root.

- **Token found** → Continue to Step 2
- **Token missing** → Print and stop:
  ```
  ❌ No Betterness token found.
  Run: claw workspace install betterness/recovery
  ```

### Step 2: Pull fresh data

Run 6 MCP calls **in parallel** (skip getUserProfile — it doesn't change):

| Call | Purpose |
|------|---------|
| `getProfileStats` | Updated health summary, bio age |
| `listConnectedDevices` | Current device list and sync status |
| `getUserHealthData` | Latest sleep, HRV, activity, resting HR |
| `getUserLabData` | Any new lab results since last refresh |
| `getBiologicalAge` | Current bio age score and trend |
| `flagOutOfRangeMarkers` | Currently flagged biomarkers |

Error handling per call:
- **401 (expired token)** → "Token expired. Get a new one at betterness.ai/settings"
- **429 (rate limit)** → Backoff and retry (max 3 times)
- **500 (server error)** → Retry once. If still fails: "⚠️ {tool} unavailable, using cached data"
- **Timeout (>10s)** → Retry once, then skip
- **Network error** → "Offline. Using cached data from last refresh."

If ALL calls fail, stop and print:
```
⚠️ Couldn't reach Betterness. Your workspace data is unchanged.
Last refresh: {date from health-snapshot.md header}
```

### Step 3: Update data files

**Only update data-driven files. NEVER touch user-owned files.**

Data-driven (updated):
- `memory/devices.md` — Full replacement with fresh device list
- `memory/health-snapshot.md` — Full replacement with latest data

Merged (not replaced):
- `memory/preferences.md` — Add newly connected devices to device list. Keep existing user-set preferences (bedtime, training days, notification settings). Only update auto-inferred values if the user hasn't manually overridden them.

User-owned (NEVER touched):
- `IDENTITY.md`, `SOUL.md`, `HEARTBEAT.md`, `AGENTS.md`, `PLANNING-MODE.md`, `ANTI-PATTERNS.md`, `WORKSPACE.md`

### Step 4: Birth certificate delta

If `.betterness/installed.json` exists, compare install-time data to current data:

```
📊 Since you installed ({days} days ago):
   Bio age: {old} → {new} ({delta})
   Devices: {old_count} → {new_count} ({+N new: device names})
   Lab results: {old_count} → {new_count} (+{N} new results)
   Flagged markers: {old_count} → {new_count} ({resolved/new names})
```

Only show deltas that actually changed. If nothing changed, skip this section entirely.

### Step 5: Compact health card

Render a shorter version of the install health card — no animated reveal, just the data:

```
┌─────────────────────────────────────────────────┐
│  🔄 RECOVERY DATA REFRESH                       │
│                                                 │
│  {Name} · Bio Age {score} · {device_count} dev  │
│                                                 │
│  DEVICES        LAST SYNC    STATUS              │
│  Oura Ring      2h ago       ✅ Active           │
│  WHOOP 4.0      4h ago       ✅ Active           │
│  Apple Watch    14d ago      ⚠️  Stale           │
│                                                 │
│  FLAGGED: Vitamin D ⚠️ Low · Ferritin ⚠️ Low    │
│  HRV 7d: ▃▅▇▅▄▆█ 62ms (↑0.8)                   │
│  Recovery: 🟢 Good                               │
└─────────────────────────────────────────────────┘
```

### Step 5b: Device warnings

For any device with last sync > 7 days:
```
⚠️ Apple Watch hasn't synced in 14 days.
   Open the Betterness app to reconnect it.
```

---

## Output format

**Heartbeat mode** (automatic, morning):
- Silent unless there are warnings or deltas
- If everything is normal: update files, no output (the recovery verdict skill handles the morning message)
- If device warnings: append warnings to the recovery verdict output
- If birth certificate deltas: append after weekly heartbeat summary only

**Manual mode** (user-triggered):
- Always show the compact health card
- Always show device warnings if any
- Show birth certificate deltas if they exist

---

## Rules

1. **Never touch user-owned files.** Even if the data suggests changes, respect user edits.
2. **Merge preferences, don't replace.** New devices get added, but user-set values are sacred.
3. **Summarize lab data, don't dump.** Most recent panel + flagged markers only.
4. **Silent success in heartbeat mode.** Don't spam the user with "refresh complete" every morning.
5. **Mask the token.** Never display the full token in any output.
6. **Cache-aware.** If MCP is unreachable, the workspace still works from cached data in memory/ files.
7. **Rate limit aware.** 6 refresh calls + potential retries. Stay well under 50/min.
