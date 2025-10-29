# Taubyte Blog

Simple Hugo blog using PaperMod theme, deployed to GitHub Pages.

## Prerequisites

- Git installed ([Download](https://git-scm.com/downloads))
- Terminal/Command Prompt access

## First Time Setup (New PC)

### Double-Click Setup (Easiest!)

**Windows Users:**

- Double-click `scripts/windows/setup.bat` to install Hugo
- Double-click `scripts/windows/server.bat` to start the server
- Double-click `scripts/windows/new-post.bat` to create a new post

**macOS Users:**

- Double-click `scripts/macos/setup.command` to install Hugo
- Double-click `scripts/macos/server.command` to start the server
- Double-click `scripts/macos/new-post.command` to create a new post

**Linux Users:**

- Double-click `scripts/linux/setup.desktop` to install Hugo (opens terminal)
- Double-click `scripts/linux/server.desktop` to start the server (opens terminal)
- Double-click `scripts/linux/new-post.desktop` to create a new post (GUI dialog)
- Note: `.desktop` files enable true double-click execution (not text editor)

### Quick Setup (Terminal/Command Line)

```bash
# 1. Clone the repository
git clone https://github.com/taubyte/blog.git
cd blog

# 2. Run automated setup (installs Hugo automatically)
make setup
# or
./scripts/setup.sh

# 3. Start the development server
make server
# or
./scripts/server.sh
```

That's it! The setup script will:

- Detect your operating system
- Download and install Hugo Extended automatically
- Verify the installation

### Manual Setup (Alternative)

If you prefer to install Hugo manually:

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

## Quick Start

### Start Development Server

```bash
make server
# or
./scripts/server.sh
```

Visit: http://localhost:1313/blog/

### Create New Post

**Method 1: Using Make Command (Easiest)**

```bash
make new POST=your-post-name
# or
./scripts/new-post.sh your-post-name
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
make build
```

### Publish to GitHub Pages

```bash
# Option 1: Use make publish (stages changes)
make publish
git commit -m "Your commit message"
git push origin main

# Option 2: Manual git workflow
git add .
git commit -m "Your commit message"
git push origin main
```

GitHub Actions will automatically build and deploy to: https://taubyte.github.io/blog/

## Commands Reference

**Double-Click Solutions:**

- Windows: `scripts/windows/setup.bat`, `scripts/windows/server.bat`, `scripts/windows/new-post.bat`
- macOS: `scripts/macos/setup.command`, `scripts/macos/server.command`, `scripts/macos/new-post.command`
- Linux: `scripts/linux/setup.sh`, `scripts/linux/server.sh`, `scripts/linux/new-post.sh`

**Using Make (Recommended for Terminal):**

- `make help` - Show all available commands
- `make setup` - Install Hugo automatically
- `make server` - Start development server
- `make new POST=name` - Create new post
- `make build` - Build site for production
- `make clean` - Clean generated files
- `make publish` - Build and stage for git

**Using Scripts:**

- `./scripts/setup.sh` - Install Hugo
- `./scripts/server.sh` - Start server
- `./scripts/new-post.sh <name>` - Create post

**Direct Hugo Commands:**

- `hugo server` (if Hugo is in PATH)
- `../bin/hugo server` (if using local binary)

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
