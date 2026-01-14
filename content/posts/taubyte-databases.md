---
title: "Key-Value Databases in Taubyte"
author: Zaoui Amine
featured: true
draft: false
tags:
  - tutorials
  - databases
  - key-value
  - serverless
  - cloud
image:
  src: /blog/images/taubyte-databases.png
  alt: Key-Value Databases in Taubyte
summary: Add structured data storage to your Taubyte applications with key-value databases. Like storage, databases are created on-the-fly when first used—enabling dynamic, multi-tenant data isolation without extra configuration.
date: 2025-01-14T12:00:00Z
categories: [Hand-on Learning]
---

Taubyte provides **key-value databases** that you can access directly from your serverless functions. Like storage, databases are instantiated on-the-fly when first used—enabling dynamic, multi-tenant data isolation without manually creating each database instance.

## Creating a Database

From the sidebar, navigate to **Databases** and click the **+** button.

Configure your database:

| Field | Description | Example |
|-------|-------------|---------|
| Name | Unique identifier | `example_kv_store` |
| Matcher | Path pattern | `/example/kv` |
| Min Replication | Minimum copies | `1` |
| Max Replication | Maximum copies | `2` |
| Size | Maximum capacity | `100MB` |

Click **Validate** to save.

### Understanding Matchers

Just like storage, the matcher can be any string or regular expression. Using a path-like format (e.g., `/example/kv`) keeps things organized and readable.

> **Note**: This configuration only exists locally in your browser's virtual file system. Click the **green button** to push it to GitHub.

## How Databases Work

Taubyte databases are **instantiated on-the-fly** the first time you use them. This enables powerful patterns:

**Static matcher**:
```
/example/kv
```

**Dynamic matcher (regex)**:
```
profile/history/[a-zA-Z0-9]+
```

With the regex matcher:
- `profile/history/userA` → Creates a database for User A
- `profile/history/userB` → Creates a separate database for User B

This is incredibly useful for **multi-user applications**—you can isolate data per user without manually creating each database.

## Building Database Functions

Let's create two functions to interact with our database:
1. **KV Set**: Store a key-value pair
2. **KV Get**: Retrieve a value by key

### Set Function

Navigate to **Functions** and click **+**:

| Field | Value |
|-------|-------|
| Name | `kv_set` |
| Memory | `10MB` |
| Method | `POST` |
| Path | `/api/kv` |
| Entry Point | `set` |

Switch to the **Code** tab and paste:

```go
package lib

import (
    "encoding/json"

    "github.com/taubyte/go-sdk/database"
    "github.com/taubyte/go-sdk/event"
    http "github.com/taubyte/go-sdk/http/event"
)

func fail(h http.Event, err error, code int) uint32 {
    h.Write([]byte(err.Error()))
    h.Return(code)
    return 1
}

type Req struct {
    Key   string `json:"key"`
    Value string `json:"value"`
}

//export set
func set(e event.Event) uint32 {
    h, err := e.HTTP()
    if err != nil {
        return 1
    }

    // (Create) & Open the database
    db, err := database.New("/example/kv")
    if err != nil {
        return fail(h, err, 500)
    }

    // Decode the request body
    reqDec := json.NewDecoder(h.Body())
    defer h.Body().Close()

    // Decode the request body
    var req Req
    err = reqDec.Decode(&req)
    if err != nil {
        return fail(h, err, 500)
    }

    // Put the key/value into the database
    err = db.Put(req.Key, []byte(req.Value))
    if err != nil {
        return fail(h, err, 500)
    }

    return 0
}
```

Validate and push the function.

### Get Function

Clone the `kv_set` function and modify:

| Field | Value |
|-------|-------|
| Name | `kv_get` |
| Method | `GET` |
| Entry Point | `get` |

Update the code:

```go
package lib

import (
    "github.com/taubyte/go-sdk/database"
    "github.com/taubyte/go-sdk/event"
    http "github.com/taubyte/go-sdk/http/event"
)

func fail(h http.Event, err error, code int) uint32 {
    h.Write([]byte(err.Error()))
    h.Return(code)
    return 1
}

//export get
func get(e event.Event) uint32 {
    h, err := e.HTTP()
    if err != nil {
        return 1
    }

    key, err := h.Query().Get("key")
    if err != nil {
        return fail(h, err, 400)
    }

    db, err := database.New("/example/kv")
    if err != nil {
        return fail(h, err, 500)
    }

    value, err := db.Get(key)
    if err != nil {
        return fail(h, err, 500)
    }

    h.Write(value)
    h.Return(200)

    return 0
}
```

Validate and push.

## Building and Testing

Trigger the build:

```bash
dream inject push-all
```

### Test Set

Once the build is done, you can test the function by sending a POST request to the endpoint:

```bash
curl -X POST http://your-domain.blackhole.localtau:14529/api/kv -H "Content-Type: application/json" -d '{
  "key": "message",
  "value": "hello world!"
}'
```

> **Note**: Replace `your-domain.blackhole.localtau` with your own domain and `14529` with your own port.

Unless the curl fails, we now have a key `message` that contains `hello world!` in our database.

### Test Get

Wait for the build to finish, then test the function by sending a GET request to the endpoint:

```bash
curl http://your-domain.blackhole.localtau:14529/api/kv?key=message
```

Output:

```
hello world!
```

## Advanced: Per-User Databases

Here's how to implement isolated databases per user:

### Database Configuration

Create a database with a regex matcher:
```
user/data/.*
```

### User-Scoped Functions

```go
package lib

import (
    "encoding/json"
    "github.com/taubyte/go-sdk/database"
    "github.com/taubyte/go-sdk/event"
)

type UserDataRequest struct {
    UserID string `json:"user_id"`
    Key    string `json:"key"`
    Value  string `json:"value"`
}

//export userSet
func userSet(e event.Event) uint32 {
    h, err := e.HTTP()
    if err != nil {
        return 1
    }

    body := h.Body()
    defer body.Close()
    
    var req UserDataRequest
    if err := json.NewDecoder(body).Decode(&req); err != nil {
        h.Write([]byte(`{"error": "invalid request"}`))
        return 1
    }

    // Dynamic database path per user
    dbPath := "user/data/" + req.UserID
    
    db, err := database.Open(dbPath)
    if err != nil {
        h.Write([]byte(`{"error": "failed to open database"}`))
        return 1
    }
    defer db.Close()

    db.Put(req.Key, []byte(req.Value))
    h.Write([]byte(`{"status": "stored for user ` + req.UserID + `"}`))
    return 0
}
```

This creates **isolated databases per user**:
- `user/data/alice` → Alice's database (created on first use)
- `user/data/bob` → Bob's database (created on first use)

## Database Operations

| Operation | Method | Description |
|-----------|--------|-------------|
| `Open(path)` | - | Open or create a database |
| `Put(key, value)` | - | Store a key-value pair |
| `Get(key)` | - | Retrieve value by key |
| `Delete(key)` | - | Remove a key-value pair |
| `List(prefix)` | - | List keys with prefix |
| `Close()` | - | Close database connection |


## Replication

The replication settings control data durability:

| Setting | Description |
|---------|-------------|
| **Min Replication** | Minimum copies across nodes |
| **Max Replication** | Maximum copies for redundancy |

Higher replication = more durability, more storage used.

## Conclusion

You've learned how to:

1. **Create databases** with configurable replication
2. **Build set/get functions** for key-value operations
3. **Use dynamic matchers** for per-user data isolation

Taubyte's on-the-fly database creation eliminates the need to pre-provision databases, making it perfect for dynamic, multi-tenant applications.

Next, explore [Messaging with Pub/Sub](/blog/posts/messaging-pubsub-taubyte) for real-time communication.

