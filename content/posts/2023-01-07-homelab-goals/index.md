---
title: My Homelab Plans for 2023
description: In this blog post I go over the upgrades and changes I have planned for my homelab in the coming year.

tags:
  - Homelab

author: "Mircea-Pavel Anton"
date: "2023-01-03"
---

Hello and Happy New Year! I hope everyone had a great holiday season and that we're starting strong for 2023. As we kick off the new year, I wanted to share my plans and goals for evolving my homelab in the following 12 months. I will go over some of the planned upgrades, technologies I want to study, and setups I want to explore. Without further ado, let's dive right in!

## Current Setup

<!-- TODO: Add an image of my rack here -->

This past year, I upgraded my central server from an 8-core i7-9700K with 32 Gb of RAM to a 10-core i7-7900X with 96 GB of RAM. This new server now had more cores, and more RAM than the rest of my Homelab put together. That meant that, for me, 2022 was the year of scaling down and trying to run everything on a single box.

With this upgrade, I now grew my Homelab to a whooping 4 servers:

```yaml
servers:
  main-server:
    os: Proxmox
    specs:
      CPU:
        model: i7-7900X
        cores: 10
      ram: 96Gb (6x 16Gb)
      PCIe:
        - RTX 2070S
        - GTX 1050
        - 16port LSI HBA
      storage:
        boot-pool: Samsung 980 500Gb (ZFS RAID 0)
        vm-pool: 2x Samsung 970 Evo Plus 1TB (ZFS RAID 1)
        data-pool: 5x 4Tb HGST Refurbished Enterprise Drives (passed through to TrueNAS)
  backup-server:
    os: TrueNAS
    specs:
      CPU:
        model: Pentium Gold G6405
        cores: 2
      ram: 16Gb (2x 8Gb)
      PCIe:
        - quad-port gigabit NIC
        - 8-port LSI HBA
      storage:
        boot-pool: 2x Samsung 128Gb SATA SSD (ZFS RAID 1)
        data-pool: 5x 1Tb HDD (ZFS RAIDZ1)
  automation-server:
    os: Ubuntu Server
    specs:
      CPU: 
        model: i5-6500
        cores: 4
      ram: 8Gb (1x 8Gb)
    PCIe: []
    storage:
      boot: Crucial BX500 240Gb SATA SSD
  testing-server:
    os: Proxmox
    specs:
      CPU:
        model: i7-9700K
        cores: 8
      ram: 16Gb (2x 8Gb)
      PCIe: []
      storage:
        boot-pool: Crucial BX500 240Gb SATA SSD
        I'm-pool: 2x 500Gb SATA SSD (ZFS RAID1)
    
```

The base OS for my servers is, as it has always been in the past few years, Proxmox. Inside PVE, I have been running several virtual machines. Most of them are ephemeral, as I was only spinning them up for projects or lab setups, but some are more permanent. Here are the VMs I find myself using most often:

- an OPNsense firewall
- a TrueNAS storage server
- an Ubuntu 22.04 Docker Host
- a Windows 11 VM for Gaming with an RTX 2070S passed through for remote gaming
- a Windows 11 VM for Audio and Video editing with a GTX 1050 passed through for hardware acceleration
- a bunch of Ubuntu VMs for various projects and test setups
- a few Windows 10 VMs for isolating various software required for my Uni work and now for my masters

Additionally, I have repurposed my old i5-6500 server to run a bare-metal Ubuntu server and used it as an "Automation Control Center." Since 2022 was also the year I got really into Frostpunk, I called it the `Automaton` server. The purpose of this server was to have a centralized place to run all my Ansible, Terraform, and Packer scripts to automatically provision and manage my infrastructure as code.

Next, I have another system I built specifically to store some backups. It is rocking a 10th gen dual-core Pentium and has 3 1Tb drives of random brands I got when dad upgraded his Synology. This system runs TrueNAS bare-metal and is only used to back up some VMs and other files.

Lastly, my previous "production" server, the 9700K, was now downgraded to a test system on which I kept experimenting with Rancher Harvester.

## Goals for 2023

Now let's get to the interesting part! Since I got my certified nerd diplomas for Kubernetes (CKA, CKAD, and CKS) late last year, I decided it was time to start my tryhard Kubernetes arc this year. Before we get to the exciting stuff, let's get some of the problems out of the way first.

With my current setup, I started noticing some limitations and some annoyances. For example, having my router and storage server virtualized inside Proxmox means that whenever I tinker and inevitably break something, my internet and storage also go down. This is particularly annoying since it incapacitates me from doing other activities, such as gaming with my friends. As such, for this year, I decided to migrate my OPNsense and TrueNAS from VM to bare-metal systems. Additionally, I would like it if the services I host were not impacted by my mindless tinkering. This year I am scaling back out, separating my core infrastructure from my testing/labbing setup.

Next, I already had a bunch of single-board computers lying around from last year. I purchased them when I first started getting into Kubernetes, thinking I would set up an ARM cluster, but I never managed to find the time to do that. This means that for almost 1 year, I had like 4 Raspberry Pis and a bunch of Odroid boards just collecting dust on a shelf 😢. This year I plan to **actually** make this cluster a reality and maybe even make it better than I had imagined!

Now, when I went over the reasons people usually have home labs, I also mentioned learning technologies alongside simply hosting services. So what do I plan to learn in 2023?

For starters, in 2023, I want to double down on the Infrastructure-as-Code topic and learn something like Flux or ArgoCD to automate my service deployments. Next, to automate the physical hosts themselves, I want to get more familiar with Jenkins and use it to trigger the Ansible playbooks or other scripts I write. For configuration management, I will stick to Ansible, as I am enjoying it, and for infrastructure provisioning, I will stick to Terraform and Packer. Out of all of these, Terraform is the only one that tempts me to get certified. Maybe Jenkins too, but that remains to be seen.

2023 should also be the year I implement proper logging, monitoring, and alerting in my Homelab. I plan to learn more about Prometheus, Grafana, and maybe Loki, ELK, or something similar. Let me know if you have any suggestions!

I think this is about it for now, but I am 100% sure this list will expand as the year goes by!

## Proposed Changes

Ok, so we went over the goals. Great! Now... how do I plan to achieve them, and what will I be implementing? Boy, am I glad you asked!

First things first, I will repurpose my Automation Server to be a bare-metal OPNsense instance. This will solve the "no internet when tinkering goes bad" problem, and overall, I think it will make the setup more robust. The firewall/router truly is something you want to "just work," and putting it inside the labbing setup was a bad move in retrospect.

Next, my Backup Server will remain as-is, at least for the foreseeable future. The CPU is too underpowered to do anything meaningful with it, so if it ain't broken, don't fix it!

For a storage server, I purchased a new system from the local second-hand market (like literally a few days ago). I got an i7-6850K with an ASUS Strix X99 motherboard, 4x 8Gb sticks of RAM, and a piece-of-junk case for 215$. I will install TrueNAS Scale on this one, bare-metal. I am choosing not to go with Core for no other reason other than that I want to try Scale out as well. 

This server, however, won't host any applications. It will just handle storage. The motherboard has a single m.2 slot,  so I won't be able to run a mirror of NVMe SSDs for boot, sadly. To work around that, at least initially, I will boot off a mirror of 120Gb SATA SSDs I have lying around and use a 256Gb NVMe as a cache device for my main data pool. Speaking of my main data pool, that consists of, for now, "just" 5 4Tb HGST Ultrastar drives. I'll have to run some tests and benchmarks to validate everything, but this is my initial idea.

For hosting my services, I am already in the midst of a project to build a 2U rackmount PSU that provides a bunch of 5V and 12V outputs to power my Raspberry PIs and Odrdoid boards. I will create a Kubernetes cluster with these nodes. 

I have 3 Pi4s with 2Gb of RAM, which I will use as the control-plane nodes. I made this decision since they are the only ones I have 3 of the same, and I want to implement HA into my cluster.

Next, all my 4Gb RAM boards will be worker nodes. This means that I will have 3 nodes hosting actual workloads. These nodes are a 4Gb Raspberry Pi 4, an Odroid N2+, and an Odroid C4. I am also considering getting a cheap Intel NUC from the used market since those also work on 12V.

The next issue to tackle is storage. I want my cluster and workloads to be independent of the storage server. As such, I will need a way to provide some storage to all of the nodes in my cluster. For that, I have 2 Odroid HC1 boards. These little guys (they are not that little) have SATA ports and mounting holes for a 3.5" drive. I want to add some hard drives to them and use Longhorn to replicate and distribute the storage across the cluster.

That being said, the cluster architecture will look something like this:

<!-- add image here-->

Ok, cool, but what about the virtual machines? Well... I did some labs with Rancher Harvester, and it looked promising, but it's still quirky and not truly production ready, at least from my testing. That's a bit unfortunate, but such is life. This meant that I had to look somewhere else to find a hypervisor solution, knowing that my main requirement is that I really want to be able to use Kubernetes to manage my VMs as well.

I want to install a plain-old Ubuntu Server on my main server and configure it as a node in the previously mentioned Kubernetes Cluster. Next, I want to deploy Longhorn on it and configure it to use the two 970 Evo Plus SSDs in a mirror as the data pool. Since this server will not be on 24/7, I need a way to make sure that my ARM boards do not request storage from it. To solve that, I will make use of storage classes and make sure that only VMs get deployed on this mirror. Finally, I will deploy KubeVirt on this server and label it so that only VMs can get scheduled on it.

I like this idea of having my VMs inside the cluster because I can integrate them much more easily into a GitOps workflow. Furthermore, I can implement more complex setups by making use of Kubernetes native concepts, such as network policies, namespaces, etc. In order to automate the initial configuration of the VMs, I want to explore the option of using init or sidecar containers to run my ansible playbooks.

The way I plan to implement IaC in my setup is that the Kubernetes cluster will "manage itself" via Flux/ArgoCD, and the underlying hosts (the Kubernetes nodes), alongside OPNsense and TrueNAS, will be managed via Ansible. Whenever something changes in my git repo, my cluster should start taking care of the rest.

As for the git server that stores this infrastructure definition, I am a bit torn. I am considering the hosted GitLab or GitHub instances (I am currently on GitHub). Deploying it inside my infrastructure creates a weird loop in which GitLab would need to configure itself somehow. Another option would be to host my own GitLab instance in the cloud, but I am not too sold on this idea. For this one, we'll have to wait and see.

Finally, we have my 9700K system. This one, sadly, is leaving the family as I am selling it to a friend in need of a gaming computer. RIP in pieces.

## Conclusion

As I reflect on my homelab journey in 2022 and think about the future, I'm excited to continue learning, experimenting, and growing my setup! The upgrades and projects I have planned for 2023 excite me, and I can't wait to get started!

I'm looking forward to sharing my progress and experiences with all of you in the coming year. Whether you have a homelab of your own or are interested in learning more about mine, I hope this blog post has been informative and inspiring. Here's to a successful and productive 2023!
