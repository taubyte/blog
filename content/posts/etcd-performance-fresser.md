---
author: Zaoui Amine
date: 2026-02-19T16:00:00Z
title: 'etcd: The Consensus Tax You''re Probably Paying For Nothing'
featured: true
draft: false
tags:
  - etcd
  - kubernetes
  - distributed-systems
  - consensus
  - infrastructure
  - performance
categories: [Technology]
---

etcd sits at the heart of Kubernetes. Before your applications run, etcd is storing cluster state, coordinating elections, and replicating data. It consumes 2-8 GB RAM per node. It requires 3-5 nodes for high availability. That's 6-40 GB RAM just for cluster coordination.

Most teams don't need distributed consensus. Most teams don't need high availability at the cluster level. Most teams are running small clusters that would work fine with a single node and backups.

But Kubernetes requires etcd. So teams run etcd. They pay the consensus tax. They accept the complexity. They accept the overhead.

## The Consensus Tax

Distributed consensus is expensive. etcd uses the Raft algorithm. It requires 3-5 nodes. Each node stores a full copy of the cluster state. Each node participates in consensus. Each node consumes memory and CPU.

A 3-node etcd cluster needs 6-24 GB RAM total. Plus CPU for consensus operations. Plus network bandwidth for replication. Plus disk I/O for persistence.

All of this before your applications run. All of this just for cluster coordination. All of this overhead.

Single-node systems don't need consensus. They're simpler. They're faster. They use fewer resources. But they're not "highly available." So teams choose etcd instead.

## The HA Illusion

High availability sounds good. But what are you making highly available? The cluster coordination layer? Is that what's important?

Most applications don't need cluster-level HA. Application-level HA is different. Load balancers. Multiple application instances. Database replication. These provide HA where it matters.

Cluster coordination HA protects against etcd failures. But etcd failures are rare. And when etcd fails, the whole cluster fails anyway. So what are you protecting against?

Teams choose etcd "because we need HA." But they don't need HA at the cluster coordination level. They need HA at the application level. Those are different things.

## The Small Cluster Problem

etcd makes sense for large clusters. Hundreds of nodes. Thousands of pods. Complex coordination requirements. But most clusters are small.

A typical Kubernetes cluster has 3-10 nodes. Maybe 20-50 pods. Simple coordination requirements. etcd is overkill.

Small clusters don't need distributed consensus. They don't need 3-node etcd clusters. They don't need the overhead. They need simple coordination. Or no coordination at all.

Teams run etcd because Kubernetes requires it. But they don't need what etcd provides. They're paying for consensus they don't use.

## The Memory Overhead

etcd stores cluster state. Every pod. Every service. Every config map. Every secret. Everything gets stored in etcd. Memory usage grows with cluster size.

A small cluster might use 2-4 GB RAM for etcd. A medium cluster: 4-8 GB. A large cluster: 8-16 GB. Per node. Multiply by 3-5 nodes. That's 6-80 GB RAM just for etcd.

Most applications don't need this much coordination. Most applications can coordinate through databases. Through message queues. Through simpler mechanisms.

But Kubernetes requires etcd. So teams run etcd. They accept the memory overhead. They accept the cost.

## The Complexity Explosion

etcd adds complexity. Cluster formation. Node failures. Split-brain scenarios. Backup and restore. Upgrades. All of this is complex.

Teams need to understand Raft. They need to monitor etcd health. They need to handle etcd failures. They need to backup etcd data. They need to restore etcd from backups.

All of this complexity. All of this operational burden. All for cluster coordination that most teams don't need.

Single-node systems are simpler. No cluster formation. No split-brain scenarios. No consensus overhead. Just backups. That's it.

## Who Actually Needs It

etcd makes sense if you have:

- Large clusters with hundreds of nodes
- Complex coordination requirements
- Need for cluster-level high availability
- Teams that can operate distributed systems

Most teams don't have these requirements. Most teams have small clusters. Most teams don't need cluster-level HA. Most teams can't operate distributed systems effectively.

If you're running a small cluster, consider alternatives. Single-node Kubernetes. Docker Swarm. Nomad. Simpler orchestration. Less overhead. Less complexity.

If you're running Kubernetes, you're stuck with etcd. But understand what you're paying for. Understand the overhead. Understand that most teams don't need what etcd provides.

## The Kubernetes Dependency

Kubernetes requires etcd. There's no way around it. If you want Kubernetes, you get etcd. You pay the consensus tax. You accept the overhead.

But do you need Kubernetes? Most teams don't. Most teams can use simpler orchestration. Most teams can avoid etcd entirely.

If you need Kubernetes, you need etcd. But if you don't need Kubernetes, you don't need etcd. The question is: do you need Kubernetes?

Most teams don't. They choose Kubernetes because it's popular. They get etcd as a side effect. They pay the consensus tax without needing consensus.

## The Honest Answer

If you're running fewer than 20 nodes, etcd is probably overkill. If you don't need cluster-level HA, etcd is probably overkill. If you can't operate distributed systems, etcd is probably overkill.

But if you're running Kubernetes, you're stuck with etcd. Kubernetes requires it. There's no alternative.

The real question is: do you need Kubernetes? If you don't, you don't need etcd. If you do, you need etcd. But understand what you're paying for. Understand the overhead. Understand that most teams don't need what etcd provides.

The goal is to orchestrate applications, not to operate the most sophisticated consensus system. etcd is a tool. It's required for Kubernetes. But Kubernetes isn't required for most teams.

Most teams can avoid etcd by avoiding Kubernetes. Most teams can use simpler orchestration. Most teams can avoid the consensus tax entirely.

But if you're running Kubernetes, you're running etcd. You're paying the tax. You're accepting the overhead. Just understand what you're getting. And what you're paying for.
