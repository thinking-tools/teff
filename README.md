# teff

Ultra-lightweight, semantic UI components. Write plain, semantic HTML — it's styled out of the box, no classes needed. A few interactive pieces (tabs, dropdown, tooltip, sidebar, toast) are small native Web Components. Zero runtime dependencies.

A fork of [oat](https://github.com/knadh/oat) by [knadh](https://github.com/knadh) ([oat.ink](https://oat.ink)).

## Use

Build the files (see below), then include them from `dist/`:

```html
<link rel="stylesheet" href="dist/teff.min.css" />
<script src="dist/teff.min.js"></script>
```

Now your semantic HTML is styled automatically. The CSS works on its own; the JS adds the interactive components and a global `window.teff` (e.g. `teff.toast('Saved')`).

## Build

Requires [esbuild](https://esbuild.github.io/) on your `PATH`.

```sh
make          # build dist/teff.min.css + dist/teff.min.js (prints sizes)
make clean    # remove dist/
```

## Develop

Source lives in `src/`:

- `src/css/` — plain CSS, one file per component. Adding a stylesheet? Also list it in `CSS_FILES` in the `Makefile` (concatenation order matters).
- `src/js/` — Web Components; `src/js/index.js` is the entry point.

Edit, run `make`, reload.

## License

MIT
