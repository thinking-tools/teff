# teff - Build System
# Requires: esbuild

.PHONY: dist css js clean size publish pages

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

# Deploy the demo site: rebuild, copy the page + bundles + LLM docs onto the
# pages branch via a throwaway worktree, commit, push (Codeberg Pages serves
# the pages branch).
PAGES_WT = /tmp/teff-pages-wt

pages: dist
	@git worktree remove --force $(PAGES_WT) 2>/dev/null || true
	@git worktree add --quiet $(PAGES_WT) pages
	@cp index.html favicon.svg llms.txt $(PAGES_WT)/
	@cp REFERENCE.md $(PAGES_WT)/llms-full.txt
	@VERSION=$$(git describe --tags --abbrev=0) && \
		sed -i '' -E 's/(id="version">)[^<]*/\1'"$$VERSION"'/' $(PAGES_WT)/index.html
	@mkdir -p $(PAGES_WT)/dist
	@cp dist/teff.min.css dist/teff.min.js $(PAGES_WT)/dist/
	@cd $(PAGES_WT) && git add -A && \
		if git diff --cached --quiet; then \
			echo "pages: no changes to publish"; \
		else \
			git commit --quiet -m "Publish pages from $$(git describe --tags main)" && \
			git log --oneline -1; \
		fi
	@git worktree remove $(PAGES_WT)
	@git push origin pages

publish: clean dist
	@cp -r src/css dist/css
	@cp -r src/js dist/js
	@cp README.md dist/README.md
	@cp LICENSE dist/LICENSE
	@cp REFERENCE.md dist/REFERENCE.md
	@cp llms.txt dist/llms.txt
	@cp teff.d.ts dist/teff.d.ts
	@cp custom-elements.json dist/custom-elements.json
	@VERSION=$$(git describe --tags --abbrev=0 | sed 's/^v//') && \
		sed -E 's/"version": *"[^"]*"/"version": "'"$$VERSION"'"/' package.json > dist/package.json
	@cd dist && npm publish --access public
