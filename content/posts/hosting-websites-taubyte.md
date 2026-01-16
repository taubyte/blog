---
title: "Hosting Websites on Taubyte"
author: Zaoui Amine
featured: true
draft: false
tags:
  - tutorials
  - websites
  - static-sites
  - hosting
  - cloud
image:
  src: /blog/images/hosting-websites.png
  alt: Hosting Websites on Taubyte
summary: Taubyte makes hosting static websites simple. Learn how to create, configure, and deploy a website on your Taubyte cloud with automatic builds and instant previews.
date: 2026-01-14T12:50:00Z
categories: [Hand-on Learning]
---

Taubyte makes hosting static websites straightforward. Whether you're building a simple landing page, a single-page application, or a full-featured web app, you can deploy and serve your website directly on your Taubyte cloud with automatic builds and instant previews.

## Creating a Website

From the sidebar, navigate to **Websites** and click the **+** button.

![Creating a new website](/blog/images/hitchhikers-guide/create-new-website.png)

Configure your website:

| Field      | Description                     | Example               |
| ---------- | ------------------------------- | --------------------- |
| Name       | Unique identifier               | `my-website`          |
| Repository | Generate new or import existing | `Generate`            |
| Private    | Repository visibility           | Toggle on for private |
| Domain     | Which domain to serve on        | `GeneratedDomain`     |
| Path       | URL path                        | `/`                   |

### Choosing a Template

Taubyte offers several templates to get you started:

- **HTML**: Basic HTML/CSS/JS starter
- **React**: React application boilerplate
- **Vue**: Vue.js starter template
- **Static**: Empty static site

![Selecting a website template](/blog/images/hitchhikers-guide/select-website-template.png)

Select your preferred template and click **Generate**.

This instantly creates a fresh GitHub repository with starter code ready for customization.

## Pushing Configuration

Click the **push button** in the bottom right to save your configuration.

![Commit and push interface](/blog/images/hitchhikers-guide/commit-and-push-empty.png)

Before finalizing:

1. Open the **websites** folder
2. Find the YAML file for your website
3. Copy the **ID** and **GitHub repo name**—you'll need these for builds

Type a commit message and push.

## Editing Your Website

Click the **open in browser icon** next to your website in the list. This takes you directly to the GitHub repository.

### Making Changes

1. Open `index.html` (or your main file)
2. Click **Edit**
3. Make your changes:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Taubyte Site</title>
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          sans-serif;
        max-width: 800px;
        margin: 50px auto;
        padding: 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        color: white;
      }
      h1 {
        font-size: 3rem;
      }
    </style>
  </head>
  <body>
    <h1>Welcome to My Taubyte Site!</h1>
    <p>This site is hosted on my own cloud infrastructure.</p>
  </body>
</html>
```

4. Commit the changes

## Triggering a Build

Since Dream doesn't automatically trigger builds from GitHub, do it manually:

```bash
# Use the ID and full repo name you copied earlier
dream inject push-specific --rid <github-id> --fn <repo-name>
```

Navigate to the **Builds** page in the console and wait for completion.

![Website build status](/blog/images/hitchhikers-guide/show-website-build.png)

## Viewing Your Website

### Local Setup Required

Before previewing, add your generated domain to `/etc/hosts`:

```bash
sudo nano /etc/hosts
```

Add:

```bash
127.0.0.1 your-domain.blackhole.localtau
```

![Editing /etc/hosts file](/blog/images/hitchhikers-guide/etc-file.png)

### Open the Website

Back in the console:

1. Navigate to **Websites**
2. Click the **lightning icon** next to your website

![Lightning button to run website](/blog/images/hitchhikers-guide/lightningbutton-to-run-website.png)

3. A new tab opens with your live site!

![Running website](/blog/images/hitchhikers-guide/running-website.png)

## Website Structure

Generated websites follow this structure:

```bash
my-website/
├── index.html        # Main entry point
├── css/
│   └── style.css     # Stylesheets
├── js/
│   └── app.js        # JavaScript
├── assets/
│   └── images/       # Static assets
└── .taubyte/
    ├── config.yaml   # Build configuration
    └── build.sh      # Build script
```

### The `.taubyte` Folder

This folder is essential for proper deployment:

**config.yaml** - Defines the build environment:

```yaml
version: "1.0"
environment:
  image: node:alpine
  variables:
    NODE_ENV: production
workflow:
  - build.sh
```

**build.sh** - The build script:

```bash
#!/bin/bash
mkdir -p /out
cp -r * /out/
rm -rf /out/.taubyte
```

> **Important**: All output must go to the `/out` folder.

## Advanced: Building with Frameworks

For frameworks like React or Vue, the build process is more involved:

### React Example

**config.yaml**:

```yaml
version: "1.0"
environment:
  image: node:18-alpine
  variables:
    NODE_ENV: production
workflow:
  - build.sh
```

**build.sh**:

```bash
#!/bin/bash
npm install
npm run build
mkdir -p /out
cp -r build/* /out/
```

### Vue Example

**build.sh**:

```bash
#!/bin/bash
npm install
npm run build
mkdir -p /out
cp -r dist/* /out/
```

## Troubleshooting

| Issue               | Solution                                |
| ------------------- | --------------------------------------- |
| Website not loading | Check `/etc/hosts` includes your domain |
| Build failed        | Review build logs in the Builds tab     |
| 404 errors          | Ensure `index.html` exists at root      |
| Assets not loading  | Verify paths are relative, not absolute |

## Conclusion

You've just created and deployed your first website on Taubyte:

1. **Created** a website with a template
2. **Edited** the HTML in GitHub
3. **Triggered** a build
4. **Previewed** your live site

With websites and functions sharing the same domain, you can build complete web applications with seamless frontend-backend integration.

Next, learn about [Object Storage](/blog/posts/object-storage-taubyte) for storing and serving files.
