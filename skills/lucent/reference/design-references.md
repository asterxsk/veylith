# Design references

Reference material for what the design should be, as distinct from what it is built from.

Three layers here, and they do different jobs:

| Layer | Answers | Where |
|---|---|---|
| **DESIGN.md catalogue** | What are this brand's concrete tokens? | this file |
| **Galleries** | What should this kind of section look like? | [design-galleries.md](design-galleries.md) |
| **Design systems** | What is it built from? | [design-systems.md](design-systems.md) |

Optional companion skills — impeccable, design-taste-frontend, web-design-guidelines, poise — are
not required and not assumed. Their install commands and what each adds are in
[handoffs.md](handoffs.md).

## The DESIGN.md catalogue

[awesome-design-md](https://github.com/VoltAgent/awesome-design-md) (MIT) is 74 markdown design
systems reverse-engineered from real sites, each with a `preview.html` and `preview-dark.html`.

```
airbnb  airtable  apple  binance  bmw  bmw-m  bugatti  cal  claude  clay
clickhouse  cohere  coinbase  composio  cursor  dell-1996  elevenlabs  expo
ferrari  figma  framer  hashicorp  hp  ibm  intercom  kraken  lamborghini
linear.app  lovable  mastercard  meta  minimax  mintlify  miro  mistral.ai
mongodb  nike  nintendo-2001  notion  nvidia  ollama  opencode.ai  pinterest
playstation  posthog  raycast  renault  replicate  resend  revolut  runwayml
sanity  sentry  shopify  slack  spacex  spotify  starbucks  stripe  supabase
superhuman  tesla  theverge  together.ai  uber  vercel  vodafone  voltagent
warp  webflow  wired  wise  x.ai  zapier
```

Each file carries a frontmatter token block plus nine sections: Visual Theme and Atmosphere;
Color Palette and Roles; Typography Rules; Component Stylings; Layout Principles; Depth and
Elevation; Do's and Don'ts; Responsive Behavior; Agent Prompt Guide.

**Use it when** the brief names a brand or an obvious reference point ("like Stripe",
"Linear-clean", "Apple-y") and you need concrete values rather than a vibe.

**Do not use it when** the brief has its own brand. The catalogue is reference material, not an
identity.

It is not a skill and it is not installable. Clone it and read a single file:

```bash
git clone --depth 1 https://github.com/VoltAgent/awesome-design-md
```

Or fetch one brand directly:

```
https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/design-md/<brand>/DESIGN.md
```

### The honesty rule

This catalogue describes other companies' visible identities, derived from their public CSS. Do
not copy a brand's system wholesale and ship it as the user's design, and do not present an
analysed token set as official brand documentation. Read it for structure, calibration, and the
shape of a good design document — then derive the palette and type from the user's own brand.

When a system genuinely *is* the brief, use the official package instead: Fluent, Carbon,
Primer, Spectrum, GOV.UK, USWDS, or the design system the brand actually ships. That list is in
[design-systems.md](design-systems.md).

## How the layers sequence

1. **Direction** — the three dials, the mode, the refusals. [direction.md](direction.md)
2. **Substrate** — one design system, detected or chosen. [design-systems.md](design-systems.md)
3. **Section shape** — [design-galleries.md](design-galleries.md), when the container is not
   settled.
4. **Tokens** — the DESIGN.md catalogue, when a named reference needs concrete values.
5. **Pre-built** — [ui-registries.md](ui-registries.md), when an effect already ships as code.
6. **Fundamentals** — [fundamentals.md](fundamentals.md)
7. **Audit** — [audit.md](audit.md). One batched pass, then stop.

Steps 3, 4, and 5 are optional and conditional. Steps 1, 2, 6, and 7 are not.
