# Create Your Own BetterClaw OS Workspace

Build a custom health workspace from scratch, or fork an existing one as a starting point.

## Quick Start: Fork an Existing Workspace

The fastest path is to clone the recovery template and customize it:

```bash
bin/clone-workspace.sh my-workspace
```

This copies the full recovery workspace structure and replaces the name. Then customize each file for your use case.

## Start From Scratch

### 1. Create the Directory Structure

```
my-workspace/
├── IDENTITY.md        # Who this workspace is for
├── SOUL.md            # Voice, tone, and communication style
├── WORKSPACE.md       # Home view layout and modules
├── AGENTS.md          # Agent behavior and specialist activation
├── MEMORY.md          # Memory strategy (what to remember, what to forget)
├── HEARTBEAT.md       # Automated loops (morning brief, evening review)
├── PLANNING-MODE.md   # Deep reasoning triggers
├── ANTI-PATTERNS.md   # What the workspace must never become
├── README.md          # Overview for users and contributors
├── .gitignore         # Exclude credentials and personalized data
├── skills/
│   ├── install.md     # Required: magic moment installer
│   └── ...            # Your custom skills
├── modules/
│   └── your-module/
│       └── README.md  # Module spec
├── memory/
│   └── README.md      # Memory file descriptions
└── tests/
    └── fixtures/      # MCP response fixtures for testing
```

### 2. Write IDENTITY.md

Define who this workspace serves and what makes it different:

```markdown
# My Workspace — Identity

## Tagline
**One sentence that captures the essence.**

## What This Workspace Is
[2-3 sentences describing the workspace]

## Who This Is For
- [Target user 1]
- [Target user 2]
- [Target user 3]

## What Makes This Different
1. It connects to your real data.
2. [Your differentiator]
3. [Your differentiator]
```

### 3. Write SOUL.md

Define the voice and personality:

```markdown
# My Workspace — Soul

## Voice
[How the workspace speaks — direct? warm? clinical? casual?]

## What It Sounds Like
- "Your HRV is trending up. Good day for intensity."
- [Example output in your voice]

## What It Never Sounds Like
- [Anti-example]
```

### 4. Write WORKSPACE.md

Define what the user sees when they open the workspace:

```markdown
# My Workspace — Workspace

## Home View
[What the user sees first. One cohesive surface, not a dashboard.]

### The Primary Card
[The first thing the user sees — a verdict, a status, a recommendation]

### Below the Primary Card
[Contextual modules that appear based on time, data, or user state]

### What Is NOT on the Home View
[Explicitly list what you're excluding to keep focus]
```

### 5. Write skills/install.md

The installer is the magic moment. It pulls the user's real data from Betterness MCP and personalizes the workspace. At minimum:

```markdown
# Install

## What This Skill Does
Personalizes this workspace with real health data from Betterness MCP.

## MCP Calls
- `getUserProfile` — name and preferences
- `getUserHealthData` — recent health metrics
- `listConnectedDevices` — wearable connections

## Steps
1. Validate MCP connection
2. Pull user data
3. Write personalized memory files
4. Show welcome message with real data
```

See `recovery/skills/install.md` for a comprehensive example with graceful degradation, animated output, and conversation starters.

### 6. Define Modules

Each module is a contextual view that appears based on conditions:

```
modules/
└── my-module/
    └── README.md
```

Module README should specify:
- **When it appears** (time of day, data condition, user state)
- **What it shows** (metrics, recommendations, actions)
- **What data it needs** (MCP tools, memory files)

### 7. Add to workspace.json

Register your workspace in the root `workspace.json`:

```json
{
  "betterness/my-workspace": {
    "path": "starters/betterclaw-os/my-workspace",
    "name": "My Workspace",
    "description": "One-line description.",
    "version": "1.0.0",
    "modules": 3,
    "skills": 2,
    "devices": ["Oura", "Apple Watch"]
  }
}
```

## Quality Bar

Before publishing, verify:

- [ ] `install.md` pulls real data and personalizes the workspace
- [ ] Home view answers one clear question (not a data dump)
- [ ] Modules appear contextually (not all at once)
- [ ] ANTI-PATTERNS.md lists at least 5 things this workspace must never become
- [ ] HEARTBEAT.md defines at least one automated loop
- [ ] Voice in SOUL.md is consistent and distinct
- [ ] README.md is understandable by someone who has never seen the code

## Examples

Study the existing workspaces for patterns:

| Workspace | Focus | Good Example Of |
|-----------|-------|-----------------|
| `recovery` | Sleep + HRV + readiness | Comprehensive installer, graceful degradation, test fixtures |
| `marathon` | Training + periodization | Sport-specific modules, race-week protocol |
| `biohacker-lab` | Biomarkers + protocols | Lab-centric modules, supplement tracking |
| `barrys-studio` | HIIT + studio classes | Partner-style workspace, class readiness |
| `road-cycling` | Power + route planning | Equipment tracking, zone management |

## Contributing

1. Fork the repo
2. Create your workspace in `starters/betterclaw-os/`
3. Add it to `workspace.json`
4. Open a PR with a description of who this workspace serves
