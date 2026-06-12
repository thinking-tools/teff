# teff — complete reference

> teff is an ultra-lightweight semantic UI library: one CSS file (~9 kB gzip) and one JS file (~3 kB gzip), independently usable. The CSS styles plain semantic HTML — no framework, no build step, no dependencies, dark mode built in. The JS adds two custom elements, a few automatic enhancements, and two imperative APIs on the `teff` global.

This file is the canonical, self-contained API reference. Every snippet is copy-paste ready.

- npm package: `@thinking.tools/teff`
- Source: https://codeberg.org/thinking_tools/teff
- Live gallery: https://thinking_tools.codeberg.page/teff/

## Install

CDN (no build step):

```html
<link rel="stylesheet" href="https://unpkg.com/@thinking.tools/teff/teff.min.css" />
<script src="https://unpkg.com/@thinking.tools/teff/teff.min.js"></script>
```

npm + bundler:

```sh
npm install @thinking.tools/teff
```

```js
// once, in your app entry
import "@thinking.tools/teff/teff.min.css";
import "@thinking.tools/teff"; // optional: registers the custom elements + the `teff` global
```

The two files are independent: the CSS works without the JS (everything degrades to functional native HTML), and the JS works without the CSS.

## Core principles

1. **Semantic HTML first.** Write native elements (`<button>`, `<dialog>`, `<details>`, `<progress>`); they are styled out of the box. Class names and `data-*` attributes only refine.
2. **Variants via `data-variant`**, styles/sizes via classes (`.outline`, `.ghost`, `.small`, `.large`).
3. **JS enhances existing markup.** Custom elements (`<teff-tabs>`, `<teff-dropdown>`) wrap your own ARIA markup and wire state, keyboard navigation, and ARIA attributes. No Shadow DOM, no rendered markup.
4. **Everything themes through CSS custom properties** with `light-dark()` — never hardcode colors.

## Theming

Set presets as attributes on `<html>` (all optional, all combinable):

```html
<html data-theme="dark" data-accent="blue" data-radius="soft" data-density="compact">
```

| Attribute | Values | Default (attribute absent) |
|---|---|---|
| `data-theme` | `light`, `dark` | follows OS (`color-scheme: light dark`) |
| `data-accent` | `blue`, `teal`, `green`, `orange`, `red`, `wine`, `navy` | mono ink (neutral black/white primary) |
| `data-radius` | `soft`, `sharp` | fully rounded (pill buttons/fields) |
| `data-density` | `compact`, `comfortable` | 1.0 spacing scale |

Or override tokens directly:

```css
:root {
  --primary: light-dark(#2068c9, #7ab3ff); /* light value, dark value */
  --radius-button: 0.75rem;
}
```

### Design tokens (CSS custom properties on `:root`)

Colors — all defined with `light-dark(light, dark)`, so dark mode is automatic:

| Token | Purpose |
|---|---|
| `--background` / `--foreground` | page surface / text |
| `--card` / `--card-foreground` | elevated surface / its text |
| `--primary` / `--primary-foreground` | primary action; changed by `data-accent` |
| `--secondary` / `--secondary-foreground` | secondary action |
| `--muted` / `--muted-foreground` | subdued surface / subdued text |
| `--faint` / `--faint-foreground` | faintest surface / faintest text |
| `--accent` | hover/highlight surface |
| `--danger` / `--danger-foreground` | destructive |
| `--success` / `--success-foreground` | positive |
| `--warning` / `--warning-foreground` | cautionary |
| `--border`, `--input`, `--ring` | hairline borders, input borders, focus ring |
| `--logo-plum`, `--logo-red`, `--logo-orange`, `--logo-citron`, `--logo-green`, `--logo-pine`, `--logo-navy`, `--logo-blue`, `--logo-sky` | raw 9-stop logo palette |

Spacing — `--space-1` (0.25rem) through `--space-2/3/4/5/6/8/10/12/14/16/18` (4.5rem), each multiplied by `--density` (set by `data-density`).

Radius — `--radius-small` `--radius-medium` `--radius-large` `--radius-full`, plus `--radius-button` and `--radius-field` (pill by default; `data-radius` presets remap them).

Type — `--text-1` (largest, fluid `clamp()`) through `--text-8` (0.75rem); `--text-regular` = `--text-6` (1rem). `--font-sans`, `--font-mono`; weights `--font-normal/medium/semibold/bold`.

Shadows — `--shadow-ring` (1px hairline), `--shadow-small/medium/large` (layered ring + lift + ambient; adapt to dark mode automatically).

Motion — `--transition-fast` (120ms), `--transition` (200ms), `--ease-out`. Layers/z — `--z-dropdown: 50`, `--z-modal: 200`. Misc — `--bar-height` (progress/meter).

## Typography

Semantic HTML is styled with no classes: headings, `<p>`, `<a>`, `<strong>`, `<em>`, `<code>`, `<mark>`, `<small>`, `<kbd>`, `<del>`/`<ins>`, `<s>`, `<u>`, `<abbr>`, `<sub>`/`<sup>`, `<samp>`, `<blockquote>`, lists, `<hgroup>` (heading + subtitle), `<figure>`/`<figcaption>`.

```html
<hgroup>
  <h3>Heading</h3>
  <p>Subtitle text.</p>
</hgroup>

<dl data-grid>  <!-- definition list as a two-column grid -->
  <dt>Version</dt><dd>1.x</dd>
  <dt>License</dt><dd>MIT</dd>
</dl>
```

## Buttons

A plain `<button>` is the primary action. Links become buttons with `class="button"`.

```html
<button>Primary</button>
<button data-variant="secondary">Secondary</button>
<button data-variant="danger">Danger</button>
<button class="outline">Outline</button>
<button class="ghost">Ghost</button>
<button disabled>Disabled</button>
<a href="/docs" class="button">Link button</a>

<button class="small">Small</button>
<button class="large">Large</button>
<button class="icon" aria-label="Add"><svg>…</svg></button>  <!-- square icon button -->
<button><svg>…</svg> Download</button>                        <!-- icons inline just work -->
<button><span class="truncate">Very long label…</span></button>

<menu class="buttons">  <!-- fused button group -->
  <li><button data-variant="secondary">Left</button></li>
  <li><button data-variant="secondary">Middle</button></li>
  <li><button data-variant="secondary">Right</button></li>
</menu>
```

- `data-variant`: `secondary`, `danger` (default = primary).
- Classes: `.outline`, `.ghost` (combinable with variants), sizes `.small`/`.large`/`.icon`.
- `aria-busy="true"` on a button shows an inline spinner (see Spinner).

## Badges

```html
<span class="badge">Default</span>
<span class="badge" data-variant="secondary">Secondary</span>
<span class="badge" data-variant="success">Success</span>
<span class="badge" data-variant="warning">Warning</span>
<span class="badge" data-variant="danger">Danger</span>
<span class="badge outline">Outline</span>
```

## Avatars

```html
<figure data-variant="avatar" class="small">AB</figure>
<figure data-variant="avatar">CD</figure>
<figure data-variant="avatar" class="large">EF</figure>

<!-- stacked team: nest avatars -->
<figure data-variant="avatar" role="group" aria-label="Team">
  <figure data-variant="avatar">JK</figure>
  <figure data-variant="avatar">LM</figure>
</figure>
```

## Navigation

```html
<nav data-breadcrumbs aria-label="Breadcrumb">
  <ol>
    <li><a href="/">Home</a></li>
    <li><a href="/library">Library</a></li>
    <li aria-current="page">Current page</li>
  </ol>
</nav>

<nav data-menu aria-label="Section menu">
  <ul>
    <li><a href="/overview" aria-current="page">Overview</a></li>
    <li><a href="/reports">Reports</a></li>
  </ul>
</nav>
```

## Sidebar layout (app shell)

A grid shell: full-width top bar, collapsible sidebar, scrollable main. The JS wires `[data-sidebar-toggle]` to flip `data-sidebar-open` on the layout; on mobile (≤768px) the sidebar is an off-canvas drawer that auto-dismisses on outside click or link click.

```html
<div data-sidebar-layout="always">
  <nav data-topnav aria-label="Main">
    <button data-sidebar-toggle aria-label="Toggle sidebar"><svg>…</svg></button>
    <a href="/" class="brand">App</a>
  </nav>
  <aside data-sidebar>
    <nav aria-label="Sections">
      <p data-nav-label>Group label</p>
      <ul>
        <li><a href="/one" aria-current="page">One</a></li>
        <li><a href="/two">Two</a></li>
      </ul>
    </nav>
  </aside>
  <main>…scrollable content…</main>
</div>
```

- `data-sidebar-layout="always"` shows the collapse toggle on desktop too; bare `data-sidebar-layout` keeps the sidebar fixed on desktop.
- Inside `aside[data-sidebar]`: optional `> header` / `> footer`, and `> nav` with `[data-nav-label]` (or `h2`–`h6`) as group labels.
- `nav[data-topnav]` is sticky and also works standalone, outside the sidebar layout.

## Cards & grid

```html
<div class="row">  <!-- 12-column grid, stacks to 4 cols on mobile -->
  <article class="card col-6"><h3>Half width</h3></article>
  <article class="card col-6"><h3>Half width</h3></article>
</div>

<div class="autogrid" style="--autogrid-min: 8rem">  <!-- fits as many as space allows -->
  <div class="card">auto</div>
  <div class="card">auto</div>
</div>

<div class="container">centered, max-width content</div>
```

- Columns: `.col-1` … `.col-12`, offsets `.offset-1` … `.offset-6`, `.col-end` (push to end). Only meaningful as direct children of `.row`.
- Grid knobs: `--grid-gap`, `--autogrid-min`, `--container-max`, `--container-pad`.

## Forms

Native inputs, selects, checkboxes, radios, switches, ranges, file and search fields are styled directly — validation states included.

```html
<div data-field>
  <label for="name">Name</label>
  <input id="name" type="text" placeholder="Ada Lovelace" />
</div>

<div data-field="error">
  <label for="pw">Password</label>
  <input id="pw" type="password" aria-invalid="true" aria-describedby="pw-err" />
  <small class="error" id="pw-err">Too short — minimum 8 characters.</small>
</div>

<div data-field>
  <label for="role">Role</label>
  <select id="role"><option>Engineer</option></select>
</div>

<fieldset class="group">  <!-- fused prefix + input + button -->
  <legend>https://</legend>
  <input type="text" placeholder="your-site.com" aria-label="Website" />
  <button type="button">Go</button>
</fieldset>

<label><input type="checkbox" checked /> Checkbox</label>
<label><input type="radio" name="plan" checked /> Radio</label>
<label><input type="checkbox" role="switch" checked /> Toggle switch</label>
<input type="range" min="0" max="100" value="60" />

<search>
  <label for="q">Search</label>
  <input id="q" type="search" placeholder="Search…" />
</search>
```

- `data-field` wraps label + control + hints; `data-field="error"` tints the field.
- With the JS bundle, `<input type="password">` automatically gets a show/hide toggle. Opt out per input with `data-static`. (Inputs inside `fieldset.group` are skipped.)

## Tables

```html
<div class="table" tabindex="0" role="region" aria-label="Results table">
  <table>
    <caption>Bundle breakdown</caption>
    <thead><tr><th>Component</th><th>Size</th></tr></thead>
    <tbody><tr><td>Tabs</td><td>0.9 kB</td></tr></tbody>
    <tfoot><tr><td>Total</td><td>0.9 kB</td></tr></tfoot>
  </table>
</div>
```

The `.table` wrapper provides horizontal scrolling on small screens. Numbers are tabular by default.

## Accordion

Native `<details>` — adjacent ones fuse into a group automatically:

```html
<details open>
  <summary>What is teff?</summary>
  <p>An ultra-lightweight semantic component library.</p>
</details>
<details>
  <summary>Does it need a build step?</summary>
  <p>No.</p>
</details>
```

## Tabs — `<teff-tabs>` (custom element, requires JS)

Wires ARIA (`aria-controls`, `aria-labelledby`, ids), roving tabindex, and Arrow-key navigation around your markup. Tabs and panels pair by order.

```html
<teff-tabs>
  <div role="tablist" aria-label="Example tabs">
    <button role="tab" aria-selected="true">Overview</button>
    <button role="tab">Features</button>
  </div>
  <div role="tabpanel"><p>Overview panel.</p></div>
  <div role="tabpanel"><p>Features panel.</p></div>
</teff-tabs>
```

- Initial tab: the one with `aria-selected="true"`, else the first.
- Keyboard: ArrowLeft/ArrowRight cycle, click activates.
- JS API: `el.activeIndex` (get/set, number).
- Event: `teff-tab-change` — bubbling `CustomEvent` with `detail: { index: number, tab: HTMLElement }`.

```js
document.querySelector("teff-tabs").addEventListener("teff-tab-change", (e) => {
  console.log(e.detail.index, e.detail.tab);
});
```

## Dropdown — `<teff-dropdown>` (custom element, requires JS)

Built on the native Popover API; adds anchoring (with viewport flip), menu keyboard navigation (ArrowUp/ArrowDown wrap, Home/End), focus management, and `aria-expanded`.

```html
<teff-dropdown>
  <button popovertarget="menu-demo" aria-haspopup="menu" aria-expanded="false">Options</button>
  <menu popover id="menu-demo">
    <button role="menuitem">Edit</button>
    <button role="menuitem">Duplicate</button>
    <hr />
    <button role="menuitem" data-variant="danger">Delete</button>
  </menu>
</teff-dropdown>
```

## Dialog

Native `<dialog>`, opened declaratively with `command`/`commandfor` (the JS bundle polyfills these for Safari). Clicking the backdrop closes it — opt out with `data-static` on the dialog.

```html
<button command="show-modal" commandfor="confirm-dialog">Open dialog</button>
<dialog id="confirm-dialog">
  <header>
    <h3>Delete project?</h3>
    <p>This action cannot be undone.</p>
  </header>
  <div><p>The project will be permanently removed.</p></div>
  <footer>
    <button class="ghost" command="close" commandfor="confirm-dialog">Cancel</button>
    <button data-variant="danger" command="close" commandfor="confirm-dialog">Delete</button>
  </footer>
</dialog>
```

Structure: optional `<header>` (title + subtitle), body content, optional `<footer>` (actions).

## Alerts

```html
<div role="alert">Neutral message.</div>
<div role="alert" data-variant="success">Saved successfully.</div>
<div role="alert" data-variant="warning">Subscription expires soon.</div>
<div role="alert" data-variant="danger">Something went wrong.</div>
```

`data-variant`: `success`, `warning`, `danger` (alias `error`).

## Progress & meter

```html
<progress value="0.6" max="1"></progress>
<progress></progress>  <!-- bare = indeterminate animation -->
<meter value="0.85" min="0" max="1">85%</meter>
<meter value="0.2" min="0" max="1" low="0.4" high="0.7" optimum="1">20%</meter>  <!-- self-colors -->
```

## Spinner & skeleton

```html
<span aria-busy="true"></span>                      <!-- standalone spinner -->
<span aria-busy="true" data-spinner="small"></span> <!-- sizes: small, large -->
<button aria-busy="true">Loading</button>           <!-- spinner inside button -->
<div aria-busy="true" data-spinner="overlay">…</div><!-- dims + disables contents -->

<div role="status" class="skeleton line"></div>     <!-- shimmer placeholder -->
<div role="status" class="skeleton line" style="width: 60%"></div>
```

`aria-busy="true"` on anything shows a spinner; `data-spinner` accepts space-separated `small`/`large`/`overlay`.

## Tooltips

With the JS bundle, every `title` attribute is automatically converted into a styled tooltip (`data-tooltip` + `aria-label`) — including elements added later.

```html
<button class="outline" title="Tooltip text" data-tooltip-placement="top">Hover me</button>
```

- `data-tooltip-placement`: `top` (default), `bottom`, `left`, `right`.
- CSS-only usage (no JS): set `data-tooltip="text"` and `aria-label` yourself.

## Toasts — `teff.toast()` (JS API)

```js
teff.toast("Saved!");
teff.toast("Your changes have been saved.", "Saved", { variant: "success" });
teff.toast("Something went wrong.", "Error", { variant: "danger", placement: "bottom-center" });
teff.toast("Sticky until dismissed.", "Note", { duration: 0 });

// custom markup (an element or a <template>) — cloned, id stripped
teff.toast.el(document.querySelector("#my-template"), { duration: 4000 });

teff.toast.clear();              // clear all
teff.toast.clear("top-right");   // clear one placement
```

Signature: `teff.toast(message: string, title?: string, options?)` → the toast element.

| Option | Values | Default |
|---|---|---|
| `variant` | `info`, `success`, `warning`, `danger` | `info` |
| `placement` | `top-left`, `top-center`, `top-right`, `bottom-left`, `bottom-center`, `bottom-right` | `top-right` |
| `duration` | ms; `0` = never auto-dismiss | `4000` |

Hovering a toast pauses its timer. `teff.toast.el(elementOrTemplate, { placement, duration })` shows arbitrary markup.

## Motion

Opt-in, compositor-friendly (only `opacity`, `translate`, `filter`); everything respects `prefers-reduced-motion`.

```html
<div data-enter>fades in once on load</div>
<div data-enter="stagger">  <!-- children cascade 100 ms apart -->
  <h3>Title</h3>
  <p>Body</p>
</div>
```

```js
teff.shake(inputEl); // quick head-shake for rejected input; restarts cleanly on repeat calls
```

`teff.shake(el)` toggles the `data-shake` attribute (which you can also set manually) and removes it on `animationend`.

## Utilities

Layout: `.flex` `.flex-col` `.items-center` `.justify-center` `.justify-between` `.justify-end` `.grow` `.shrink-0` `.min-w-0` `.w-100` · stacks: `.hstack` (horizontal, gap, wraps) `.vstack` (vertical, gap) · gaps: `.gap-1/2/3/4/6`.

Spacing: `.mt-2/4/6/8` `.mb-2/4/6/8` `.ms-auto` `.me-auto` `.mx-auto` `.p-2/4/6`.

Text: `.align-left/center/right` `.text-light` `.text-lighter` `.text-small` `.text-xsmall` `.font-normal/medium/semibold` `.tabular` (tabular numerals) `.truncate` `.sr-only`.

Surfaces: `.rounded` `.rounded-large` `.rounded-full` `.shadow-small/medium/large` `.img-outline` (1px alpha edge on images) · `.unstyled` (on `ul`/`ol`/`a`: strips list/link styling).

## window.teff global (JS API summary)

| API | Description |
|---|---|
| `teff.toast(message, title?, opts?)` | show a text toast; returns the element |
| `teff.toast.el(el, opts?)` | show an element or `<template>` as a toast |
| `teff.toast.clear(placement?)` | dismiss all toasts, or one placement |
| `teff.shake(el)` | shake animation on an element |

Custom elements registered: `teff-tabs`, `teff-dropdown`. Automatic page-wide enhancements: tooltips from `title`, password show/hide toggles, sidebar toggle wiring, `command`/`commandfor` polyfill, dialog backdrop-close.

TypeScript: the package ships `teff.d.ts` (the `teff` global, `HTMLElementTagNameMap` entries, and the `teff-tab-change` event map) and a `custom-elements.json` manifest.

## React / JSX notes

teff is plain markup — classes and `data-*` attributes work in JSX as-is. Import both files once in your entry module.

- React 19 renders custom elements like `<teff-tabs>` natively; for TypeScript, declare them in `JSX.IntrinsicElements` (or use the shipped `teff.d.ts` tag name map).
- teff components emit plain DOM `CustomEvent`s — listen with a `ref` + `addEventListener`; React does not map custom events to `on*` props.

## Accessibility & browser support

WCAG AA contrast in both schemes; keyboard navigation per WAI-ARIA patterns (tabs, menus); `prefers-reduced-motion` respected throughout. Requires a modern evergreen browser: `light-dark()`, Popover API, `@layer`, `:has()`.

## License

MIT. A fork of [oat](https://github.com/knadh/oat) by knadh.
