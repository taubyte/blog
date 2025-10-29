# Taubyte Blog

Simple Hugo blog using PaperMod theme, deployed to GitHub Pages.

## Prerequisites

- Git installed ([Download](https://git-scm.com/downloads))
- Terminal/Command Prompt access

## First Time Setup (New PC)

### 1. Clone the Repository

```bash
git clone https://github.com/taubyte/blog.git
cd blog
```

### 2. Install Hugo

**Option A: Download Hugo Binary (Recommended)**

**Linux:**
```bash
# Create bin directory
mkdir -p ../bin

# Download Hugo Extended
cd ..
curl -L https://github.com/gohugoio/hugo/releases/download/v0.152.2/hugo_extended_0.152.2_linux-amd64.tar.gz -o /tmp/hugo.tar.gz
tar -xzf /tmp/hugo.tar.gz -C bin/ hugo
chmod +x bin/hugo
rm /tmp/hugo.tar.gz

# Verify installation
cd blog
../bin/hugo version
```

**macOS:**
```bash
# Create bin directory
mkdir -p ../bin

# Download Hugo Extended
cd ..
curl -L https://github.com/gohugoio/hugo/releases/download/v0.152.2/hugo_extended_0.152.2_darwin-universal.tar.gz -o /tmp/hugo.tar.gz
tar -xzf /tmp/hugo.tar.gz -C bin/ hugo
chmod +x bin/hugo
rm /tmp/hugo.tar.gz

# Verify installation
cd blog
../bin/hugo version
```

**Windows:**
```powershell
# Create bin directory
mkdir ..\bin

# Download Hugo Extended
cd ..
curl -L https://github.com/gohugoio/hugo/releases/download/v0.152.2/hugo_extended_0.152.2_windows-amd64.zip -o hugo.zip
Expand-Archive -Path hugo.zip -DestinationPath bin\
Move-Item bin\hugo.exe bin\hugo.exe
Remove-Item hugo.zip

# Verify installation
cd blog
..\bin\hugo.exe version
```

**Option B: Install via Package Manager**

```bash
# Ubuntu/Debian
sudo snap install hugo --classic

# macOS (via Homebrew)
brew install hugo

# Windows (via Chocolatey)
choco install hugo-extended
```

**Option C: Install Globally (Alternative)**

If Hugo is installed globally (via package manager), you can use `hugo` directly instead of `../bin/hugo`:
```bash
# Then use:
hugo server --bind=0.0.0.0 --port=1313
hugo new content posts/name.md
```

### 3. Start Development Server

```bash
cd blog
../bin/hugo server --bind=0.0.0.0 --port=1313
```

Visit: http://localhost:1313/blog/

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
- Format text with **bold** and _italic_
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

- `../bin/hugo server` - Start development server (or `hugo server` if installed globally)
- `../bin/hugo new content posts/name.md` - Create new post
- `../bin/hugo --minify` - Build site for production
- `git push origin main` - Deploy to GitHub Pages

## File Structure

- `content/posts/` - Your blog posts (Markdown files)
- `hugo.toml` - Site configuration
- `themes/PaperMod/` - Theme files
- `public/` - Generated site (auto-created, don't edit)

## Notes

- Hugo binary is in `../bin/hugo` (if downloaded manually)
- Always run commands from the `blog/` directory
- Posts are written in Markdown
- Set `draft = false` in frontmatter to publish
- GitHub Actions automatically builds and deploys on push
