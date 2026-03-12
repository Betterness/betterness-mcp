# BetterClaw OS Design Reference — Cards

## Purpose

This file documents the card patterns BetterClaw OS packages should follow to remain visually consistent with the Betterness site.

## Canonical Card Styles

From [src/app/globals.css](/Users/demianbellumio/Desktop/betterness-v2/src/app/globals.css):

### Dark cards

`.bn-card-dark`

- background: `#161616`
- border: `1px solid #333333`
- radius: `14px`
- hover: background lifts to `#1C1C1C`

### Light cards

`.bn-card-light`

- background: `#FFFFFF`
- border: `1px solid #E5E5E5`
- radius: `14px`
- box shadow: subtle
- hover: light gray lift plus slightly deeper shadow

### Tinted dark variants

- `.bn-card-green`
- `.bn-card-yellow`
- `.bn-card-pink`

These add restrained tinted surfaces for emphasis.

## BetterClaw OS Card Types

### 1. Home card

The main daily verdict surface.

Rules:
- must answer status + why + what to do
- should be the first visual anchor of the workspace
- can use a subtle 1px prismatic bottom border

### 2. Module card

A self-contained action or insight surface.

Rules:
- consistent footprint inside the module rail
- title, short explanation, one primary action or state
- optional attribution chip at the bottom

### 3. Specialist overlay card

A focused expert view within the same workspace.

Rules:
- feels like an elevated layer, not a separate app
- can use a slightly stronger accent treatment
- should never break workspace cohesion

### 4. Listing / provider / product card

A real-world action card.

Rules:
- lead with usefulness and fit
- show why this result is relevant
- keep attribution subtle

## Usage Rules

### Do

- use consistent radius and border logic
- make hover states quiet and premium
- keep card content hierarchical, not crowded
- use tinted variants for states, not as the default everywhere

### Do Not

- do not stack too many nested cards
- do not use oversized shadows or glassmorphism
- do not overuse prismatic treatment on every card
- do not mix unrelated corner radii or border styles

## BetterClaw OS Package Usage

- **Recovery**: verdict card + module rail + occasional red/amber/green state cards
- **Biohacker Lab**: ranked biomarker change cards + action cards
- **Road Cycling**: readiness, route, and weather cards
- **Barry's / Studio**: next class + readiness + nearby choices
