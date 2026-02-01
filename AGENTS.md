# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AD COOP professional portfolio website built with Hugo. French-language site showcasing cooperation facilitation, shared governance, and "Jeu du Tao" services. Deployed to https://adcoop.fr/ via GitHub Pages.

## Development Commands

```bash
# Start dev server at http://localhost:1313
make serve

# Interactive shell with Hugo CLI
make shell

# Rebuild Docker image (after .hugo-version change)
make build

# Clean Docker artifacts
make clean
```

Without Make:
```bash
echo "HUGO_VERSION=$(cat .hugo-version)" > .env
echo "GO_VERSION=$(cat .go-version)" >> .env
docker compose up hugo
```

Inside shell (`make shell`):
```bash
hugo new content/posts/mon-article.md  # Create new content
hugo --minify                          # Build with minification
```

## Version Management

Hugo and Go versions are centralized in `.hugo-version` and `.go-version` files. These are read by the Makefile and GitHub Actions to ensure consistency. To upgrade Hugo:

```bash
echo "0.160.0" > .hugo-version
make build
```

## Architecture

### Content Structure
- `content/` - Main pages (Markdown with frontmatter)
- `content/ressource/` - Downloadable resources with preview images
- `data/home/*.yaml` - Homepage section content (hero, services, brands, testimonials)

### Theme (`themes/adcoop/`)
Custom theme based on "Up Business Theme" (MIT license). Key paths:
- `layouts/` - HTML templates (`baseof.html`, `single.html`, `index.html`)
- `layouts/partials/` - Reusable components (header, footer, sections, icons)
- `assets/scss/` - Bootstrap 5 SCSS with custom styles
- `static/` - Inter font family, static images

### Configuration
- `config.yaml` - Hugo config: base URL, menus, params, taxonomies (disabled)
- `frontmatter.lastmod` uses `:git` - last modified dates from Git commits

## Deployment

Push to `main` triggers GitHub Actions workflow (`.github/workflows/hugo.yaml`):
1. Reads `.hugo-version` for build consistency
2. Builds with `hugo --gc --minify`
3. Deploys to GitHub Pages

Broken link checker runs weekly (Mondays 5:00 AM UTC).

## Content Patterns

Homepage uses YAML data files rather than Markdown:
```yaml
# data/home/services.yaml
- title: "Service Name"
  text: "Description"
  icon: "icon-name"
  link: "/page/"
```

Resource pages bundle downloadable files alongside content:
```
content/ressource/plateau-jeu-du-tao/
├── index.md
├── preview.webp
└── plateau.zip
```

## Accessibility (WCAG 2.2 AA)

This site targets WCAG 2.2 Level AA compliance. When modifying templates or styles:

### Required Patterns
- **Skip link**: `baseof.html` includes skip-to-main link (class `skip-link visually-hidden-focusable`)
- **Landmarks**: Use `<main id="main-content">`, `<nav aria-label="...">`, `<footer role="contentinfo">`
- **Navigation labels**: Multiple `<nav>` elements must have distinct `aria-label` attributes

### Images & Icons
- Decorative images: use `alt=""`
- Decorative SVGs: add `aria-hidden="true" focusable="false"`
- Functional images: provide meaningful `alt` text
- Icon-only links: add `aria-label` describing the destination

### Color Contrast
- Text must have 4.5:1 contrast ratio minimum
- Current body text uses `.text-black-61` at `rgba(0,0,0,0.74)` - do not reduce opacity
- Primary color `#00A9A2` passes on white backgrounds

### External Links
- Add `target="_blank" rel="noopener"` for external links
- Include "(nouvelle fenêtre)" or similar in `aria-label` to warn users

### Forms (if added)
- Every input needs a visible `<label>` or `aria-label`
- Error messages must use `role="alert"` and be linked via `aria-describedby`
