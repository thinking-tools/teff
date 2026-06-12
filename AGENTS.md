# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this is

`teff` is an ultra-lightweight semantic UI library shipping two independent artifacts: `teff.min.css` (styles plain semantic HTML) and `teff.min.js` (vanilla Web Components + a `window.teff` global). No framework, no dependencies — do not add any. npm package: `@thinking.tools/teff`.

**`REFERENCE.md` is the complete API reference** — components, tokens, JS APIs, with canonical HTML for each. Read it before answering questions about usage or changing public surface.

## Build & verify

- `make dist` — build CSS + JS into `dist/`, print sizes (esbuild comes from devDependencies)
- `make clean` / `make css` / `make js` / `make size`
- There is **no test suite, lint, or typecheck**; `npm test` is a stub that exits 1. Verify changes by building and loading `index.html` in a browser.
- Releases are tag-driven: `make publish` injects the version from the latest git tag and publishes from `dist/`. Only the maintainer publishes (npm OTP).

## Architecture in one minute

- `src/css/` — plain CSS, concatenated in the fixed order of `CSS_FILES` in the `Makefile` (order matters), under cascade layers `theme, base, components, animations, utilities`. All colors/spacing flow through tokens in `01-theme.css` (`light-dark()`, `--space-*`, …) — never hardcode values.
- `src/js/` — ES modules bundled as an IIFE from `index.js`. Custom elements (`teff-tabs`, `teff-dropdown`) extend `TeffBase` (`base.js`) and enhance light-DOM markup in place — no Shadow DOM, no rendered markup. Document-level enhancements (tooltip, password, sidebar) attach global listeners. Imperative APIs (`teff.toast`, `teff.shake`) hang off `window.teff`.
- Each JS component file opens with a JSDoc block showing the expected HTML — keep it accurate.

## Keep docs in sync

When changing any public surface (markup contracts, classes/attributes, tokens, JS APIs), update in the same change:

1. `REFERENCE.md` — the canonical reference (also served as `llms-full.txt` on the docs site)
2. `teff.d.ts` and `custom-elements.json` — if the JS API changed
3. `index.html` — the live gallery demos every component

See `CLAUDE.md` for fuller architecture notes and UI-polish conventions.
