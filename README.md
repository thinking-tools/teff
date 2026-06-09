# teff

Semantic UI, two tiny files. teff styles plain, accessible HTML out of the box and sprinkles behavior on top with vanilla web components — no framework, no build step, no dependencies.

- **~9 kB CSS + ~3 kB JS**, minified and gzipped
- Dark mode built in via `light-dark()`, WCAG AA contrast, respects `prefers-reduced-motion`
- The two files are independent — use either without the other
- A fork of [oat](https://github.com/knadh/oat) by [knadh](https://github.com/knadh) ([oat.ink](https://oat.ink))

## Install

**CDN — no build step:**

```html
<link rel="stylesheet" href="https://unpkg.com/teff/teff.min.css" />
<script src="https://unpkg.com/teff/teff.min.js"></script>
```

**npm — bundlers (Vite, Next, …):**

```sh
npm install teff
```

```js
// once, in your app entry
import "teff/teff.min.css";
import "teff"; // optional: registers the custom elements + the `teff` global
```

## Use

Write semantic HTML — it's already styled:

```html
<button>Save</button> <button class="outline">Cancel</button>

<label>Email <input type="email" required /></label>

<details>
  <summary>Native accordion</summary>
  <p>No JS involved.</p>
</details>
```

The CSS covers native elements (buttons, forms, tables, `<dialog>`, `<details>`, `<progress>`, `<meter>`, …) plus a handful of class-based pieces (`.badge`, `.card`, `.row`/`.col-*`). The JS adds:

- `<teff-tabs>` and `<teff-dropdown>` — custom elements that wire ARIA and keyboard navigation around your existing markup
- automatic enhancements, no markup changes: `title` attributes become styled tooltips, password fields grow a show/hide toggle, `[data-sidebar]` becomes a responsive shell
- two imperative calls: `teff.toast("Saved.", "Done", { variant: "success" })` and `teff.shake(el)`

Open `index.html` for the full component gallery with copy-paste examples.

## Theming

Flip presets on `<html>`, or override tokens directly:

```html
<html data-theme="dark" data-accent="blue" data-radius="soft" data-density="compact">
```

```css
:root {
  --primary: light-dark(#2068c9, #7ab3ff);
  --radius-button: 0.75rem;
}
```

## React

teff is just markup — classes and data attributes on plain HTML work in JSX as-is. Import both files once in your entry module (see above). Two notes:

- React 19 renders custom elements like `<teff-tabs>` natively; for TypeScript, declare them in `JSX.IntrinsicElements`.
- teff components emit plain DOM `CustomEvent`s — listen with a `ref` + `addEventListener`; React doesn't map custom events to `on*` props.

## Build from source

```sh
make dist    # build dist/, print sizes (esbuild comes via npm install)
make clean
```

CSS files concatenate in the order listed in the `Makefile`; the JS bundles from `src/js/index.js`.

## License

MIT
