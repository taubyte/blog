# 🚀 Taubyte Blog - Quick Setup Guide

## One-Command Blogging Workflow

This Hugo blog is set up with clever automation scripts for easy post creation and publishing.

## 📝 Creating and Publishing Posts

### Option 1: One-Command Post and Publish
```bash
./post-and-publish.sh "Your Post Title" "Category" "tag1,tag2,tag3" "Optional commit message"
```

**Example:**
```bash
./post-and-publish.sh "Getting Started with Hugo" "Tutorial" "hugo,web,static-site" "Add Hugo tutorial post"
```

This will:
1. Create a new post with proper frontmatter
2. Open it in your default editor
3. Wait for you to finish editing
4. Automatically build and push to GitHub
5. Trigger automatic deployment via GitHub Actions

### Option 2: Separate Steps

#### Create a new post:
```bash
./new-post.sh "Your Post Title" "Category" "tag1,tag2,tag3"
```

#### Publish when ready:
```bash
./publish.sh "Your commit message"
```

## 🛠️ Initial GitHub Setup

1. **Create a GitHub repository** for your blog
2. **Add the remote:**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

3. **Enable GitHub Pages:**
   - Go to your repository settings
   - Navigate to "Pages" section
   - Select "GitHub Actions" as the source
   - The workflow will automatically deploy your site

## 📁 File Structure

```
blog/
├── content/posts/          # Your blog posts
├── themes/PaperMod/       # PaperMod theme (submodule)
├── .github/workflows/     # GitHub Actions for deployment
├── new-post.sh           # Create new posts
├── publish.sh            # Build and push to GitHub
├── post-and-publish.sh   # Combined workflow
├── hugo.toml             # Site configuration
└── public/               # Generated site (auto-created)
```

## 🎨 Customization

### Edit Site Settings
Modify `hugo.toml` to customize:
- Site title and description
- Author information
- Social media links
- Theme colors and features

### Post Frontmatter
Each post includes:
```toml
+++
title = 'Post Title'
date = 2024-01-01T12:00:00+00:00
draft = false
description = "Post description for SEO"
tags = ["tag1", "tag2"]
categories = ["Category"]
author = "Your Name"
+++
```

## 🚀 Deployment

Your blog automatically deploys to GitHub Pages when you push to the main branch:

1. **GitHub Actions** builds your Hugo site
2. **Deploys** to `https://YOUR_USERNAME.github.io/YOUR_REPO`
3. **Check deployment** status in the Actions tab

## 🛠️ Local Development

```bash
# Start development server
../hugo server --bind=0.0.0.0 --port=1313

# Visit: http://localhost:1313
```

## 📊 Features

- ✅ **Fast post creation** with proper frontmatter
- ✅ **One-command publishing** to GitHub
- ✅ **Automatic deployment** via GitHub Actions
- ✅ **SEO optimized** with PaperMod theme
- ✅ **Mobile responsive** design
- ✅ **Dark/Light mode** toggle
- ✅ **Search functionality**
- ✅ **Social media integration**

## 🎯 Workflow Summary

1. **Write:** `./post-and-publish.sh "My New Post"`
2. **Edit:** Content opens in your editor
3. **Publish:** Press Enter when done
4. **Deploy:** GitHub Actions handles the rest
5. **Share:** Your post is live!

Happy blogging! 🎉
