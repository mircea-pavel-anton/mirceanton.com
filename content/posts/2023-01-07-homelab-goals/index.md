---
title: My Homelab Plans for 2023
description: In this blog post I go over the upgrades and changes I have planned for my homelab in the coming year.

tags:
  - Homelab

author: "Mircea-Pavel Anton"
date: "2023-01-03"
---
Hello and Happy New Year! I hope everyone had a great holiday season and that we're starting strong for 2023. As we kick off the new year, I wanted to share some of my plans and goals for evolving my homelab in the following 12 months. I will go over some of the planned upgrades, technologies I want to study, and setups I want to explore. Without further ado, let's dive right in!

## Current Setup

<!-- TODO: Add an image of my rack here -->

For me, this past year was the year when I upgraded my main server from an 8-core i7-9700K with 32 Gb of RAM to a 10-core i7-7900X with 96 GB of RAM. This new server now had more cores and more RAM than the rest of my Homelab put together. As such, for me, 2022 was the year of scaling down and trying to run everything on a single box.

With this upgrade, I now grew my Homelab to a whooping 4 server:

```yaml
servers:
  main-server:
    os: Proxmox
    specs:
      cpu:
        model: i7-7900X
        cores: 10
      ram: 96Gb (6x 16Gb)
      pcie:
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
      cpu:
        model: Pentium Gold G6405
        cores: 2
      ram: 16Gb (2x 8Gb)
      pcie:
        - quad-port gigabit NIC
        - 8-port LSI HBA
      storage:
        boot-pool: 2x Samsung 128Gb SATA SSD (ZFS RAID 1)
        data-pool: 5x 1Tb HDD (ZFS RAIDZ1)
  automation-server:
    os: Ubuntu Server
    specs:
      cpu: 
        model: i5-6500
        cores: 4
      ram: 8Gb (1x 8Gb)
    pcie: []
    storage:
      boot: Crucial BX500 240Gb SATA SSD
  testing-server:
    os: Proxmox
    specs:
      cpu:
        model: i7-9700K
        cores: 8
      ram: 16Gb (2x 8Gb)
      pcie: []
      storage:
        boot-pool: Crucial BX500 240Gb SATA SSD
        vm-pool: 2x 500Gb SATA SSD (ZFS RAID1)
    
```

The base OS for my servers is, as it has always been in the past few years, Proxmox. Inside PVE I have been running several virtual machines. Most of them are ephemeral, as I was only spinning them up for projects or lab setups, but some of them are more permanent. Here are the VMs I find myself using most often:

- an OPNsense firewall
- a TrueNAS storage server
- an Ubuntu 22.04 Docker Host
- a Windows 11 VM for Gaming with an RTX 2070S passed through for remote gaming
- a Windows 11 VM for Audio and Video editing with a GTX 1050 passed through for hardware acceleration
- a bunch of Ubuntu VMs for various projects and test setups
- a few Windows 10 VMs for isolating various software required for my Uni work and now for my masters

Additionally, I have repurposed my old i5-6500 server to now run a bare-metal Ubuntu server and I have used it as an "Automation Control Center". Since 2022 was also the year I got really into Frostpunk, I called it the `Automaton` server. Anyway, the purpose of this server was to have a centralized place to run all my Ansible, Terraform and Packer scripts to automatically provision and manage my infrastructure as code.

Next, I have another system I built specifically to store some backups, which is a 10th gen dual-core Pentium. This system is running TrueNAS bare-metal and has a bunch of older 1Tb disks and is only used to back up some VMs and other files.

Lastly, my previous "production" server, the 9700K, was now downgraded to a test system on which I kept experimenting with Rancher Harvester.

## Goals for 2023

Now let's get to the interesting part! Since I got my certified nerd diplomas for Kubernetes (CKA, CKAD, and CKS) late last year, I decided it is time to start my tryhard Kubernetes arc this year. Before we get to the exciting stuff, though, let's get some of the problems out of the way first.

With my current setup, I started noticing some limitations and some annoyances. For example, having my router and storage server virtualized inside Proxmox means that whenever I tinker and inevitably break something, my internet and storage also go down. This is particularly annoying since it incapacitates me from carrying out other activities as well, such as gaming with my friends. As such, for this year I decided to migrate my OPNsense and TrueNAS from VM to bare-metal systems. Additionally, I would like it if the services I host are not impacted by my mindless tinkering either. This year I am scaling back out and I am separating my core infrastructure from my testing/labbing setup.

Next, I already had a bunch of single-board computers laying around from last year. I purchased them when I first started getting into Kubernetes thinking that I will set up an ARM cluster but I never managed to find the time to do that. This means that for almost 1 year now, I had like 4 Raspberry Pis and a bunch of Odroid boards just collecting dust on a shelf 😢. This year I plan to actually make this cluster a reality and maybe even make it better than I had imagined!

Now, when I went over the reasons people usually have home labs, I also mentioned learning technologies alongside simply hosting services. So what do I plan to learn in 2023?

For starters, in 2023 I want to double down on the Infrastructure-as-Code topic and learn something like Flux or ArgoCD to automate my service deployments. Next, to automate the physical hosts themselves, I want to get more familiar with Jenkins and use it to trigger the Ansible playbooks or other scripts I write. For configuration management, I will stick to Ansible, as I am enjoying it, and for infrastructure provisioning, I will stick to Terraform and Packer. Out of all of these, Terraform is the only one that tempts me in getting certified. Maybe Jenkins too, but that remains to be seen.

I want 2023 to also be the year I implement proper logging, monitoring, and alerting in my Homelab. For that, I plan to learn more about Prometheus, Grafana, and maybe Loki, ELK, or something similar.

For now, I think this is about it, but I am 100% sure this list will expand as the year goes by!

## Proposed Changes

Ok, so we went over the goals. Great! Now how do I plan to achieve them and what will I be implementing? Boy, am I glad you asked!

First things first, I will repurpose my Automation Server to be a bare-metal OPNsense instance. This will solve the "no internet when tinkering goes bad" problem and overall I think it will make the setup more robust. The firewall/router truly is something you want to "just work" and putting it inside the labbing setup was a bad move in retrospect.

Next, my Backup Server will remain as-is, at least for the foreseeable future. I think the CPU is kinda underpowered to do anything else meaningful with it. If it ain't broken, don't fix it!

For a storage server, I just purchased a new system from the local second-hand market (like, literally today). I got an i7-6850K with an ASUS Strix X99 motherboard, 4x 8Gb sticks of RAM, and a 400Gb Intel 750 series SSD for 215$. I will install TrueNAS on bare-metal on this one, and I think I will go with Core since this won't host any services, just storage. The motherboard has a single m.2 slot, so I am thinking I will use the 5x 4Tb drives as the main data pool, add a 256Gb NVMe as a cache drive and use the 400Gb SSD as a metadata device. I'll have to run some tests and benchmarks to validate everything, but this is my initial idea.

For running my services, I am already in the midst of a project to build a 2U rackmount PSU that provides a bunch of 5V and 12V outputs to power my Raspberry PIs and Odrdoid boards. I will create a Kubernetes cluster with these, something like the:

```yaml
nodes:
  manager:
    - Raspberry Pi 4 2Gb
    - Raspberry Pi 4 2Gb
    - Raspberry Pi 4 2Gb

  worker:
    - Raspberry Pi 4 4Gb
    - Odroid N2+ 4Gb
    - Odroid C4

  storage: # longhorn
    - Odroid HC1
    - Odroid HC1
```

I have 3 Pi4s with 2Gb of RAM which I will try to use as the control-plane nodes. Next, all my 4Gb RAM boards will be worker nodes. Finally, I also have 2 Odroid HC1 boards, which have slots for 3.5" hard drives in them. I want to add some hard drives to them and use Longhorn to replicate and distribute the storage across the cluster.

Ok, cool, but what about the virtual machines? Well... I did some labs with Rancher Harvester and it looked promising, but it's still a bit quirky and not truly production ready, at least from my testing. That's a bit unfortunate, but such is life. This meant that I had to look somewhere else to find a hypervisor solution, knowing that my main requirement is that I really want to be able to use Kubernetes to manage my VMs as well.

What I want to do is to install a plain-old Ubuntu Server on my main server and configure it as a node in the previously mentioned Kubernetes Cluster. Next, I want to deploy Longhorn on it as well and configure it to use the two 970 Evo Plus SSDs in a mirror as the data pool. I will create a different storage class for this to make sure that only the workloads deployed on this server use this storage class, as this will most likely not be powered on 24/7. Next, I will deploy KubeVirt on this server and label it so that only VMs get scheduled on it.

I like this idea of having my VMs inside the cluster because I can very very easily implement some more complex features. For example, I can put each VM in its namespace to get better separation, set quotas, use network policies, manage everything via Flux/ArgoCD, deploy sidecar containers to my VMs to run Ansible, etc. This sounds super cool and fascinating to me. I want to explore and tinker with this setup.

The way I plan to implement IaC in my setup, is that the Kubernetes cluster will "manage itself" via Flux/ArgoCD and the underlying hosts, alongside OPNsense and TrueNAS will be managed via Ansible. To run the playbooks automatically, I am thinking of using maybe one of my Raspberry Pi 3A+ or something to deploy either a GitHub or GitLab worker inside my infrastructure and run some pipelines to push the configurations when something updates in the repo. To manage the VMs, I will try some sidecar containers that will run the automation.

As for the git server that stores this infrastructure definition, I am a bit torn. I am thinking of just using the hosted GitLab or GitHub instances (i am currently on GitHub), since deploying it inside my infrastructure creates a loop in which GitLab would configure itself, so I would have to have some dedicated hardware for it. Another option would be to host my own GitLab instance in the cloud, but I am not too sold on this idea. I think for this one we'll have to wait and see.

Finally, we have my 9700K system. Since I expect the KubeVirt solution to be a *VERY* bumpy ride, I will simply install Windows 11 on it and use it as my desktop again for gaming and other work. This means that the PC I was using as a thin client at my desk (some old 3rd gen i5 HP) will now be free and I can also assign it to the Kubernetes Cluster.

## Conclusion

As I look back on my homelab journey in 2022 and think about the future, I'm excited to continue learning, experimenting, and growing my setup! The upgrades and projects I have planned for 2023 excite me and I can't wait to get started!

I'm looking forward to sharing my progress and experiences with all of you in the coming year. Whether you have a homelab of your own or are just interested in learning more about mine, I hope this blog post has been informative and inspiring. Here's to a successful and productive 2023!
