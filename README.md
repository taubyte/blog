# Taubyte Blog

### Local Development:

1. **Initialize git submodule** (if not already done):
   ```bash
   git submodule update --init --recursive
   ```

2. **Run Hugo server locally**:
   ```bash
   hugo server --environment development
   ```
   
   This will:
   - Use `http://localhost:1313/` as the base URL
   - Set environment to `development`
   - Use correct image paths for local development
   - Serve at http://localhost:1313
   
   **Important:** Always use `--environment development` when running locally, otherwise it defaults to production!

3. **For production builds**:
   ```bash
   hugo --environment production
   ```
   
   This uses the production base URL: `https://taubyte.github.io/blog/`

**Configuration Structure:**
- Base config: `config/_default/hugo.toml`
- Development overrides: `config/development/hugo.toml`
- Production overrides: `config/production/hugo.toml`

Hugo automatically merges configurations based on the environment specified.

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
