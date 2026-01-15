---
title: "Working with Branches in Taubyte"
author: Zaoui Amine
featured: true
draft: false
tags:
  - tutorials
  - branches
  - git
  - development
  - cloud
image:
  src: /blog/images/branches-taubyte.png
  alt: Working with Branches in Taubyte
summary: Follow best practices for feature development by using Git branches with Taubyte. Learn how to run Dream on development branches, create new branches in the console, and merge changes to production.
date: 2026-01-14T20:00:00Z
categories: [Hand-on Learning]
---

When working with projects, the best practice is to create a **new branch for each feature or bug fix**. This way, you can work in isolation without touching the main branch until your work is ready to merge.

Both **Tau** and **Dream** support running on branches.

## Default Behavior

By default:
- **Tau** (production) runs on `main` and `master` branches
- **Dream** (local) also defaults to these branches

But you can configure either to run on any branch.

## Starting Dream on a Branch

To start Dream on a specific branch, use the `-b` flag:

```bash
dream new multiverse -b dev
```

This starts a Dream universe that listens for changes on the `dev` branch instead of `main`.

## Connecting to Your Branch Universe

Once Dream is running on your branch, connect through the web console:

1. Open [console.taubyte.com](https://console.taubyte.com)
2. Connect to your Dream universe (should be named `blackhole`)
3. Either create a new project or import an existing one

## The Branch Creation Flow

Here's a common scenario: you start Dream on a development branch that doesn't exist yet on the remote repository.

### Initial Attempt

Trigger a build:

```bash
dream inject push-all
```

You might see an error in Dream logs:

```bash
Check out 'dev' failed with reference not found
```

**This happens because the `dev` branch doesn't exist on the remote repository yet.**

### Creating the Branch

To fix this, create the branch in the console:

1. In the top right corner, click the **current branch name** (shows `main`)
2. Click the **+** button
3. Type `dev` as the new branch name
4. Click **Validate**

The console will refresh and show the branch name changed to `dev`.

### Building Successfully

Now trigger the build again:

```bash
dream inject push-all
```

This time it should **succeed**. If you imported a project with existing functions, they'll be built on this branch.

## Commands Reference

| Command | Description |
|---------|-------------|
| `dream new multiverse` | Start Dream on default branch (main) |
| `dream new multiverse -b dev` | Start Dream on `dev` branch |
| `dream inject push-all` | Trigger builds for all repos |

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| "Reference not found" | Branch doesn't exist on remote | Create branch in console |
| Wrong branch building | Dream started on different branch | Restart Dream with correct `-b` flag |
| Changes not appearing | Built on wrong branch | Verify console shows correct branch |

## Best Practices

1. **Never develop directly on main**: Always use feature branches
2. **Name branches descriptively**: `feature/user-auth`, `fix/login-bug`
3. **Test locally first**: Use Dream to validate before merging
4. **Keep branches short-lived**: Merge frequently to avoid conflicts
5. **Delete merged branches**: Keep your repository clean

## Conclusion

You've learned how to:

1. **Start Dream on specific branches** with the `-b` flag
2. **Create branches** from the console
3. **Build and test** on feature branches
4. **Merge to production** when ready

Branching enables safe, isolated development that follows industry best practices. You can experiment freely knowing your main branch stays stable until you're ready to merge.

Next, learn how to [ship to production](/blog/posts/ship-to-production-taubyte) when your project is ready.

