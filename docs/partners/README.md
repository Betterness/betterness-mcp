# Betterness Partners

Betterness supports partner experiences across studios, clinics, wellness brands, and community ecosystems.

## Partner Workspace Cloning

Partners can create branded BetterClaw OS workspaces for their communities using the clone tool:

```bash
bin/clone-workspace.sh recovery barrys-recovery \
  --identity "Barry's Recovery Specialist" \
  --soul "High-energy but recovery-focused"
```

This copies the recovery package structure, rewrites IDENTITY.md and SOUL.md with partner branding, and generates a fresh README. The result is a fully functional workspace package that partners can distribute to their members.

### How It Works

1. **Choose a base package** — start from `recovery`, `marathon`, `biohacker-lab`, `road-cycling`, or `barrys-studio`
2. **Run the clone tool** — set identity, soul, and optionally modules to include/exclude
3. **Customize** — edit the generated workspace files to match partner voice and priorities
4. **Distribute** — partners give their members the install command:

```bash
claw workspace install partnername/package-name
```

Members authenticate with their own Betterness token and get a personalized workspace with the partner's branding and focus.

## What This Covers

- Partner integration patterns
- Booking and access rails
- Smart Listings alignment
- Branded Betterness-powered experiences
- BetterClaw OS workspace cloning and distribution

## Guiding Principle

Users should be able to carry their health and wellness context across Betterness-powered experiences without having to re-teach each system who they are.

That means partner experiences should feel:

- personalized
- portable
- action-oriented
- connected to the broader Betterness platform
