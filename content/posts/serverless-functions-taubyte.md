---
title: "Building Serverless Functions in Taubyte"
author: Zaoui Amine
featured: true
draft: false
tags:
  - tutorials
  - serverless
  - functions
  - golang
  - wasm
  - cloud
image:
  src: /blog/images/serverless-functions.png
  alt: Building Serverless Functions in Taubyte
summary: Learn how to create, configure, and deploy serverless functions in Taubyte. This hands-on guide walks through building a simple ping-pong function in Go, from creation to testing both locally and in production.
date: 2026-01-14T12:30:00Z
categories: [Hand-on Learning]
---

Serverless functions are the building blocks of modern cloud applications. In Taubyte, functions are compiled to WebAssembly and executed in a lightweight, secure sandbox. Let's build one from scratch.

## Creating a Function

From your project dashboard, navigate to **Functions** in the sidebar and click the **+** button.

![Creating a new function](/blog/images/hitchhikers-guide/create-new-function.png)

You have two options for creating a function:

### Option 1: Start from Scratch

Fill in the function details manually:

| Field       | Description            | Example                      |
| ----------- | ---------------------- | ---------------------------- |
| Name        | Unique identifier      | `ping_pong`                  |
| Protocol    | Trigger type           | `HTTPS`                      |
| Description | What the function does | `Returns pong to a ping`     |
| Tags        | Optional labels        | `demo, http`                 |
| Timeout     | Maximum execution time | `10s`                        |
| Memory      | Allocated memory       | `10MB`                       |
| Method      | HTTP method            | `GET`                        |
| Domain      | Which domain to use    | `GeneratedDomain`            |
| Path        | URL path trigger       | `/ping`                      |
| Source      | Code location          | `.` (inline) or library name |
| Entry Point | Function name in code  | `ping`                       |

### Option 2: Use a Template (Recommended)

Templates accelerate development by providing working examples:

1. Click **Template Select**
2. Choose a language (Go, Rust, or AssemblyScript)
3. Select a template (e.g., `ping_pong`)

![Selecting a function template](/blog/images/hitchhikers-guide/select-function-template.png)

4. The template fills in most fields automatically
5. Select your domain from the dropdown

## Understanding the Configuration

Click the **YAML** tab to see the configuration in raw format:

![Function YAML and code view](/blog/images/hitchhikers-guide/new-function-yaml-code.png)

```yaml
id: ""
description: Returns pong to a ping over HTTP
tags: []
source: .
trigger:
  type: https
  method: GET
  paths:
    - /ping
domains:
  - GeneratedDomain
execution:
  timeout: 10s
  memory: 10MB
  call: ping
```

Key fields:

- **`source`**: Use `.` for inline code or a library name for external code
- **`execution.call`**: The function name that must be exported by your WebAssembly module

> **Tip**: You can also upload a YAML configuration file by clicking the upload button in the bottom left.

## Writing the Code

Switch to the **Code** tab to view and edit your function's source code.

![Ping pong function code](/blog/images/hitchhikers-guide/pingpong-function-code.png)

Here's a simple Go ping-pong function:

```go
package lib

import (
    "github.com/taubyte/go-sdk/event"
)

//export ping
func ping(e event.Event) uint32 {
    h, err := e.HTTP()
    if err != nil {
        return 1
    }

    h.Write([]byte("PONG"))
    return 0
}
```

### Code Guidelines

1. **Package name**: Use any name **except** `main`—it's reserved for the build container
2. **Taubyte SDK**: Use `github.com/taubyte/go-sdk` for fast, low-memory operations
3. **Function export**: Annotate with `//export functionName` (TinyGo requirement)
4. **Event system**: Functions receive an `event.Event` for lightweight execution
5. **The `.taubyte` folder**: Contains build configurations—essential for proper execution

## Pushing Your Changes

Click **Done** when your function is ready, then:

1. Click the **green button** in the bottom right to push changes

![Commit and push interface](/blog/images/hitchhikers-guide/commit-and-push.png)

2. Open the **domains** folder and find `GeneratedDomain.yaml`

![Generated domain](/blog/images/hitchhikers-guide/generated-domain.png)

3. Copy the domain FQDN—you'll need it for testing
4. Enter a commit message
5. Push to GitHub

![Code commit toast notification](/blog/images/hitchhikers-guide/code-commited-toastnotification.png)

## Triggering Builds

### In Production

Pushing to GitHub automatically triggers a build via webhooks.

### In Dream (Local Development)

GitHub can't access your local nodes, so trigger builds manually:

**Terminal method:**

```bash
dream inject push-all
```

![Triggering builds with dream inject push-all](/blog/images/hitchhikers-guide/dream-inject-push-all.png)

**Console method:**

1. Go to [console.taubyte.com](https://console.taubyte.com)
2. Click **Dreamland** in the sidebar
3. Select **Network → blackhole**
4. From the top-right menu, choose **Push All**

## Monitoring Builds

Navigate to **Builds** in the sidebar. You'll see jobs for:

- **Configuration build**: Quick, processes YAML files
- **Code build**: Compiles your function to WebAssembly

![Builds page with eye and stack icons](/blog/images/hitchhikers-guide/builds-eyeicon-list-stackicon.png)

Click the **stack icon** next to a completed build to view function logs.

## Testing Your Function

### Find Your HTTP Port

First, get the substrate HTTP port:

```bash
dream status substrate
```

Output:

```bash
┌─────────────────────┬────────┬───────┐
│ substrate@blackhole │ http   │ 14529 │
└─────────────────────┴────────┴───────┘
```

### Test with cURL

Using the host header:

```bash
curl -H "Host: your-domain.blackhole.localtau" http://127.0.0.1:14529/ping
```

Output:

```bash
PONG
```

### Simplify Local Testing

Add your generated domain to `/etc/hosts` for easier testing:

```bash
sudo nano /etc/hosts
```

Add this line:

```bash
127.0.0.1 your-domain.blackhole.localtau
```

Now you can test without the Host header:

```bash
curl http://your-domain.blackhole.localtau:14529/ping
```

### Test via Console

1. Navigate to **Functions** in the sidebar

![Functions page](/blog/images/hitchhikers-guide/functions-page.png)

2. Find your function in the list
3. Click the **lightning icon** to open it in a new tab

![PONG result](/blog/images/hitchhikers-guide/pong-result.png)

## Troubleshooting

| Issue                   | Solution                                              |
| ----------------------- | ----------------------------------------------------- |
| Function not responding | Verify port matches `dream status substrate` output   |
| Build failed            | Check the **Builds** tab for error messages           |
| Changes not appearing   | Run `dream inject push-all` again                     |
| "PONG" not returning    | Ensure entry point matches the exported function name |

## Conclusion

You've now learned how to create, configure, and deploy serverless functions in Taubyte. The process is straightforward:

1. Create the function (manually or from a template)
2. Write your code in Go, Rust, or AssemblyScript
3. Push to GitHub
4. Trigger a build (automatic in production, manual in Dream)
5. Test your function

Functions compile to WebAssembly for secure, fast, and portable execution across your entire cloud infrastructure.

Next, explore [Libraries](/blog/posts/taubyte-libraries) to learn how to share code across multiple functions.
