---
title: "Automaton Server: Part 0 - Series Introduction"
slug: automaton-server-part-0-series-introduction
description: "Automation Server: Series Introduction"
author: Mircea-Pavel Anton
date: "2022-10-10"

cover:
  image: gifs/the-machines-have-taken-over.gif
  caption: <a href="https://giphy.com/abbeyluck">©️ Abbety Luck</a>

draft: true

tags:
  - Ansible
  - Automation
  - Docker
  - Docker Swarm
  - Traefik
  - Portainer
  - Hashicorp
  - GitLab
  - MinIO
  - Homer
---

## Series

- Part 0: Series Introduction
- [Part 1: Configuring the Host](#TODO)   <!-- TODO Add Link once part 1 goes live -->
- [Part 2: Deploying Traefik](#TODO)      <!-- TODO Add Link once part 2 goes live -->
- [Part 3: Deploying Portainer](#TODO)    <!-- TODO Add Link once part 3 goes live -->
- [Part 4: Deploying Vault](#TODO)        <!-- TODO Add Link once part 4 goes live -->
- [Part 5: Deploying Jenkins](#TODO)      <!-- TODO Add Link once part 5 goes live -->
- [Part 6: Deploying MinIO](#TODO)        <!-- TODO Add Link once part 6 goes live -->
- [Part 7: Deploying GitLab](#TODO)       <!-- TODO Add Link once part 7 goes live -->
- [Part 8: Deploying Homer](#TODO)        <!-- TODO Add Link once part 8 goes live -->
- [Part 9: Managing The services](#TODO)  <!-- TODO Add Link once part 9 goes live -->
- [Part 10: Backup and Restore](#TODO)    <!-- TODO Add Link once part 10 goes live -->

## Overview

Infrastructure as Code, also known as IaC is the process of automating the management and provisioning of infrastructure through machine-readable files and configurations.

The main benefits of IaC, from our point of view, are:

- **repeatability**: we can always re-run a playbook/script
- **transparency**: everything is clearly laid out in a `*.yaml` file
- **speed**: automated processes are much faster than their manual counterparts
- **reduced risks**: manual processes are much more error-prone as opposed to automated ones

## Prerequisites

A dedicated server with:

- at least quad-core CPU;
- at least 4GB of RAM, 8GB or more recommended;
- at least 32GB of disk space, more is recommended;
- at least 1 NIC, 2 or more recommended,
- Ubuntu 22.04 installed

### Personal Setup

In my homelab, I am deploying this on a dedicated server rocking:

- a mighty quad-core i5 6500;
- AsRock H270m motherboard;
- 2x8GB RAM booting;
- Crucial BX500 240GB SSD;
- InterTech 2U-20240 rackmount case;
- dual 80mm Noctua fans as intakes;
- Intel Stock Cooler; 😅
- BeQuiet TFX 300W PSU (with a 3D printed adapter).

## Introduction

I relatively recently upgraded my main virtualization server from a core i7 9700K (8-core 8-thread CPU) to an i9 7900X (10 cores 20 threads).

After making this upgrade, I realized that this new chip that I bought can single-handedly run all the workloads I previously spread across 3 different servers in my Homelab. As such, I started the process of scaling down my "data center" to a single *"production"* server.

As part of scaling down, I also made the decision to do things properly this time around, since in the meantime I also became a DevOps engineer.

Deploying everything manually without documenting anything was, as my past experiences proved time and time again, a very not ideal solution. While I could make the incremental improvement of manual deployment WITH documentation this time, I wanted to deploy everything in an automated way, via Infrastructure-as-Code.

This will not only be a great addition to my homelab in terms of security, documentation, and peace of mind, but it will also be a tremendous learning experience 🤓.

## How does it actually work?

We are going to configure our server to be an automation server. It will run all of the workloads, ssh into our other servers, and push configurations to them.

To actually run out automation tasks, we will be using mostly Ansible, Terraform, and Packer. To create all the supporting infrastructure for an IaC workflow, we are going to need to deploy a few services to this server, to help us on our journey.

Since we are working with limited resources and are extremely unlikely to scale out to multiple servers, we are going to go with Docker on this one, as opposed to k3s. All of the services we will deploy will be handled in `docker-compose.yml` files.

Now that the base infrastructure is out of the way... What services are we actually going to deploy?

### The Services

The actual services we are deploying can be split up into 3 main categories:

- Management Services
- Utility Services
- DevOps Services

#### Management Services

In terms of the management of our Docker services, we are looking at 2 requirements:

1. Managing the network traffic in and out of our Docker host
2. Managing the containers running on our Docker host

##### Traffic Management

To manage the traffic that comes in and out of our host, we are going to need a reverse proxy.  There are a bunch of options for this, but my personal favorite has always been **Traefik**.

##### Container Management

Once Traefik has been deployed, another service I usually set up is **Portainer**. I don't set this up for managing the cluster, but for monitoring it. When it comes to making changes, I much prefer doing it from the command line (or even better via IaC). However, for visualization, I think Portainer delivers a good-looking dashboard with lots of visibility.

##### Homer

Since the list of services we are deploying is not particularly small and I hate remembering (and typing in) URLs, we are also going to add a dashboard to our stack. My favorite dashboard and one I almost always set up on any docker host I manage is **Homer**.

### DevOps Services

From the point of view of a typical DevOps workflow, we need:

1. A git server to store our configurations (preferably with some CI/CD support)
2. A CI/CD server to schedule and run our jobs
3. Some secret storage for passwords, tokens, and whatnot

#### The git server

For our git server, I ultimately decided to go with **GitLab**. While it is a heavier weight option when compared to others, like Gitea, it is also way more feature rich.

Some of the features that tipped the scales towards it are:

- built-in docker image registry
- built-in Terraform module registry
- support for CI/CD via GitLab runners

#### The CI/CD server

You can't spell automation without **Jenkins**, so that's the next service we'll add to the stack. I think this is pretty self-explanatory, so I will not go into much detail.

All that I will say here, is that, while we also have the option of using GitLab CI, I much prefer Jenkins for scheduling our automation tasks and for running longer jobs. My preference is to use GitLab CI for running validation tests on merge requests and then Jenkins pipelines to actually push our configurations to the servers.

#### Secret Storage

Repeat after me: "I am not going to save my passwords in plain text and push them to GitHub".

Alright. Now that that's out of the way, let's take a look at how we are going to fix this problem. One of the more popular ways, and one that I am also familiar with, professionally, is to deploy **Hashicorp Vault**.

### Utility Services

These services are here just to support others. They are not technically required, but since we started off intending to do things properly, gosh dang it, we will!

GitLab can use an S3-compatible storage backend for some of its functionalities, so we are going to need one of those.

Finally, we need a way to make sure that all our services are up to date, so we need yet another service that will notify us of available updates.

#### S3 Storage

Since we all know that "amazon bad", we're going to roll out our own S3-compatible storage, all thanks to **MinIO**.

#### Update notifier

A quick google search came with the result of **Watchtower** being quite a popular option. I honestly have no experience with this or any other alternatives, so we're just gonna roll with the wisdom of the masses here.

## Conclusion

Now that we have a rough sketch of what we are going to do and how we are going to get there, there ain't much else to do besides just... y'know... do it. I think we went far enough with this post, so I am not going to drag it on any longer.

I will see you in the next one where we are *(probably)* going to configure our server to prepare it for hosting our services!

<br>

---

<center>
<i> - Mircea Anton - </i>
</center>

---

> Again, quite weird to sign myself off, but I have no other clue on how to end these posts and the conclusion by itself looked kinda meh and boring... 🥲
