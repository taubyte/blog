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

**Method 1: Using Hugo Command (Recommended)**

```bash
cd blog
../bin/hugo new content posts/your-post-name.md
```

This creates a new post with frontmatter. Edit the file and:
- Change the title
- Set `draft = false` when ready to publish
- Add your content in Markdown

**Method 2: Create Manually**

Create a new file in `content/posts/your-post-name.md` with this template:

```markdown
+++
title = 'Your Post Title'
date = 2025-10-29T12:00:00+01:00
draft = false
description = "Brief description of your post"
tags = ["tag1", "tag2"]
categories = ["Category"]
+++

# Your Post Title

Write your content here using Markdown.

## Section

Your content goes here.

- Use lists
- Add code blocks
- Format text with **bold** and *italic*
```

**Note:** Replace the date with current date/time, and set `draft = false` to publish.

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
