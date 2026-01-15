---
title: "Shipping Your Project to Production with Taubyte"
author: Zaoui Amine
featured: true
draft: false
tags:
  - tutorials
  - deployment
  - production
  - cloud
image:
  src: /blog/images/ship-to-production.png
  alt: Shipping Your Project to Production with Taubyte
summary: You've built your project locally—now it's time to go live. Learn how to import your project into a production Taubyte cloud and trigger builds, whether you've been developing on main or a feature branch.
date: 2026-01-14T21:00:00Z
categories: [Hand-on Learning]
---

When you're ready to deploy your Taubyte project to production, the process is straightforward. Whether you've been developing locally with Dream or directly on GitHub, you can ship your project to a production Taubyte cloud with just a few steps.

The deployment process involves:
1. Importing your project into your production cloud
2. Triggering builds for your repositories

That's it. Let's walk through it.

## Importing Your Project

You can import using either the **web console** or the **Tau CLI**. The web console is the easiest, so we'll use that here.

### Step 1: Connect to Your Production Cloud

If you're currently connected to Dream, **log out first**.

Then:
1. Navigate to [console.taubyte.com](https://console.taubyte.com)
2. Select **Custom** from the network dropdown
3. Enter your cloud's **FQDN** (e.g., `mycloud.example.com`)
4. Click **Validate**
5. Log in with GitHub as usual

### Step 2: Import the Project

On the projects page:

1. Click **Import Project**
2. Select the repository you want to import

The web console will automatically identify eligible repositories. If you choose a **config repo**, it can even match the corresponding **code repo**.

If you don't see what you need, you can enter repositories manually.

### Step 3: Verify Import

Once imported, you'll see your project in the dashboard with all its resources—functions, databases, websites, and more.

## Triggering Builds

Once imported, you need to trigger builds for each repository.

### Scenario 1: Developed on Main Branch

If you've built your project locally using the **main branch**, push your changes to each repository **in this order**:

1. **Config repo** first
2. **Code repo** second
3. **All other repositories** (libraries, websites) last

This order ensures that configuration is in place before code is built.

### How to Push

Simply push to GitHub:

```bash
# In your config repo
git add .
git commit -m "Deploy to production"
git push origin main

# In your code repo
git add .
git commit -m "Deploy to production"
git push origin main

# Repeat for other repos
```

Each push triggers a build automatically via GitHub webhooks.


## Conclusion

You've learned how to:

1. **Import** your project into production
2. **Trigger builds** based on your development workflow
3. **Verify** the deployment
4. Set up **continuous deployment**

With Taubyte, shipping to production is as simple as merging to main. Your cloud handles the rest—building, deploying, and scaling automatically.

---

## 🎉 Congratulations!

You've completed the Taubyte tutorial series! You now know how to:

- ✅ Run a local cloud with Dream
- ✅ Create projects
- ✅ Build serverless functions
- ✅ Organize code with libraries
- ✅ Deploy websites
- ✅ Use object storage
- ✅ Work with databases
- ✅ Implement real-time messaging
- ✅ Organize with applications
- ✅ Understand CI/CD
- ✅ Work with branches
- ✅ Ship to production

For more advanced topics and detailed documentation, visit [tau.how](https://tau.how) and join our [Discord community](https://discord.gg/taubyte).

**Happy building!** 🚀

---

**Ready to deploy your own cloud?** Learn how to [deploy a Taubyte cloud with SporeDrive](/blog/posts/deploying-taubyte-cloud-with-sporedrive) on your own infrastructure.
