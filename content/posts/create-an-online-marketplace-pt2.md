---
title: Building a Full Online Marketplace with Taubyte pt2
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
In the first episode, we built the **AuthService** - the backbone of user **authentication** in our Taubyte-powered marketplace.
Today, we move to the **UserService**, the part of the backend responsible for **user profiles, settings, password changes, and preferences**.

Just like before, everything is created locally using **Dream Desktop**, then pushed and deployed through **console.taubyte.com**, following the same “local first → production later” workflow.

---

## **1. Start Your Universe**

Before anything else, start the same universe we created in Part 1.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ul1xoi3e8ho7d0t0u32t.jpg)



Open **console.taubyte.com**, select your universe, and enter the dashboard.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/5sz9pehmv1uubigjn4p7.png)


---

## **2. Create the UserService Application**

Inside the Applications tab, create a new **UserService** library.
This service will handle:

* Fetching the user profile
* Updating profile details
* Changing password
* Updating language / notification / display preferences


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/o2la92ra1qxu2qjl2btj.jpg)



Just like AuthService, we don’t write inline code.
We create a dedicated backend library.

---

## **3. Create the Backend Library (Golang)**

Create a new **Golang library** named **user-service**.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/7nm2q3zhgxauo5pry4wb.png)



Push from Dream Desktop to generate the config + code build jobs.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ae6oouw7qi4tvbe13sv0.jpg)



Once both jobs succeed, open your editor (Cursor) and clone the repo:


```bash
git clone https://github.com/.../tb_library_user_service
```

Rename the entry file, tidy dependencies:

```bash
go mod tidy
```

Now the library is ready for code.

---

## **4. Use AI to Generate the UserService Code**

Inside Cursor,clone the library repository then prompt the AI with the following:

```
Create a CRUD user service with these routes:
- get user profile
- update profile
- change password
- update preferences (language, notifications, display)

Use this model:
User {
  ID (same as Auth service)
  name
  email
  phone
  address
  preferences { language, notifications, display }
  role (buyer, seller, admin)
}

Use the planning method.
```

AI generates the plan, then builds:

* `model.go`
* `jwt.go` (token validation copied from AuthService)
* `database.go`
* `utils.go`
* `handlers.go` with 4 exported functions:

  * `GetUserProfile`
  * `UpdateUserProfile`
  * `ChangePassword`
  * `UpdatePreferences`

You now have a complete backend.

Push it:

```bash
git add .
git commit -m "Initial user service"
git push
```

---

## **5. Create Serverless Functions in the Console**

Go to **Functions → Create Function** and create four serverless functions,
each using the **user-service** library as the source and the exported handler as the entry point.

### **1. Get User Profile**

* **Method:** GET
* **Path:** `/api/users`
* **Entry point:** `GetUserProfile`

### **2. Update User Profile**

* **Method:** PUT
* **Path:** `/api/users`
* **Entry point:** `UpdateUserProfile`

### **3. Change Password**

* **Method:** PUT
* **Path:** `/api/users/password`
* **Entry point:** `ChangePassword`

### **4. Update Preferences**

* **Method:** PUT
* **Path:** `/api/users/preferences`
* **Entry point:** `UpdatePreferences`


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/89eyvmzg9fa9hpwhyh6v.png)



Push the config from the console, then push again from Dream Desktop to trigger builds.

---

## **6. Test the Endpoints with Curl**

Remember: all UserService routes are protected.
You must log in first → get a token → use it in Authorization header.

### **Login to get token (from Part 1)**

```bash
curl -X POST https://YOUR_DOMAIN/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"123456"}'
```

Response:

```json
{"token":"YOUR_JWT_TOKEN"}
```

Use this token in all next requests:

```
-H "Authorization: Bearer YOUR_JWT_TOKEN"
```

---

### **1. Get Profile**

```bash
curl -X GET https://YOUR_DOMAIN/api/users \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

---

### **2. Update Profile**

```bash
curl -X PUT https://YOUR_DOMAIN/api/users \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "id":"user id",
    "name":"New ,
    "email":"new@mail.com",
    "phone":"0555000000",
    "address":"New address"
  }'
```

---

### **3. Change Password**

```bash
curl -X PUT https://YOUR_DOMAIN/api/users/password \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "oldPassword":"123456",
    "newPassword":"abcdef"
  }'
```

---

### **4. Update Preferences**

```bash
curl -X PUT https://YOUR_DOMAIN/api/users/preferences \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "language":"en",
    "notifications":true,
    "display":"dark"
  }'
```

---

## **7. Build the Frontend for UserService**

Now that the backend is ready, we extend the frontend (created in Part 1).

Open Cursor and prompt:

```
Continue implementing the UserService frontend.
Use the token from login and call all CRUD endpoints.
Use environment variables for BASE_URL.
Update dashboard UI.
```

AI generates:

* API client functions
* UI logic
* Form components
* Error handling

Push the frontend to github:

```bash
git add .
git commit -m "UserService frontend"
git push
```

Trigger a build from Dream Desktop.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/0ffjbvg0s4pfaeeyu5gc.jpg)



If the build fails, copy the error logs → paste into AI → fix → push again.

Once the job succeeds, visit your deployed website using the lightning button next to the website on the right.

---

## **8. Full Frontend Flow**

* Register
* Login
* Token stored
* Token used for all secure requests
* Profile loads correctly
* Updating profile works
* Changing password works
* Preferences update instantly


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/83f6qy3msqynk0bjmhrg.jpg)



---

## **Conclusion**

In **Part 2**, we created a complete **UserService**:

* Backend library
* AI-generated CRUD logic
* JWT-protected routes
* Serverless functions
* Curl-tested endpoints
* Frontend integration

Your marketplace now has:

* **Authentication**
* **User profiles**
* **Preferences system**

