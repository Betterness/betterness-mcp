# Betterness CLI Reference

The Betterness CLI (`claw`) installs and manages BetterClaw OS workspaces — pre-built health environments powered by Betterness MCP.

## Installation

```bash
# Clone the repository
git clone https://github.com/Betterness/betterness-mcp.git
cd betterness-mcp

# Make the CLI executable
chmod +x bin/claw bin/claw-workspace-install bin/clone-workspace.sh
```

## Commands

### `claw workspace install`

Install a BetterClaw OS workspace package.

```bash
claw workspace install betterness/<package>
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `betterness/<package>` | Package name (e.g., `betterness/recovery`) |

**Options:**

| Option | Description |
|--------|-------------|
| `--key <API_KEY>` | Betterness MCP API key. Also reads from `BETTERNESS_API_KEY` env var. |
| `--dir <PATH>` | Custom workspace directory. Default: `~/.openclaw/workspaces/betterness-<package>` |

**Examples:**

```bash
# Install with API key
claw workspace install betterness/recovery --key sk-abc123

# Install using environment variable
export BETTERNESS_API_KEY=sk-abc123
claw workspace install betterness/recovery

# Install to a custom directory
claw workspace install betterness/marathon --dir ~/my-workspaces/marathon
```

**What it does:**

1. Copies workspace files (agents, skills, modules, memory) to the target directory
2. Writes `.mcp.json` with Betterness MCP endpoint and your API key
3. Reports the installed workspace with skill and module counts

**After install:**

```bash
cd ~/.openclaw/workspaces/betterness-recovery
claw start
```

### Available Packages

| Package | Description | Modules | Skills |
|---------|-------------|---------|--------|
| `betterness/recovery` | Sleep, HRV, and readiness gating | 5 | 4 |
| `betterness/marathon` | Training load, periodization, race prep | 7 | 2 |
| `betterness/road-cycling` | Power zones, route building, weekly load | 7 | 3 |
| `betterness/barrys-studio` | HIIT class readiness, intensity modulation | 6 | 2 |
| `betterness/biohacker-lab` | Biological age, protocols, supplement stacking | 7 | 2 |

### `clone-workspace.sh`

Clone the recovery template into a new custom workspace.

```bash
bin/clone-workspace.sh <workspace-name> [--config <config-file>]
```

**Arguments:**

| Argument | Description |
|----------|-------------|
| `<workspace-name>` | Lowercase, hyphens, numbers only (e.g., `yoga-studio`) |

**Options:**

| Option | Description |
|--------|-------------|
| `--config <file>` | YAML config file with customizations (soul, identity, agents) |

**Examples:**

```bash
# Create a new workspace from the recovery template
bin/clone-workspace.sh yoga-studio

# Create with a config file
bin/clone-workspace.sh yoga-studio --config partners/yoga.yaml
```

**Config file format:**

```yaml
soul: path/to/custom-SOUL.md
identity: path/to/custom-IDENTITY.md
agents: path/to/custom-AGENTS.md
readme_title: "Yoga Recovery"
readme_description: "flexibility, mobility, and breath-based recovery"
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `BETTERNESS_API_KEY` | Your Betterness MCP API key |
| `CLAW_WORKSPACE_DIR` | Override default workspace directory (default: `~/.openclaw/workspaces`) |

## Getting Your API Key

1. Go to [betterness.ai/dashboard](https://betterness.ai/dashboard)
2. Navigate to **MCP Keys**
3. Generate a new key
4. Pass it to `claw workspace install --key <KEY>` or set `BETTERNESS_API_KEY`

## Workspace Structure

After installation, your workspace contains:

```
betterness-recovery/
├── .mcp.json              # Betterness MCP connection config
├── AGENTS.md              # Agent behavior and specialist activation
├── SOUL.md                # Voice, tone, and communication style
├── IDENTITY.md            # Purpose and target users
├── WORKSPACE.md           # Home view, modules, interaction model
├── HEARTBEAT.md           # Automated morning/evening/weekly loops
├── PLANNING-MODE.md       # Deep reasoning mode
├── ANTI-PATTERNS.md       # What the workspace must never become
├── MEMORY.md              # Local memory + Betterness Graph strategy
├── skills/
│   ├── install.md         # Magic moment installer (personalizes workspace)
│   ├── refresh.md         # Daily health data refresh
│   └── ...                # Package-specific skills
├── modules/               # Contextual modules (shown based on time/data)
├── memory/                # Populated by installer with your health data
└── tests/fixtures/        # MCP response fixtures for testing
```

## Troubleshooting

**"Package not found"** — Run `claw workspace install` with no arguments to see available packages.

**"MCP connection failed"** — Check your API key is valid at [betterness.ai/dashboard](https://betterness.ai/dashboard). Ensure the `.mcp.json` file has the correct bearer token.

**"Permission denied"** — Run `chmod +x bin/claw bin/claw-workspace-install`.
