# BetterClaw OS Starters

BetterClaw OS is a Betterness-powered health workspace system for OpenClaw.

One command installs a fully personalized health workspace with connected data, AI agents, and automated daily briefings.

```bash
claw workspace install betterness/recovery
```

## Flagship Packages

| Package | Focus | Status |
|---------|-------|--------|
| `recovery` | Sleep, stress, and nervous system recovery | **Available** — installer + heartbeat + smoke tests |
| `marathon` | Race training, tapering, fueling, and recovery | Workspace files ready |
| `biohacker-lab` | Labs, supplements, protocols, and biological age | Workspace files ready |
| `road-cycling` | Watts, zones, routes, weather, and training load | Workspace files ready |
| `barrys-studio` | Barry's experience, recovery and class readiness | Workspace files ready |

## What Lives Here

```
betterclaw-os/
  START-HERE.md             # Onboarding guide — start here
  WHAT-BETTER-LOOKS-LIKE.md # Design principles
  recovery/                 # ✨ Reference package with full installer
    skills/
      install.md            # Magic moment installer (token → data → personalize → wow)
      refresh.md            # Daily heartbeat auto-refresh
      recovery-verdict.md   # Morning recovery scoring
      sleep-analysis.md     # Overnight sleep interpretation
    memory/                 # Personalized data files (created by installer)
    modules/                # Recovery intelligence modules
    tests/fixtures/         # MCP response fixtures for testing
  marathon/                 # Endurance package
  biohacker-lab/            # Biomarker and protocol package
  road-cycling/             # Power-based performance package
  barrys-studio/            # Boutique studio package
```

## How It Works

1. **Install** — `claw workspace install betterness/recovery` runs the installer skill
2. **Authenticate** — auto-detects CLI token or prompts for paste
3. **Personalize** — pulls your health data via MCP and writes workspace memory files
4. **Use** — ask "How did I sleep?" and the workspace takes over
5. **Stay current** — heartbeat auto-refreshes your data every morning

## Partner Cloning

Partners can create branded workspaces for their communities:

```bash
bin/clone-workspace.sh recovery barrys-recovery \
  --identity "Barry's Recovery Specialist" \
  --soul "High-energy but recovery-focused"
```

## Three Access Paths

BetterClaw OS is one of three ways to access Betterness health intelligence:

```
@betterness/cli              MCP Server                    BetterClaw OS
(terminal power users)       (AI agents)                   (autonomous workspaces)
─────────────────            ──────────                    ─────────────
betterness sleep get         tools/call: getSleepData      "How did I sleep?"
betterness workflow ...      tools/call: getProfileStats   Morning heartbeat auto-runs

npm i -g @betterness/cli    Add to MCP config             claw workspace install
betterness auth login        Bearer bk_*                   betterness/recovery
```

All three access the same health data through the same backend.

## BetterClaw OS Principles

- One cohesive workspace, not disconnected tabs
- Action over observation
- Betterness-native health intelligence
- OpenClaw-native primitives: workspace files, skills, heartbeat, cron, calendar, channels, canvas
- Premium Betterness branding with quiet but clear attribution

## Next Step

Start with [START-HERE.md](./START-HERE.md).
