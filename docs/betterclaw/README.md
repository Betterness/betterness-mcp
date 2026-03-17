# BetterClaw OS

BetterClaw OS is the premium OpenClaw workspace layer for Betterness.

It gives builders and operators:

- one-command install that pulls your health data and personalizes everything
- flagship package starters for different user identities and goals
- Betterness-native design patterns and attribution rules
- OpenClaw-native structures such as workspace files, skills, heartbeat, cron, canvas, and channels

## Quick Start

```bash
claw workspace install betterness/recovery
```

This runs the [magic moment installer](../../starters/betterclaw-os/recovery/skills/install.md) — authenticates, pulls your data, personalizes the workspace, shows your health card, and starts the daily heartbeat.

## Start Here

If this is your first BetterClaw install:

1. Run `claw workspace install betterness/recovery`
2. Ask: **"How did I sleep?"**
3. Explore the [Start Here guide](../../starters/betterclaw-os/START-HERE.md) for deeper customization

## Flagship Packages

| Package | Focus | Install |
|---------|-------|---------|
| [Recovery](../../starters/betterclaw-os/recovery/README.md) | Sleep, stress, nervous system | `claw workspace install betterness/recovery` |
| [Marathon](../../starters/betterclaw-os/marathon/README.md) | Race training, tapering, fueling | Coming soon |
| [Biohacker Lab](../../starters/betterclaw-os/biohacker-lab/README.md) | Labs, supplements, protocols | Coming soon |
| [Road Cycling](../../starters/betterclaw-os/road-cycling/README.md) | Watts, zones, routes | Coming soon |
| [Barry's](../../starters/betterclaw-os/barrys-studio/README.md) | Studio recovery, class readiness | Coming soon |

## Partner Cloning

Partners can create branded workspace packages for their communities:

```bash
bin/clone-workspace.sh recovery barrys-recovery \
  --identity "Barry's Recovery Specialist" \
  --soul "High-energy but recovery-focused"
```

This copies the recovery structure, rewrites IDENTITY.md and SOUL.md, and generates a fresh README — giving partners a running start.

## Key Idea

BetterClaw OS should feel like the Betterness app translated into an OpenClaw-native workspace:

- calm
- premium
- action-oriented
- memory-aware
- useful in minutes

The public package system lives under [`starters/betterclaw-os/`](../../starters/betterclaw-os/).
