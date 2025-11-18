---
title: Building a Full Online Marketplace with Taubyte
author: Zaoui Amine
featured: true
draft: false
tags:
  - cloud
  - ai
image:
  src: /blog/images/cloud-computing-market-trend-ai-opt.png
  alt: The Growth and Evolution of the Cloud Computing Market
summary:
  The cloud computing market is experiencing rapid growth, driven by technological advancements and the increasing demand for scalable and efficient IT solutions. With a projected CAGR of 14.1% from 2023 to 2030, this expansion is fueled by the integration of artificial intelligence (AI) within cloud platforms, enhancing capabilities in data analysis, automation, and machine learning applications. Companies like Amazon Web Services (AWS) are at the forefront, leveraging AI to drive innovation and expand their service offerings. As AI becomes more integral to cloud computing, businesses are better equipped to navigate the digital landscape, fostering operational efficiency and opening new avenues for growth and development.
date: 2024-06-27 23:14:00Z
categories: [Insights]
---
In this tutorial, we’ll go step by step through building a fully functional online marketplace using **Taubyte**. The focus is on a smooth “vibe coding” experience - local development first, then pushing to production.

---

## Step 1: Setting Up Locally and Creating a Universe

We start by creating a **local environment** using the **Dream Desktop** program.

1. Open Dream Desktop and create a **Universe**.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/5puzx0y1tayabp1x8rdc.png)
2. Connect to it via the console at [console.taubyte.com](https://console.taubyte.com).

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/d0bu7mtpljnunppkgquu.png)


3. Choose the universe, enter your email, and connect with GitHub.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/n77pdiogq0x1cwl6suii.jpg)


4. Create a project in the console.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/bd1j7fpjmv0njyj80o6i.png)



---

## Step 2: Understanding Frontend and Backend

Our marketplace has two main parts: **frontend** and **backend**.

We’ll start with the **backend**. The backend is made of **multiple services**, each responsible for a single function. Our first service is **Auth Service**.

Create an **application** for the Auth Service.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/w2y57kcyti6ts7ofdezx.png)



---

## Step 3: Pushing from Dream Desktop

Once the application is ready:

* Push all changes from Dream Desktop.
* Normally, builds are triggered automatically via a webhook from GitHub.
* Locally, simulate this webhook with a **push button** on Dream Desktop.
* This creates a **local test cloud** instead of deploying to a production node.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ohd3a6iniorgtnogqm87.png)



---

## Step 4: Creating Serverless Functions

We won’t use inline code for serverless functions - it’s messy to maintain. Instead:

* Use **Taubyte libraries** (distinct Git repos) as the code source.
* Each serverless function takes its code from the library.

Steps:

1. Push the config from the console.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/mre07nlbm5evr4decobi.png)

2. Push again from Dream Desktop.
3. Clone the backend library from GitHub.


---

## Step 5: Auth Service API

We’ll use [agents.doc](https://github.com/taubyte/agents.doc) as documentation. Prompt your AI to generate code:

```
"Create a fully functioning simple Auth CRUD API using JWT. 
Use different files for organization. 
Use only simple and necessary code. 
Use agents.doc as docs for Taubyte."
```

The AI generates:

* **Handlers & exported logic** → serverless functions.

Serverless function endpoints:

| Function   | Path                 |
| ---------- | -------------------- |
| login      | /api/auth/login      |
| register   | /api/auth/register   |
| updateUser | /api/auth/updateuser |
| deleteUser | /api/auth/deleteuser |
| getUser    | /api/auth/getuser    |

---

## Step 6: Push and Configure Serverless Functions

1. Push to GitHub, then create serverless functions in the console:

   * Set timeout and path.
   * Pick the domain.
   * Source code = backend library.
   * Entry point = exported function from Go library.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/s4hx8d6ivmpxdzjgjckf.png)


2. Push console config, then push build from Dream Desktop.

---

## Step 7: Database Setup

* Create a database from the console called `data`.
* Push again from the console after creation.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xvwwaeqmhilrelq80kcn.png)


---

## Step 8: Testing Endpoints with Curl (Using JWT)

Use the following **curl commands** to test your Auth Service:

**Register User**

```bash
curl -X POST <BASE_URL>/api/auth/register \
-H "Content-Type: application/json" \
-d '{"username":"testuser","email":"test@example.com","password":"password"}'
```

**Login User (Get JWT Token)**

```bash
curl -X POST <BASE_URL>/api/auth/login \
-H "Content-Type: application/json" \
-d '{"email":"test@example.com","password":"password"}'
```

> The response will return a JSON containing the `token`. Use this token for the next requests.

**Get User**

```bash
curl -X GET <BASE_URL>/api/auth/getuser \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-d '{"id":"<USER_ID>"}'
```

**Update User**

```bash
curl -X PUT <BASE_URL>/api/auth/updateuser \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-d '{"id":"<USER_ID>", "username":"updatedName"}'
```

**Delete User**

```bash
curl -X DELETE <BASE_URL>/api/auth/deleteuser \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-d '{"id":"<USER_ID>"}'
```


Backend library example: [tb_library_auth_service](https://github.com/ghir-hak/tb_library_auth_service)

---

## Step 9: Frontend Setup

1. Create a **global website empty repo**.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4emcall27yrdfdxbyu6r.png)


2. Push to GitHub, then open it in Dream Desktop.

3. Use **Vite + VueJS + Tailwind** to create a frontend project.

   * Keep the `.taubyte` folder created by Taubyte (essential for build).

4. Prompt AI:

```
"Use TailwindCSS to create a minimalist elegant Auth page. 
Use the .env file for the base URL. 
Use window.location.origin for API calls."
```

5. Include the **curl commands** above for reference.
6. Test locally, make tweaks, then push to GitHub to trigger a build via Dream Desktop.



---

## Step 10: Final Config Tweaks

* Add `build.sh` and `config.yaml` in `.taubyte` folder for Vite projects.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/mlmc7wznpvvrg5nlcgcy.png)


* Update serverless function domains if needed.
* Push console config and trigger build.
* Visit your website via the **lightning button** in the console.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1iluflrlgzmwoudstj9w.png)



**Important:** Ensure the **library domain** and **website domain** match. Otherwise, `window.location.origin` won’t work correctly.

---

## Conclusion

Following these steps, you now have a fully functioning **online marketplace** built on **Taubyte**, complete with backend services, JWT-secured serverless functions, a database, and a minimal VueJS + Tailwind frontend.

This approach keeps everything **modular, maintainable, and ready for production** while allowing you to **vibe code locally**.


