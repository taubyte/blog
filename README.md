# Taubyte Blog

Hugo blog with PaperMod theme, deployed to GitHub Pages.

## Setup

1. Clone the repository
```bash
git clone https://github.com/taubyte/blog.git
cd blog
```

2. Install Hugo
```bash
make setup
```

3. Start the server
```bash
make server
```

Visit: http://localhost:1313/blog/

## Commands

- `make setup` - Install Hugo
- `make server` - Start development server
- `make new POST=name` - Create new post
- `make build` - Build site
- `make clean` - Clean build files

## Double-click (GUI)

**Windows:**
- `scripts/windows/setup.bat`
- `scripts/windows/server.bat`
- `scripts/windows/new-post.bat`

**macOS:**
- `scripts/macos/setup.command`
- `scripts/macos/server.command`
- `scripts/macos/new-post.command`

**Linux:**
- `scripts/linux/setup.sh`
- `scripts/linux/server.sh`
- `scripts/linux/new-post.sh`

## Publishing

```bash
git add .
git commit -m "Your message"
git push origin main
```

GitHub Actions builds and deploys to: https://taubyte.github.io/blog/

## File Structure

- `content/posts/` - Blog posts (Markdown)
- `hugo.toml` - Site configuration
- `themes/PaperMod/` - Theme files
- `scripts/` - OS-specific scripts

## Notes

- Hugo binary is in `../bin/hugo`
- Run commands from the `blog/` directory
- Set `draft = false` in posts to publish
- GitHub Actions handles deployment automatically
