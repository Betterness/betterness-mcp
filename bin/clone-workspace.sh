#!/usr/bin/env bash
set -euo pipefail

# clone-workspace.sh — Clone the recovery template into a new BetterClaw OS workspace
#
# Workspace structure cloned from recovery/:
#
#   <workspace>/
#   ├── AGENTS.md              # Agent behavior and specialist activation
#   ├── SOUL.md                # Voice, tone, and communication style
#   ├── IDENTITY.md            # Purpose and target users
#   ├── MEMORY.md              # Local memory + Betterness Graph strategy
#   ├── WORKSPACE.md           # Home view, modules, interaction model
#   ├── HEARTBEAT.md           # Automated morning/evening/weekly loops
#   ├── PLANNING-MODE.md       # Deep reasoning mode
#   ├── ANTI-PATTERNS.md       # What the workspace must never become
#   ├── README.md              # Workspace overview
#   ├── .gitignore             # Credentials + personalized data
#   ├── skills/
#   │   ├── install.md         # Magic moment installer
#   │   ├── refresh.md         # Daily health data refresh
#   │   ├── recovery-verdict.md
#   │   └── sleep-analysis.md
#   ├── memory/                # Populated by installer
#   ├── modules/               # Contextual modules
#   └── tests/fixtures/        # MCP response fixtures

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$ROOT_DIR/starters/betterclaw-os/recovery"
BASE_DIR="$ROOT_DIR/starters/betterclaw-os"

usage() {
  echo "Usage: $0 <workspace-name> [--config <config-file>]"
  echo ""
  echo "Examples:"
  echo "  $0 barrys-studio"
  echo "  $0 barrys-studio --config partners/barrys.yaml"
  exit 1
}

# --- Parse arguments ---
[[ $# -lt 1 ]] && usage
WORKSPACE_NAME="$1"
CONFIG_FILE=""
shift
while [[ $# -gt 0 ]]; do
  case "$1" in
    --config) CONFIG_FILE="${2:-}"; [[ -z "$CONFIG_FILE" ]] && usage; shift 2 ;;
    *) usage ;;
  esac
done

# --- Validate workspace name (lowercase, hyphens, numbers only) ---
if [[ ! "$WORKSPACE_NAME" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo "Error: Workspace name must be lowercase letters, numbers, and hyphens only." >&2
  exit 1
fi

# --- Validate template exists ---
if [[ ! -d "$TEMPLATE_DIR" ]]; then
  echo "Error: Template directory not found: $TEMPLATE_DIR" >&2
  exit 1
fi

# --- Prevent overwrite ---
TARGET_DIR="$BASE_DIR/$WORKSPACE_NAME"
if [[ -d "$TARGET_DIR" ]]; then
  echo "Error: Workspace already exists: $TARGET_DIR" >&2
  exit 1
fi

# --- Validate config file if specified ---
if [[ -n "$CONFIG_FILE" && ! -f "$CONFIG_FILE" ]]; then
  echo "Error: Config file not found: $CONFIG_FILE" >&2
  exit 1
fi

# --- Title case helper (e.g., barrys-studio -> Barrys Studio) ---
title_case() {
  echo "$1" | tr '-' ' ' | sed 's/\b\(.\)/\u\1/g'
}
DISPLAY_NAME="$(title_case "$WORKSPACE_NAME")"

# --- Copy template ---
echo "Cloning recovery template to $WORKSPACE_NAME..."
cp -r "$TEMPLATE_DIR" "$TARGET_DIR"

# --- Customize files ---
if [[ -n "$CONFIG_FILE" ]]; then
  # Config-based customization: read simple key: value pairs
  # Supported keys: soul, identity, agents, readme_title, readme_description
  while IFS=': ' read -r key value; do
    [[ -z "$key" || "$key" == \#* ]] && continue
    value="${value#\"}" ; value="${value%\"}"
    case "$key" in
      soul)               [[ -f "$value" ]] && cp "$value" "$TARGET_DIR/SOUL.md" ;;
      identity)           [[ -f "$value" ]] && cp "$value" "$TARGET_DIR/IDENTITY.md" ;;
      agents)             [[ -f "$value" ]] && cp "$value" "$TARGET_DIR/AGENTS.md" ;;
      readme_title)       sed -i '' "s/^# Recovery Operator/# $value/" "$TARGET_DIR/README.md" ;;
      readme_description) sed -i '' "s/sleep, stress, and nervous system recovery/$value/" "$TARGET_DIR/README.md" ;;
    esac
  done < "$CONFIG_FILE"
  find "$TARGET_DIR" -name '*.md' -exec sed -i '' "s/Recovery Operator/$DISPLAY_NAME Operator/g" {} +
else
  # No config — replace name and add TODO markers
  find "$TARGET_DIR" -name '*.md' -exec sed -i '' "s/Recovery Operator/$DISPLAY_NAME Operator/g" {} +
  for f in SOUL.md IDENTITY.md AGENTS.md; do
    if [[ -f "$TARGET_DIR/$f" ]]; then
      printf '%s\n%s\n' "<!-- TODO: Customize this file for $WORKSPACE_NAME -->" "$(cat "$TARGET_DIR/$f")" > "$TARGET_DIR/$f"
    fi
  done
fi

cat <<EOF

✅ Created workspace: starters/betterclaw-os/$WORKSPACE_NAME/

Files to customize:
  - SOUL.md — voice and personality
  - IDENTITY.md — purpose and target users
  - AGENTS.md — specialist roles
  - README.md — workspace description
  - skills/ — task-specific skills
  - modules/ — contextual modules

Install: claw workspace install betterness/$WORKSPACE_NAME
EOF
