---
author: Zaoui Amine
date: 2026-02-17T16:00:00Z
title: 'Microservices: What Amazon Prime Video Learned the Hard Way'
featured: true
draft: false
tags:
  - microservices
  - architecture
  - infrastructure
  - performance
  - cost-optimization
  - devops
summary: 'Amazon Prime Video cut costs by 90% by moving away from microservices back to a monolith.'
categories: [Technology]
---

Microservices are everywhere. Every startup wants them. Every architect recommends them. Every conference talks about them. But here's the thing: Amazon Prime Video cut costs by 90% by moving away from microservices back to a monolith.

They published a blog post about it. The microservices overhead wasn't worth it. They moved video quality monitoring from a distributed system back to a single process. Simpler. Faster. Cheaper.

If Amazon, the company that popularized microservices, is moving back to monoliths, maybe microservices aren't always the answer.

## The Network Tax

Every microservice call goes over the network. HTTP requests. gRPC calls. Message queues. Each hop adds latency. Each hop can fail.

A monolith makes function calls. Fast. Reliable. No network involved. A microservices architecture makes network calls. Slow. Unreliable. Network involved.

I've seen systems where a single user request triggers 20+ service calls. Each call adds 1-5ms latency. That's 20-100ms just for network overhead. Before any actual work happens.

High-traffic systems make millions of these calls per day. Network bandwidth costs money. Network failures cause outages. Network latency degrades user experience.

The network is the computer. It's also the bottleneck.

## The Observability Overhead

Distributed systems need distributed tracing. You can't debug a request that spans 10 services without knowing which service failed. So teams add tracing infrastructure.

OpenTelemetry. Jaeger. Zipkin. Datadog APM. New Relic. Each service instruments itself. Each service sends traces. Storage costs explode. Query costs explode.

A monolith generates one trace per request. A microservices architecture generates 10+ spans per request. 10x the data. 10x the cost.

Logging gets complicated too. Logs are scattered across services. Teams add log aggregation. ELK stacks. Loki. CloudWatch. More infrastructure. More complexity. More cost.

Metrics multiply. Each service exposes its own metrics. Prometheus scrapes everything. Storage grows. Queries slow down. Dashboards become unreadable.

The observability tax is real. And it's expensive.

## The Service Mesh Sinkhole

Teams add service meshes to handle microservices complexity. Istio. Linkerd. Consul Connect. Each one adds sidecar proxies. Each proxy consumes CPU and memory.

Envoy, Istio's sidecar, uses 50-200 MB RAM per pod. Linkerd-proxy uses 20-100 MB. Multiply that by hundreds of pods. That's gigabytes of memory just for service mesh overhead.

mTLS encryption adds CPU overhead. Every inter-service call gets encrypted and decrypted. More CPU cycles. More latency.

Service mesh configs are complex. Virtual services. Destination rules. Traffic policies. Teams spend weeks configuring service meshes. Weeks debugging service mesh issues.

The service mesh is supposed to simplify microservices. Instead, it adds another layer of complexity. Another layer of overhead. Another layer of things that can break.

## The Amazon Prime Video Lesson

Amazon Prime Video moved video quality monitoring from microservices to a monolith. The microservices version used AWS Step Functions, Lambda, and S3. The monolith version runs in a single process.

Result: 90% cost reduction. Simpler architecture. Faster execution. Lower operational overhead.

They didn't move everything to a monolith. They moved one specific workflow. The one that didn't need to be distributed. The one that was simpler as a monolith.

The lesson: use microservices when distribution adds value. Don't use microservices when it adds overhead.

## The Deployment Complexity

Deploying a monolith is simple. Build one artifact. Deploy to one place. Test one thing. Roll back one thing.

Deploying microservices is complex. Build multiple artifacts. Deploy to multiple places. Test interactions between services. Roll back requires coordinating multiple deployments.

Teams add CI/CD pipelines. Kubernetes deployments. Helm charts. ArgoCD. More infrastructure. More complexity. More things that can break.

A simple bug fix requires deploying multiple services. A rollback requires rolling back multiple services. Coordination overhead. Risk of partial deployments. Risk of inconsistent states.

The deployment tax is real. And it slows down development.

## The Team Structure Problem

Microservices require team coordination. Service A depends on Service B. Changes to Service B break Service A. Teams need to coordinate. Teams need to communicate. Teams need to test together.

Conway's Law: organizations design systems that mirror their communication structure. Microservices architectures require microservices organizations. That means more teams. More coordination. More overhead.

Small teams can't maintain microservices effectively. They don't have enough people. They can't coordinate effectively. They end up with a distributed monolith: microservices architecture with monolith deployment practices.

Large organizations can maintain microservices. They have dedicated platform teams. They have service ownership. They have coordination processes. But most companies aren't large organizations.

## Who Actually Needs It

Microservices make sense if you have:

- Multiple independent teams that need to deploy independently
- Services with different scaling requirements
- Services with different technology stacks
- Services that need geographic distribution
- Clear service boundaries and well-defined APIs

Most applications don't have these requirements. Most teams can't maintain microservices effectively. Most microservices architectures are distributed monoliths in disguise.

If you're a small team, start with a monolith. If you're a medium team, use modular monoliths. If you're a large organization with clear service boundaries, then microservices might make sense.

But don't start with microservices "because Netflix does it." Netflix has thousands of engineers. You probably don't.

## The Honest Answer

I genuinely don't know how to feel about microservices. They solve real problems for large organizations. But most organizations aren't large.

The honest answer: if you're running fewer than 10 services with a small team, microservices are probably overkill. If you don't have clear service boundaries, microservices will become a distributed monolith. If you can't deploy services independently, you don't have microservices. You have a distributed monolith.

Start with a monolith. Extract services when you have clear boundaries. Extract services when you have independent teams. Extract services when distribution adds value.

Don't start with microservices because it's trendy. Start with what works. Extract complexity when you need it. Not before.

The goal is to ship software, not to operate the most sophisticated microservices architecture. Microservices are a tool. They're not a requirement. And for most teams, they're premature optimization.

Amazon Prime Video learned this. Maybe you should too.
