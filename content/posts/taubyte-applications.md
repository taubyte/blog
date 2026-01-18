---
title: "Organizing Resources with Taubyte Applications"
author: Zaoui Amine
featured: true
draft: false
tags:
  - tutorials
  - applications
  - organization
  - serverless
  - cloud
image:
  src: /blog/images/taubyte-applications.png
  alt: Organizing Resources with Taubyte Applications
summary: Applications in Taubyte let you group resources under logical units for better organization and access control. Learn how to create applications and scope resources to them while maintaining access to global resources.
date: 2026-01-14T16:00:00Z
categories: [Hand-on Learning]
---

In Taubyte, resources can have either **global scope**—accessible from anywhere in your project—or **application scope**—contained within a specific application. **Applications** let you group resources under logical units for better organization, granular access control, and clearer project structure as your system grows.

## What Are Applications?

Applications are organizational containers within your Taubyte project. Each application:

- Has access to its **own resources** plus any **global resources**
- Provides logical separation between different parts of your system
- Enables granular access control and management
- Can have unique settings for databases, functions, and more

### Example Use Cases

| Application | Purpose |
|-------------|---------|
| `backend` | API services and business logic |
| `admin` | Admin dashboard and management functions |
| `public-api` | Customer-facing API endpoints |
| `analytics` | Data processing and reporting |

## Creating an Application

From the sidebar, navigate to **Applications** and click the **+** button.

Fill in the details:

| Field | Description | Example |
|-------|-------------|---------|
| Name | Application identifier | `backend` |
| Description | What this application does | `Backend API services` |

Click **Validate** to save.

Your application will now appear in the list.

### Pushing Changes

Changes are saved locally in your browser's virtual file system. To persist them:

1. Click the **green button** in the bottom right corner
2. Enter a commit message
3. Click **Finish**

> **Tip**: You don't need to push immediately. Continue working and push when you're ready.

## Adding Resources to an Application

Click on the **application's name** to open it.

Inside an application, you can define the same types of resources you would globally:
- Functions
- Databases
- Websites
- Storage
- Messaging

### Creating an Application-Scoped Function

1. Go to the **Functions** tab within your application
2. Click the **+** button
3. Select the **ping_pong** template
4. Set the domain to your generated domain
5. Set the path to `/backend/ping`

> **Note**: The path doesn't need to include the application name—you can use any path.

Switch to the **Code** tab and customize:

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

    h.Write([]byte("PONG from backend application!"))
    return 0
```

Click **Validate** to save.

### Pushing and Building

Push your code—the new function will appear with a "1+ change" indicator.

Add a commit message and click **Finish**.

If using Dream locally, trigger a build:

```bash
dream inject push-all
```

### Testing

Once the build finishes, click the **lightning icon** to open the function's HTTP endpoint.

If it doesn't open, ensure your generated domain is in your `/etc/hosts` file.

The function should return:
```bash
PONG from backend application!
```

## Resource Visibility

Here's how resource visibility works with applications:

```bash
┌─────────────────────────────────────────────────────────────┐
│                         PROJECT                              │
├─────────────────────────────────────────────────────────────┤
│  GLOBAL RESOURCES                                            │
│  ├── shared_database                                         │
│  ├── common_functions                                        │
│  └── main_website                                            │
├─────────────────────────────────────────────────────────────┤
│  APPLICATION: backend                                        │
│  ├── Can access: ALL global resources                        │
│  ├── backend_database (application-scoped)                   │
│  └── api_functions (application-scoped)                      │
├─────────────────────────────────────────────────────────────┤
│  APPLICATION: admin                                          │
│  ├── Can access: ALL global resources                        │
│  ├── admin_database (application-scoped)                     │
│  └── admin_functions (application-scoped)                    │
└─────────────────────────────────────────────────────────────┘
```

Key points:
- Applications **can access global resources**
- Applications **cannot access other applications' resources**
- Global resources are **shared across all applications**


## Benefits of Using Applications

| Benefit | Description |
|---------|-------------|
| **Organization** | Group related resources logically |
| **Access Control** | Isolate sensitive resources |
| **Team Collaboration** | Different teams can own different applications |
| **Maintainability** | Easier to navigate large projects |
| **Scalability** | Add applications as your project grows |

## When to Use Applications

| Scenario | Recommendation |
|----------|----------------|
| Simple project (<10 resources) | Global resources only |
| Multiple API domains | Separate applications |
| Different access requirements | Applications for isolation |
| Microservices architecture | One application per service |
| Team boundaries | One application per team |

## Conclusion

You've learned how to:

1. **Create applications** to organize resources
2. **Add functions** within applications
3. **Understand visibility** between global and application-scoped resources

Applications provide a clean way to structure your project as it grows, enabling better organization and access control without sacrificing the ability to share common resources.

Next, learn about the [CI/CD system](/blog/posts/cicd-taubyte) that builds and deploys your code automatically.

