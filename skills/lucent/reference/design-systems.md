# Design systems

A design system is the **substrate**: tokens, components, accessibility behaviour, and the
conventions a project builds on. It is not the design. Two projects on shadcn should not look
alike; two projects on the same system absolutely should behave alike.

Two rules govern this file:

1. **Exactly one system per project.**
2. **Detect before choosing.** Never introduce a second one.

## Detect first

Read these before recommending anything:

| Look at | Tells you |
|---|---|
| `package.json` dependencies | The system already in use |
| `components.json` | shadcn/ui is configured (with its base and registry) |
| `tailwind.config.*` / `@import "tailwindcss"` | Tailwind version — v4 is CSS-first, v3 is JS config |
| `postcss.config.*` | Tailwind pipeline, or Mantine's preset |
| `app.css` / `globals.css` imports | Which system's stylesheet is loaded |
| Existing component imports | The real system, regardless of what the manifest says |

If a system is present, **use it**. Adding a second kit means two token systems, two focus
rings, two button APIs, and a page that looks like two products stitched together. If the
existing system genuinely cannot do the job, say so explicitly and propose a migration — do not
quietly add a second.

## Decision tree

Answer in order; stop at the first match.

```
Is there a system already installed?          → use it, stop.
Is the stack not React?                       → daisyUI (any framework, CSS only) or author CSS.
Is the project on Tailwind v4 + React 19?      → shadcn/ui or HeroUI.
Is the project on React without Tailwind?      → Mantine.
Is the brief "own our design system"?          → Base UI or Radix Primitives, authored.
Is a11y audited, with dates/number fields?     → React Aria Components.
Is a named brand the brief (Material, IBM,
  Microsoft, GitHub, Adobe, Shopify)?          → the matching system, if the brand is real.
Nothing fits                                  → shadcn/ui on a new project; author CSS on an old one.
```

## Core set (React)

| System | Choose it when | Stack | Styling | Licence |
|---|---|---|---|---|
| **shadcn/ui** (CLI 4.x) | You want to own the source. The default for a new React + Tailwind project | React, Tailwind v4 | Tailwind, CSS variables; Base UI base by default, Radix or React Aria selectable | MIT |
| **HeroUI** (v3.2) | You want polished components without owning them, and accessible by construction | React 19, Tailwind v4 | `@heroui/styles` CSS + OKLCH variables; React Aria Components | MIT |
| **Mantine** (v9) | React without Tailwind, or a full kit — forms, dates, notifications, charts | React | CSS modules, PostCSS preset, no runtime injection | MIT |
| **Base UI** (v1.x) | You are authoring the design system and need behaviour, not looks | React | Unstyled | MIT |
| **Radix Primitives** (v1.x) | Same, on the other headless foundation. One `radix-ui` package | React | Unstyled | MIT |
| **React Aria Components** (v1.21) | Accessibility is audited rather than assumed; date and number fields are in scope | React | Unstyled | Apache-2.0 |
| **daisyUI** (v5) | Not React, or no build step for behaviour. Themes any markup | Any | Tailwind plugin, semantic classes, no JS | MIT |

### Why these seven

- **shadcn/ui** is the only entry where the component is yours. No upgrade can remove a variant.
  The cost is that you own the maintenance.
- **HeroUI** is the fastest route to a professional-looking, accessible React surface. React Aria
  underneath means comboboxes, date pickers, and i18n are correct rather than approximated.
- **Mantine** is the best full kit without Tailwind, and the only one here with no runtime style
  injection at all — which matters for the Next.js App Router.
- **Base UI** and **Radix** are the two headless foundations shadcn builds on. Listed separately
  because "author your own system" is a real brief that the styled kits do not serve.
- **React Aria Components** is the deepest accessibility work in React and the only set that
  attempts date and number fields properly.
- **daisyUI** is the only CSS-only option, and therefore the only one that works when there is no
  React or no JS behaviour requirement.

## Named-brief set

Use only when the brand *is* the brief, or the organisation already runs the system. Never as
decoration, and never as "it looks nice."

| System | Use when | Stack | Licence |
|---|---|---|---|
| **Material UI** v9 | Material is the brief, or MUI X's data grid is the product | React, Emotion | MIT; MUI X advanced features paid |
| **IBM Carbon** v11 | Enterprise data console, IBM-adjacent | React, Sass, tokens; web components too | Apache-2.0 |
| **Fluent UI React** v9 | Microsoft brand, M365-adjacent product | React, Griffel CSS-in-JS | MIT (fonts/icons under asset terms) |
| **GitHub Primer** v38 | The product should look and behave like GitHub | React, CSS + primitives | MIT |
| **React Spectrum** S2 | Adobe-adjacent, or Spectrum's token vocabulary fits | React | Apache-2.0 |
| **Shopify Polaris** | Shopify embedded app — use the **web components**, not the archived Polaris React | Web components, App Bridge | Shopify terms |
| **Ant Design** v6 | Dense admin console, and looking like an Ant console is acceptable | React | MIT |

Two traps in that table: **Polaris React is archived and deprecated** — new Shopify work uses
Polaris web components. And **Fluent UI v9 (`@fluentui/react-components`) is a different library
from v8 (`@fluentui/react`)**, which still fills search results.

## Comparison

| System | Runtime style | A11y base | Breadth | Agent tooling | Exit cost |
|---|---|---|---|---|---|
| shadcn/ui | None (Tailwind) | Base UI / Radix / React Aria | Medium | CLI + MCP + registry | Low — you own the code |
| HeroUI | None (CSS) | React Aria Components | Broad (75+) | MCP, `llms.txt`, agent skills | Medium |
| Mantine | None (CSS modules) | Own | Very broad (120+) | MCP, `llms.txt` | High — deep ecosystem coupling |
| Base UI | None (BYO) | Own | Primitives | — | Low |
| Radix | None (BYO) | Own | Primitives | — | Low |
| React Aria | None (BYO) | Own, deepest | Primitives | — | Low |
| daisyUI | None (pure CSS) | None — you wire it | Broad classes | MCP, agent skill | Low |
| MUI | Emotion | Own | Very broad | — | High |
| Carbon | Sass | Own | Broad | MCP server | High |
| Primer | CSS | Own | Medium, GitHub-shaped | MCP server | High |

**Exit cost** is how much of your code stops working if you leave. It is the column that decides
most new projects: ownership (shadcn) trades maintenance for portability, and the enterprise kits
trade portability for breadth.

## Setup, per system

### shadcn/ui

```bash
npx shadcn@latest init          # picks base (Base UI by default), writes components.json
npx shadcn@latest add button dialog table
```

- Components are copied into the repo. They are yours: edit them.
- Theming is CSS variables in `globals.css`, consumed by Tailwind utilities.
- Choose the base deliberately: `--base radix` if the project already uses Radix, `--base aria`
  if accessibility is the driver.
- Third-party registries plug in through `components.json` → `registries` (see
  [ui-registries.md](ui-registries.md)).

### HeroUI

```bash
npm i @heroui/styles @heroui/react
```

```css
@import "tailwindcss";
@import "@heroui/styles";
```

- React 19+ and Tailwind v4 required. No provider component.
- Compound API: `Card.Header`, `Select.Item`.
- Theming is CSS variables in OKLCH plus BEM class names for deep overrides.
- v2 and v3 cannot coexist. If the project is on v2, migrate or stay.
- Its docs FAQ has said Apache-2.0 while the repo and npm say MIT — **verify the licence on the
  version you install** rather than citing either.

### Mantine

```bash
npm i @mantine/core @mantine/hooks
```

```tsx
import '@mantine/core/styles.css'
import { MantineProvider } from '@mantine/core'
```

- Add modules only when needed: `@mantine/form`, `@mantine/dates`, `@mantine/notifications`,
  `@mantine/charts`. Each is a dependency; do not install the set "just in case."
- Styling is CSS modules with a PostCSS preset. Theme overrides go through the `theme` prop, not
  through ad-hoc CSS.

### Base UI / Radix

```bash
npm i @base-ui/react          # or: npm i radix-ui
```

- Unstyled. You supply every pixel, including focus states.
- This is the right base when the brief is "we are building our own system." It is the wrong base
  when the brief is "build this page."

### React Aria Components

```bash
npm i react-aria-components
```

- Unstyled, like the others, with the deepest keyboard, focus, and i18n behaviour.
- Reach for it when training a real system, or when the product has date pickers, number
  fields, or RTL requirements that the other primitives handle less completely.

### daisyUI

```css
@import "tailwindcss";
@plugin "daisyui";
```

- Pure CSS with semantic class names. No JS, so focus traps, menus, and dialogs are yours.
- Themes are declared with `@plugin "daisyui/theme" { ... }`.
- Right for non-React stacks, server-rendered pages, and documents.

## Theming discipline

A stock theme is visible from across the room. Whatever the system, do this:

- **Derive tokens from the brief, not from the kit.** Three or four decisions — accent, neutral
  temperature, radius scale, type pairing — distinguish a themed surface from a default one.
- **One radius scale.** A kit mixing 4px buttons with 16px cards reads as unfinished. Pick one
  scale (0, 2, 4, 8, 12, 16) and use only it.
- **Semantic names.** `--surface`, `--surface-raised`, `--text`, `--text-muted`, `--border`,
  `--accent`. Never `--gray-100` in component code.
- **Dark mode is a swap of the same token names**, defined and tested — not an inversion, and not
  a lightened background with unchanged text.
- **Do not override a component's internals** from outside the system. If shadcn's `Button` is
  wrong, edit the copied component. If HeroUI's is wrong, use its documented slots or BEM
  classes. A CSS selector reaching into another library's DOM is a break waiting for a release.
- **Never ship two focus treatments.** Pick the system's ring and use it everywhere, including on
  your own custom components.

## How the four reference layers relate

They answer different questions and are used in this order:

| Layer | Question | File |
|---|---|---|
| **Galleries** | What should this section *look* like? | [design-galleries.md](design-galleries.md) |
| **Design system** | What is it built *from*? | this file |
| **Registries** | Does this specific effect already exist as code? | [ui-registries.md](ui-registries.md) |
| **DESIGN.md catalogue** | What are this brand's concrete tokens? | [design-references.md](design-references.md) |

Galleries publish screenshots and no code. The design system publishes code and no direction.
Registries publish copy-paste components for one effect each. The catalogue publishes analysed
tokens for other companies' identities. None substitutes for another, and buying a gallery's look
means re-deriving it in your own substrate — not copying its CSS.

## Verifying the choice

Before writing component code:

- [ ] Nothing already installed was ignored.
- [ ] Only one system is present.
- [ ] The version is the current major, and its peer requirements match the project (React
      major, Tailwind major).
- [ ] The licence permits the intended use, checked on the version being installed.
- [ ] A theme is derived, not left stock.
- [ ] The system's own focus and state conventions are used, not reinvented.
