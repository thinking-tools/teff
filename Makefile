# teff - Build System
# Requires: esbuild

.PHONY: dist css js clean size publish

# Local esbuild from devDependencies; override with `make ESBUILD=esbuild` for a global one.
ESBUILD ?= node_modules/.bin/esbuild

CSS_FILES = src/css/00-base.css \
            src/css/01-theme.css \
            src/css/animations.css \
			src/css/avatar.css \
            src/css/button.css \
            src/css/form.css \
            src/css/table.css \
            src/css/progress.css \
            src/css/spinner.css \
            src/css/grid.css \
            src/css/card.css \
            src/css/alert.css \
            src/css/badge.css \
            src/css/accordion.css \
            src/css/tabs.css \
            src/css/dialog.css \
            src/css/dropdown.css \
            src/css/toast.css \
            src/css/nav.css \
            src/css/sidebar.css \
            src/css/skeleton.css \
            src/css/tooltip.css \
            src/css/utilities.css

dist: css js size

css:
	@mkdir -p dist
	@cat $(CSS_FILES) > dist/teff.css
	@$(ESBUILD) dist/teff.css --minify --outfile=dist/teff.min.css
	@gzip -9 -k -f dist/teff.min.css
	@echo "CSS: $$(wc -c < dist/teff.min.css | tr -d ' ') bytes (minified)"

js:
	@mkdir -p dist
	@$(ESBUILD) src/js/index.js --bundle --format=iife --outfile=dist/teff.js
	@$(ESBUILD) src/js/index.js --bundle --format=iife --minify --outfile=dist/teff.min.js
	@gzip -9 -k -f dist/teff.min.js
	@echo "JS: $$(wc -c < dist/teff.min.js | tr -d ' ') bytes (minified)"

clean:
	@rm -rf dist

size:
	@echo ""
	@echo "Bundle:"
	@echo "CSS (src):   $$(wc -c < dist/teff.css | tr -d ' ') bytes"
	@echo "CSS (min):   $$(wc -c < dist/teff.min.css | tr -d ' ') bytes"
	@echo "CSS (gzip):  $$(wc -c < dist/teff.min.css.gz | tr -d ' ') bytes"
	@echo ""
	@echo "JS (src):    $$(wc -c < dist/teff.js | tr -d ' ') bytes"
	@echo "JS (min):    $$(wc -c < dist/teff.min.js | tr -d ' ') bytes"
	@echo "JS (gzip):   $$(wc -c < dist/teff.min.js.gz | tr -d ' ') bytes"

publish: clean dist
	@cp -r src/css dist/css
	@cp -r src/js dist/js
	@cp README.md dist/README.md
	@cp LICENSE dist/LICENSE
	@VERSION=$$(git describe --tags --abbrev=0 | sed 's/^v//') && \
		sed -E 's/"version": *"[^"]*"/"version": "'"$$VERSION"'"/' package.json > dist/package.json
	@cd dist && npm publish --access public
