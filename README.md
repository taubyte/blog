# Taubyte Blog

Simple Hugo blog using PaperMod theme, deployed to GitHub Pages.

## Quick Start

### Start Development Server

```bash
cd blog
../bin/hugo server --bind=0.0.0.0 --port=1313
```

Visit: http://localhost:1313/blog/

### Create New Post

```bash
cd blog
../bin/hugo new content posts/your-post-name.md
```

Edit the file, set `draft = false` when ready to publish.

### Build Site

```bash
cd blog
../bin/hugo --minify
```

### Publish to GitHub Pages

```bash
cd blog
git add .
git commit -m "Your commit message"
git push origin main
```

GitHub Actions will automatically build and deploy to: https://taubyte.github.io/blog/

## Commands Reference

- `../bin/hugo server` - Start development server
- `../bin/hugo new content posts/name.md` - Create new post
- `../bin/hugo --minify` - Build site for production
- `git push origin main` - Deploy to GitHub Pages

## File Structure

- `content/posts/` - Your blog posts (Markdown files)
- `hugo.toml` - Site configuration
- `themes/PaperMod/` - Theme files
- `public/` - Generated site (auto-created, don't edit)

## Notes

- Hugo binary is in `../bin/hugo`
- Always run commands from the `blog/` directory
- Posts are written in Markdown
- Set `draft = false` in frontmatter to publish

