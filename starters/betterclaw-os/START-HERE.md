# Start Here

If this is your first BetterClaw OS install, start with **Recovery**.

Recovery is the easiest package to understand, the broadest in usefulness, and the best template for the rest of the system.

## One-Command Install (Recommended)

```bash
claw workspace install betterness/recovery
```

This runs the [magic moment installer](./recovery/skills/install.md) which:

1. **Authenticates** — auto-detects your Betterness CLI token, or prompts you to paste one
2. **Pulls your data** — 7 MCP calls in parallel (profile, devices, health, labs, bio age, flagged markers, biomarkers)
3. **Personalizes your workspace** — writes memory files with YOUR data (devices, health snapshot, preferences)
4. **Shows your health card** — animated reveal of recovery status, device sync, flagged markers, HRV sparkline
5. **Runs smoke tests** — verifies MCP connection, data freshness, and workspace integrity
6. **Creates your birth certificate** — snapshots install-time data for tracking progress over time
7. **Starts your heartbeat** — morning auto-refresh so your data stays current

After install, just ask: **"How did I sleep?"** and Recovery Operator takes over.

## Partner Cloning

Partners can create pre-configured workspaces for their communities:

```bash
bin/clone-workspace.sh recovery barrys-recovery \
  --identity "Barry's Recovery Specialist" \
  --soul "High-energy but recovery-focused"
```

See [clone-workspace.sh](../../bin/clone-workspace.sh) for the full tool.

## Manual Setup (Fallback)

<details>
<summary>Click to expand manual setup steps</summary>

1. Copy the recovery package into your OpenClaw workspace:
```bash
cp -r starters/betterclaw-os/recovery/ ~/your-workspace/
```

2. Connect Betterness MCP at `https://api.betterness.ai/mcp`
3. Read the workspace files in this order:
   - `README.md`
   - `WORKSPACE.md`
   - `SOUL.md`
   - `PLANNING-MODE.md`
   - `ANTI-PATTERNS.md`
   - `WHAT-BETTER-LOOKS-LIKE.md`
4. Build one cohesive home view with:
   - today's health state
   - one primary action
   - key changes that matter
   - upcoming labs, providers, or listings actions
   - relevant specialist support

</details>

## Important Rules

- Do not create disconnected tabs as the default experience
- Do not build generic admin UI
- Prefer action over analysis
- Keep orchestration mostly hidden
- Make the workspace feel calm, premium, and unmistakably Betterness

## Flagship Packages

| Package | Focus | Install |
|---------|-------|---------|
| [Recovery](./recovery/README.md) | Sleep, stress, nervous system | `claw workspace install betterness/recovery` |
| [Marathon](./marathon/README.md) | Race training, tapering, fueling | Coming soon |
| [Biohacker Lab](./biohacker-lab/README.md) | Labs, supplements, protocols | Coming soon |
| [Road Cycling](./road-cycling/README.md) | Watts, zones, routes | Coming soon |
| [Barry's](./barrys-studio/README.md) | Studio recovery, class readiness | Coming soon |
