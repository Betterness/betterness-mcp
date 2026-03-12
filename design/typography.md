# BetterClaw OS Design Reference — Typography

## Purpose

This file documents the type system BetterClaw OS should inherit from Betterness.

## Canonical Font Families

From [tailwind.config.ts](/Users/demianbellumio/Desktop/betterness-v2/tailwind.config.ts):

- `font-display` → `"Neue Haas Grotesk Display Pro", "Helvetica Neue", Helvetica, Arial, sans-serif`
- `font-detail` → `"New Order", system-ui, sans-serif`
- `font-body` → `"Neue Haas Grotesk Text Pro", "Helvetica Neue", Helvetica, Arial, sans-serif`
- `font-mono` → `"JetBrains Mono", "Fira Code", monospace`

## Role of Each Font

- **Display**: package names, hero moments, flagship labels, major headings
- **Detail**: small premium accents, labels, identity treatments, selective utility text
- **Body**: all main reading surfaces, cards, explanations, prompts
- **Mono**: code, config, metrics where fixed-width improves clarity

## Recommended BetterClaw OS Scale

Derived from current Betterness site patterns and the builder strategy:

- Hero package title: `text-5xl sm:text-6xl lg:text-7xl`
- Workspace section title: `text-4xl sm:text-5xl`
- Major card title: `text-2xl sm:text-3xl`
- Module title: `text-xl sm:text-2xl`
- Body: `text-base sm:text-lg`
- Supporting text: `text-sm` to `text-base`
- Labels / metadata: `text-xs font-bold uppercase tracking-[0.2em]`

## Spacing Rhythm

Use a calm, premium rhythm:

- hero sections: `py-24 sm:py-32 lg:py-40`
- standard sections: `py-20 sm:py-28`
- compact reference sections: `py-12 sm:py-16`
- card padding: `p-6 sm:p-8`

## Usage Rules

### Do

- keep headlines short and decisive
- use display font for major identity surfaces
- use body font for most content
- let whitespace carry premium feel
- keep line length controlled on explanatory copy

### Do Not

- do not use decorative or novelty type
- do not mix too many font roles in a single module
- do not shrink important package names into generic UI text
- do not overuse all-caps beyond labels and micro-metadata

## BetterClaw OS Package Usage

- package `README.md` titles and flagship workspace names should use display-forward language
- home cards should feel editorial and premium, not operationally dense
- supporting module copy should remain clean and restrained
