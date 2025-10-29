# Taubyte Blog

Hugo blog deployed to GitHub Pages.

## For Contributors (Non-Authorized Users)

This repository has branch protection enabled. **Direct pushes to main are not allowed** for non-authorized users.

### How to Contribute:

1. **Fork the repository** or **create a feature branch**
2. **Create your post:**
   - Create file: `content/posts/my-post.md`
   - Copy template from `content/posts/_template.md`
   - Set `draft = false`
   - Write your content

3. **Submit changes via Pull Request:**
   ```bash
   git add .
   git commit -m "Add new post: my-post"
   git push origin your-branch-name
   ```
   Then create a Pull Request on GitHub

4. **Wait for approval and deployment:**
   - Your PR needs approval from a repository admin
   - The "Deploy Blog" workflow must pass
   - Once merged, changes go live at: https://taubyte.github.io/blog/

## For Authorized Users (Admins)

You can push directly to main:

```bash
git add .
git commit -m "Add new post"
git push origin main
```

Wait ~2 minutes. Live at: https://taubyte.github.io/blog/

## Repository Protection

- ✅ Branch protection enabled
- ✅ Pull request reviews required
- ✅ Status checks must pass
- ✅ Only admins can bypass protection
