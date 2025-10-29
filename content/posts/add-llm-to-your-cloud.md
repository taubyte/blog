---
author: Samy Fodil
date: 2023-07-25T16:00:00Z
title: Add LLAMA Capability to Your Cloud
featured: true
draft: false
tags:
  - tutorials
  - llm
  - llama
  - wasm
  - golang
  - cloud
image:
  src: images/decapcms.png
  alt: Decap CMS
summary:
  Add LLAMA Capability to Your Cloud
categories: [Tutorials]
---


In this article, I'll go over how to use the LLM (or GPT) capabilities of [taubyte-llama-satellite](https://github.com/samyfodil/taubyte-llama-satellite). I'm assuming that you already know how to create a project and a function on a Taubyte-based Cloud Computing Network. If not, please refer to [Taubyte's Documentation](https://tau.how/guides/build/02-guide/01-create-project/).

## LLAMA Satellite
A Taubyte Cloud can provide LLM capabilities through what we call a Satellite. In this case it's [taubyte-llama-satellite](https://github.com/samyfodil/taubyte-llama-satellite) which exports llama.cpp capabilities to the Taubyte Virtual Machine, thus giving Serverless Functions (or DFunctions, as per Taubyte's terminology) LLM features.

## LLAMA SDK
Satellites export low-level functions that aren't very intuitive to use directly. Fortunately, it's possible to address that with a user-friendly SDK. The [Go](https://go.dev/) SDK for taubyte-llama-satellite](https://github.com/samyfodil/taubyte-llama-satellite) can be found [here](https://github.com/samyfodil/taubyte-llama-satellite/tree/main/sdk).

## Get Ready
Before proceeding, let's ensure you have a project and a DFunction ready to go. If not, please refer to ["Create a Function"](https://tau.how/guides/build/02-guide/02-create-a-dfunc/).

## Let's Code!
A good practice is to clone your code locally using git or the tau command-line. Make sure you have [Go](https://go.dev/) installed, then run:
```bash
go get github.com/samyfodil/taubyte-llama-satellite
```

### Our Basic Function
If you followed the steps from [Taubyte's Documentation](https://tau.how/guides/build/02-guide/01-create-project/), your basic function should look something like this:
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

Let's modify it so it uses the POST body as the prompt. Note: I've changed the function's name to `predict`. Ensure this change is reflected in your configuration by setting the `entry point` to `predict` and modifying the `method` from `GET` to `POST`.

```go
package lib

import (
	"github.com/taubyte/go-sdk/event"
  "io"
)

//export predict
func predict(e event.Event) uint32 {
	h, err := e.HTTP()
	if err != nil {
		return 1
	}
	defer h.Body().Close()

	prompt, err := io.ReadAll(h.Body())
	if err != nil {
		panic(err)
	}

	return 0
}
```

### Predict
The LLAMA SDK exports two main methods, [`Predict`](https://pkg.go.dev/github.com/samyfodil/taubyte-llama-satellite/sdk#Predict) and [`Next`](https://pkg.go.dev/github.com/samyfodil/taubyte-llama-satellite/sdk#Prediction.Next). Let's start by creating a prediction:

```go
package lib

import (
	"github.com/taubyte/go-sdk/event"
  "github.com/samyfodil/taubyte-llama-satellite/sdk"
  "io"
)

//export predict
func predict(e event.Event) uint32 {
	h, err := e.HTTP()
	if err != nil {
		return 1
	}
	defer h.Body().Close()

	prompt, err := io.ReadAll(h.Body())
	if err != nil {
		panic(err)
	}

	p, err := sdk.Predict(
		string(prompt),
	)
	if err != nil {
		panic(err)
	}

	return 0
}
```

This code will submit a request for a prediction to the satellite, which will put it in a queue because predictions are resource-intensive (especially on the GPU), and return a [prediction](https://pkg.go.dev/github.com/samyfodil/taubyte-llama-satellite/sdk#Prediction).

Just like when interacting with any LLM, you can customize the request like so:

```go
p, err := sdk.Predict(
  string(prompt),
  sdk.WithTopK(90),
  sdk.WithTopP(0.86),
  sdk.WithBatch(512),
)
```

You can find all possible options [here](https://pkg.go.dev/github.com/samyfodil/taubyte-llama-satellite/sdk#Option).

### Get Tokens
After submitting a prediction to the satellite, you need to collect tokens. You can do so by calling `p.Next()`, which will block until a new token is available or the prediction is completed or canceled. Note that you can use [`NextWithTimeout`](https://pkg.go.dev/github.com/samyfodil/taubyte-llama-satellite/sdk#Prediction.NextWithTimeout) if you'd like to set a deadline.

Now, let's wrap up our function:

```go
package lib

import (
	"github.com/taubyte/go-sdk/event"
  "github.com/samyf

odil/taubyte-llama-satellite/sdk"
  "io"
)

//export predict
func predict(e event.Event) uint32 {
	h, err := e.HTTP()
	if err != nil {
		return 1
	}
	defer h.Body().Close()

	prompt, err := io.ReadAll(h.Body())
	if err != nil {
		panic(err)
	}

	p, err := sdk.Predict(
		string(prompt),
		sdk.WithTopK(90),
		sdk.WithTopP(0.86),
		sdk.WithBatch(512),
	)
	if err != nil {
		panic(err)
	}

	for {
		token, err := p.Next()
		if err == io.EOF {
			break
		} else if err != nil {
			panic(err)
		}
		h.Write([]byte(token))
		h.Flush() //flush
	}

	return 0
}
```

The call to `h.Flush()` will send the token to the client (browser) immediately. If you'd like to recreate the AI typing experience provided by ChatGPT, you can use something like:

```js
await axios({
  method: "post",
  data: prompt,
  url: "<URL>",
  onDownloadProgress: (progressEvent) => {
    const chunk = progressEvent.currentTarget.responseText;
    gotToken(chunk);
  },
})
```

## Conclusion
In this guide, we've walked through how to leverage the LLM (or GPT) capabilities provided by 8ws on a Taubyte-based Cloud Computing Network. We've explored the concept of a LLAMA Satellite and its role in exporting LLM capabilities to the Taubyte Virtual Machine. Furthermore, we've discussed the importance and functionality of the LLAMA SDK, which makes interacting with the Satellite's low-level functions more intuitive.

We've gone through a practical example of how to use these tools in a Taubyte project, specifically demonstrating how to fetch tokens and use the Predict method. We've also shown how you can fine-tune your requests to the SDK and manage the tokens returned by the Satellite. By the end of the guide, you should be equipped to create a serverless function on Taubyte that can generate predictions from user-provided prompts, similar to how AI like ChatGPT works.

Harnessing the power of Taubyte and the LLAMA Satellite, you're now ready to incorporate large language model capabilities into your projects, bringing a new level of interactivity and AI-driven responses to your applications.

