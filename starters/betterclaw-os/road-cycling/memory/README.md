# Road Cycling Operator — Local Memory

This directory is populated by the install skill (`skills/install.md`) during `claw workspace install`.

## Files created during install

| File | Source | Updates |
|------|--------|---------|
| `devices.md` | MCP `listConnectedDevices` | Refreshed by `skills/refresh.md` |
| `health-snapshot.md` | MCP health data + labs + biomarkers | Refreshed by `skills/refresh.md` |
| `preferences.md` | Inferred from device and sleep data | Merged on refresh (user edits preserved) |

## Files created during use

| File | Source | Updates |
|------|--------|---------|
| `YYYY-MM-DD.md` | Daily recovery verdicts and conversation logs | One per day, auto-created |

## Memory rules

- **Don't duplicate what Betterness Graph knows.** Wearable data and lab history live in MCP.
- **Summarize, don't accumulate.** If a week of logs says the same thing, consolidate.
- **Preferences are durable. Verdicts are ephemeral.** Keep preferences updated. Let daily logs age.
