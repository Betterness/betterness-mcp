# BetterClaw OS Design Reference — Colors

## Purpose

This file documents the canonical Betterness color system for BetterClaw OS packages. Use these tokens when building workspace shells, cards, modules, chips, and attribution surfaces.

## Core Tokens

From [tailwind.config.ts](/Users/demianbellumio/Desktop/betterness-v2/tailwind.config.ts) and [src/app/globals.css](/Users/demianbellumio/Desktop/betterness-v2/src/app/globals.css):

### Dark surface tokens

- `bn-bg` → base dark background (`--bn-bg`: `0 0 0`)
- `bn-bg-secondary` → raised dark background (`17 17 17`)
- `bn-bg-tertiary` → tertiary dark background (`26 26 26`)
- `bn-border` → standard dark border (`51 51 51`)
- `bn-card-bg` → dark card background (`22 22 22`)
- `bn-card-border` → dark card border (`51 51 51`)

### Text tokens

- `bn-text` → primary text on dark (`255 255 255`)
- `bn-text-secondary` → secondary text on dark (`160 161 160`)

### Accent tokens

- `bn-green` → primary positive accent (`117 250 121`)
- `bn-yellow` → secondary accent / caution (`245 198 72`)
- `bn-pink` → tertiary accent / premium signal (`239 147 248`)
- `bn-red` → negative / risk accent (`239 68 68`)

### Light section tokens

- `bn-light-bg` → white section background
- `bn-light-bg-alt` → alternate light section background
- `bn-light-headline` → headline color for light sections
- `bn-light-body` → body text color for light sections
- `bn-light-secondary` → secondary text color for light sections

## Prismatic Gradient

Betterness uses a single prismatic gradient:

`linear-gradient(90deg, #75FA79, #F5C648, #EF93F8)`

Available utilities from globals:

- `.bn-prismatic`
- `.bn-prismatic-text`
- `.bn-prismatic-border`
- `.bn-prismatic-animated`

## Usage Rules

### Do

- use `bn-bg*`, `bn-border`, and `bn-text*` for foundational workspace surfaces
- use `bn-green`, `bn-yellow`, `bn-pink`, and `bn-red` as accents, not full-page fills
- use the prismatic gradient for premium CTAs, confirmation moments, and subtle branded accents
- keep BetterClaw OS workspaces mostly calm and dark, with accents doing the emotional work

### Do Not

- do not replace base workspace backgrounds with full prismatic gradients
- do not use raw hex values when a `bn-*` token exists
- do not use multiple different gradients in the same package
- do not put high-saturation accent backgrounds behind large bodies of text

## BetterClaw OS Package Usage

- **Home card**: dark surface with one subtle accent state
- **Module rail**: dark cards with thin accent borders or chips
- **Specialist overlays**: mostly dark, with role-specific accent tinting
- **Powered by Betterness**: muted text plus a small prismatic rule or mark

## Examples

### Good

- dark workspace shell with `bn-bg`, `bn-card-bg`, `bn-border`, and `bn-text-secondary`
- green, yellow, or red verdict state chips layered onto a dark card
- a 1px prismatic bottom rule on a daily briefing card

### Bad

- a full prismatic module background
- a rainbow-heavy home screen
- mixing Betterness tokens with unrelated brand palettes
