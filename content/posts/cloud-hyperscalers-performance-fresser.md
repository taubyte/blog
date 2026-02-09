---
author: Zaoui Amine
date: 2026-02-18T16:00:00Z
title: 'Performance-Fresser Series: Today: Cloud Hyperscalers'
featured: true
draft: false
tags:
  - cloud
  - aws
  - azure
  - gcp
  - infrastructure
  - performance
  - cost-optimization
categories: [Technology]
---

Cloud-first is the default. Every startup uses AWS. Every enterprise migrates to Azure. Every consultant recommends GCP. But here's the thing: 37signals went from $3.2M per year to $1.3M per year after leaving the cloud. Over $10M saved in five years.

GEICO spent a decade migrating to the cloud. Result: 2.5x higher costs. They're not alone.

The cloud isn't always cheaper. It's often more expensive. Especially when you factor in hidden costs: egress fees, managed services, vendor lock-in.

## The Egress Fee Trap

Cloud providers charge for data leaving their network. AWS charges $0.09 per GB for the first 10 TB. Azure charges $0.05-0.08 per GB. GCP charges $0.12 per GB.

That doesn't sound like much. But it adds up. High-traffic applications transfer terabytes per month. Video streaming. Data processing. API responses. Each byte costs money.

37signals was paying $50,000 per month in egress fees alone. That's $600,000 per year. Just for data leaving AWS. Their own hardware costs less than that.

Egress fees are a tax on success. The more traffic you serve, the more you pay. The more successful you are, the more expensive the cloud becomes.

Self-hosted infrastructure has no egress fees. You pay for bandwidth once. Then you use it. No per-GB charges. No surprise bills.

## The Managed Service Tax

Cloud providers sell managed services. RDS instead of PostgreSQL. ElastiCache instead of Redis. SQS instead of RabbitMQ. Each one costs more than self-hosting.

RDS costs 2-3x more than running PostgreSQL on EC2. ElastiCache costs 2-4x more than running Redis yourself. SQS costs per message. RabbitMQ is free.

Managed services are convenient. They handle backups. They handle scaling. They handle maintenance. But you pay for that convenience. And you pay a lot.

Teams choose managed services "because it's easier." But easier doesn't mean cheaper. And for many companies, cheaper matters more than easier.

## The Lock-In Problem

Once you're on a cloud provider, leaving is hard. Your infrastructure is tied to their services. Your data is in their format. Your configs use their APIs.

Migrating means rewriting everything. Rebuilding infrastructure. Retraining teams. Months of work. Millions of dollars.

Vendor lock-in is real. And it's expensive. Cloud providers know this. That's why they make it easy to get in and hard to get out.

37signals left AWS after 15 years. It took months. It cost money. But they saved $1.9M per year. The migration cost was worth it.

Most companies never leave. They're locked in. They accept rising costs. They accept vendor limitations. They accept that leaving is too expensive.

## The Hidden Costs

Cloud bills are complicated. EC2 instances. RDS databases. S3 storage. CloudFront CDN. Route 53 DNS. CloudWatch monitoring. Data transfer. API calls. Reserved instances. Spot instances. The list goes on.

Teams struggle to understand their cloud bills. They add services. They forget to remove them. They over-provision. They under-optimize. Costs creep up.

A $10,000 per month bill becomes $20,000. Then $30,000. Then $50,000. Teams don't notice until it's too late. By then, they're locked in.

Self-hosted infrastructure has predictable costs. Hardware. Bandwidth. Power. That's it. No surprise charges. No per-API-call fees. No per-GB transfer costs.

## The "Cloud-First" Cargo Cult

Every startup uses AWS. Every enterprise migrates to Azure. Every consultant recommends GCP. But why?

Teams choose cloud "because everyone does it." They don't analyze costs. They don't consider alternatives. They just follow the trend.

Cloud makes sense for some companies. Startups that need to scale quickly. Companies that need global infrastructure. Teams that don't want to manage hardware.

But cloud doesn't make sense for everyone. Companies with predictable workloads. Companies with data sovereignty requirements. Companies that can self-host cheaper.

The "cloud-first" mentality ignores alternatives. It assumes cloud is always better. It's not. Sometimes self-hosting is cheaper. Sometimes self-hosting is simpler. Sometimes self-hosting is better.

## Who Actually Needs It

Cloud makes sense if you have:

- Unpredictable workloads that need to scale quickly
- Global infrastructure requirements
- Teams that don't want to manage hardware
- Compliance requirements that cloud providers meet
- Budget for cloud premium pricing

Most companies don't have these requirements. Most companies have predictable workloads. Most companies can self-host cheaper. Most companies just follow the trend.

If you're a startup with unpredictable growth, cloud makes sense. If you're an enterprise with predictable workloads, self-hosting might be cheaper. If you're somewhere in between, analyze costs. Don't assume cloud is always better.

