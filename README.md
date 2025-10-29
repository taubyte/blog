# Taubyte Blog

Hugo blog deployed to GitHub Pages.

## Quick Start

```bash
git clone https://github.com/taubyte/blog.git
cd blog
make setup
make server
```

## Create Post

1. Create file: `content/posts/my-post.md`
2. Copy template from `content/posts/_template.md`
3. Set `draft = false`
4. Write your content

## Publish

```bash
git add .
git commit -m "Add new post"
git push origin main
```

Wait ~2 minutes. Live at: https://taubyte.github.io/blog/

## Commands

- `make server` - Start dev server
- `make new POST=name` - Create post
- `make build` - Build site

## Double-Click

- Windows: `scripts/windows/setup.bat`, `server.bat`, `new-post.bat`
- macOS: `scripts/macos/setup.command`, `server.command`, `new-post.command`
- Linux: `scripts/linux/setup.sh`, `server.sh`, `new-post.sh`
