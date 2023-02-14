---
title: My Homelab Plans for 2023
description: In this blog post, I go over the upgrades and changes I have planned for my homelab in the coming year.

tags:
  - Homelab

author: "Mircea-Pavel Anton"
date: "2023-01-11"
---

Hello and Happy New Year! I hope everyone had a great holiday season and that we're starting strong for 2023. As we kick off the new year, I wanted to share my plans and goals for evolving my homelab in the following 12 months. I will go over some of the planned upgrades, technologies I want to study, and setups I want to explore. Without further ado, let's dive right in!

## Goals for 2023

For 2023, I plan to solve some of the current limitations and annoyances, implement more of some of the technologies I know and enjoy, as well as learn and experiment with new things!

### Solving current problems

{{< figure src="img/drake_meme.webp" caption="Virtualizing VS. Running on bare metal" >}}

Let's start off with the problems I have encountered with my setup in the past year and what I will be attempting to solve this year.

With my current setup, I started noticing some limitations and some annoyances. For example, having my router and storage server virtualized inside Proxmox means that whenever I tinker and *inevitably* break something, my internet and Storage also go down. This is particularly annoying since it prevents me from doing other things, such as gaming with my friends.

To solve that this year, I decided to promote my OPNsense and TrueNAS from VM to bare-metal systems. Additionally, I would like it if the services I host were not impacted by my mindless tinkering either. This year I am scaling back out, separating my core infrastructure from my testing/labbing setup.

### Kubernetes all the way

{{< figure src="img/kubernetes_certifications.webp" caption="Kubernetes Certified Nerd" >}}

Now let's get to the interesting part! Since I got my certified nerd diplomas for Kubernetes ([CKA](http://mirceanton.com/posts/2022-12-06-my-cka-experience/), [CKAD](http://mirceanton.com/posts/2022-12-13-my-ckad-experience/), and [CKS](http://mirceanton.com/posts/2022-12-20-my-cks-experience/)) late last year, I decided it was time to start my tryhard Kubernetes arc this year 🤓.

As such, I want to implement Kubernetes as the core component of my infrastructure, managing not only my containers but my VMs as well. I want Kubernetes to be both my "hypervisor" as well as my containerization platform!

### Infrastructure as Code

{{< figure src="img/iac.webp" caption="Infrastructure as Code tools" >}}

For starters, in 2023, I want to double down on the Infrastructure-as-Code topic and learn something like Flux or ArgoCD to automate my service deployments. Next, to automate the physical hosts themselves, I want to get more familiar with either Jenkins or GitLab-CI and use it to trigger the Ansible playbooks or whatever scripts I write.

For configuration management, I will stick to Ansible, as I am enjoying it, and it is also what I use at work. For infrastructure provisioning, I will stick to Terraform and Packer. Out of all of these, Terraform is the only one that tempts me to get certified on. Maybe Jenkins too, but that remains to be seen.

### Logging, Monitoring, and Alerting

{{< figure src="img/grafana.webp" caption="Grafana Inc." >}}

2023 will also be the year I implement proper logging, monitoring, and alerting in my Homelab. I plan to learn more about Prometheus, Grafana, and maybe Loki, ELK, or something similar. Let me know if you have any suggestions!

I think this is about it for now. I am 100% sure this list will expand as the year goes by, but this would be the set of minimal requirements I set for myself.

## Proposed Changes

Ok, so we went over the goals. Great! Now... how do I plan to achieve them, and what will I be implementing? Boy, am I glad you asked! Let's take them server by server and talk about them in a bit more detail.

### Firewall Appliance

{{<
  figure src = "img/netserv.webp"
         caption = "My OPNsense Box"
>}}

First things first, my firewall will be migrated from running inside a VM on my virtualization server to running on a dedicated server. I am doing this because I want to solve the problem of losing internet connectivity when I reboot/shut down my main server. Running it as a VM this past year made me realize that the firewall/router truly is something you want to "just work," and putting it inside the labbing setup was a bad move 😅.

To accomplish that, I will repurpose one of the lower-powered servers I have running in my rack. Previously, it has been dedicated to running some of my CI and scripts to automate and provision infrastructure in my lab. For this year, though, I will install my firewall of choice, OPNsense, on it and use it as a dedicated firewall appliance.

{{<
  figure src = "img/netserv_internals.webp"
         caption = "Internals of the OPNsense server"
>}}

This server is rocking a quad-core i5-6500 with a single 8Gb stick of DDR4 memory. For a boot device, I have installed OPNsense on a mirror of 256Gb NVMe drives I got on the cheap from a local refurb shop. I will be using the onboard gigabit NIC as a WAN port and the add-in 1 Gb NIC as a LAN port.

Try to ignore the PSU mounting contraption. I forgot to check the supported dimensions before ordering the case (InterTech 20248). It is actually held in place pretty well, thanks to double-sided velcro tape!

### Storage Appliance

{{<
  figure src = "img/storage_server.webp"
         caption = "My TrueNAS Appliance and its emotional support foam roller"
>}}

For a storage server, I purchased a new system from the local second-hand market (like literally a few days ago). I got an i7-6850K with an ASUS Strix X99 motherboard, 4x 8Gb sticks of RAM, and a piece-of-junk case for 215$. Not terrible, not great 😆

For the OS, I chose to go with TrueNAS Scale. In the past few years, I have been running Core, and I decided it is about time I give Scale a shot to see if the grass is indeed greener on the other side.

One of the main advantages of Scale vs. Core is that it has support for Docker and thus allows me to easily run and deploy many more applications. This server, however, won't be doing any of that. It will handle Storage and, maybe, a GitLab server, but more on this later.

{{<
  figure src = "img/storage_server_internals.webp"
         caption = "TrueNAS server internals"
>}}

As mentioned above, this server is an X99-based platform with an i7-6850K CPU with 4x 8Gb of RAM. Since the processor does not have an integrated GPU, I added my old GTX 1050 inside so that I could get a video out during the installation and decided to keep it there, just in case, for troubleshooting purposes.

The case for this server is actually one of the nicer ones I have. It is the Sliger CX4712, and it has support for hot-swapping 10x 3.5" drives in the front as well as 2x 5.25" bays. For now, I only have 5x 4Tb HGST Ultrastar drives in it connected to the server via a 16port LSI HBA.

The motherboard has a single m.2 slot, so I won't be able to run a mirror of NVMe SSDs for boot, sadly. To work around that, I will boot off a mirror of 120Gb SATA SSDs I have lying around. I am considering putting the m.2 slot to work, either by adding an NVMe drive as a cache or a LOG device for my main ZFS pool. There's also another pair of 500Gb SATA SSDs in this case, which I may configure as a mirror and use as the metadata device.

On the networking side, my backbone is currently only gigabit. In the near future, I intend to add a 4-port NIC to this server and configure it as a LAGG to increase bandwidth. In the long term, I am looking at getting either a 10 Gb card and switch or a 40g card and going with direct connections.

### Backup Server

{{<
  figure src = "img/backup_server.webp"
         caption = "My 2U backup server"
>}}

Up next, my backup server will remain as it was for the past year. It came in handy more times than I'd like to admit, and I see no reason to change it, at least for the foreseeable future. The CPU is too underpowered to do anything meaningful with it, so if it ain't broken, don't fix it!

{{<
  figure src = "img/backup_server_internals.webp"
         caption = "Backup server internals"
>}}

This bad boy right here is rocking a mighty Pentium G6405 (10th gen, 2c4t) with 2x 8Gb RAM sticks. It is booting off a mirror of 120Gb SATA SSD drives and has 3x 1Tb hard drives in it. While I don't really **need** to have an HBA in this server, to connect the drives to it, I had it lying around after upgrading the HBA in my storage server last year, so why not 🤷.

The case itself is yet another InterTech 2U case, the 2U 20255 this time. The fans are quite loud, but at least they're hot-swappable, I guess. While it does not support a TFX PSU, I had a friend 3d print an adapter for me, and it is holding on just fine. The cooler is a 2U passive heatsink I got from AliExpress a while back, but it keeps the CPU quite cool.

### Kubernetes Cluster

{{<
  figure src = "img/k8s_all.webp"
         caption = "A bunch of SBCs dedicated to running K8S"
>}}

For hosting my services, I am already in the midst of a project to build a 2U rackmount PSU that provides a bunch of 5V and 12V outputs to power my Raspberry PIs and Odrdoid boards. I will create a Kubernetes cluster with these nodes.

#### Control plane

{{<
  figure src = "img/k8s_controlplane.webp"
         caption = "3x Pi4 2Gb dedicated to k8s controlplane"
>}}

I have 3x Pi4s with 2Gb of RAM, which I will use as the control-plane nodes. I made this decision since they are the only ones I have 3 of the same, and I want to implement HA into my cluster. I don't know if the 2Gb of RAM will be enough to handle the workload, but I'll cross that bridge when I get to it.

#### Worker

{{<
  figure src = "img/k8s_workers.webp"
         caption = "A couple Odroid boards and a Pi4 4Gb dedicated to running workloads"
>}}

Next, all my 4Gb RAM boards will be worker nodes. This means that I will have 3 nodes hosting actual workloads. These are a 4Gb Raspberry Pi 4, an Odroid N2+, and an Odroid C4. I am also considering getting a cheap Intel NUC from the used market since those also work on 12V if needed.

#### Storage

{{<
  figure src = "img/k8s_storage.webp"
         caption = "A couple of Odroid HC1 boards for Longhorn"
>}}

The next issue to tackle is Storage. I want my cluster and workloads to be independent of the storage server. As such, I will need a way to provide some storage to all of the nodes in my cluster. For that, I have 2 Odroid HC1 boards. These little guys (they are not that little) have SATA ports and mounting holes for a 3.5" drive. I will add some hard drives to them and use Longhorn to replicate and distribute the Storage across the cluster.

### Virtualization Server

{{<
  figure src = "img/virt_server.webp"
         caption = "My Virtualization Server"
>}}

Ok, cool, but what about the virtual machines? Well... I did some labs with Rancher Harvester, and it looks really promising, but it's still quirky and not truly production ready, at least from my testing. That's a bit unfortunate, but such is life. This means that I have to look elsewhere to find a hypervisor solution, knowing that my main requirement is that I really want to be able to use Kubernetes to manage my VMs as well.

I decided to install a plain-old Ubuntu Server and configure it as a node in the aforementioned Kubernetes Cluster. Next, I will deploy Longhorn on it and configure it to use the 2x 970 Evo Plus SSDs in a mirror as the data pool. Since this server will not be on 24/7, I need a way to make sure that my ARM boards do not request Storage from it. To solve that, I will make use of storage classes and make sure that only VMs get deployed on this pool. Finally, I will deploy KubeVirt on this server to add support for virtual machines.

I like this idea of having my VMs inside the cluster because I can integrate them much more easily into a GitOps workflow. Furthermore, I can implement more complex setups by making use of Kubernetes native concepts, such as network policies, namespaces, etc. In order to automate the initial configuration of the VMs, I want to explore the option of using init or sidecar containers to run my ansible playbooks.

{{<
  figure src = "img/virt_server_internals.webp"
         caption = "The insides of my virtualization server"
>}}

My virtualization server is based on the X299 platform. It has an i9-7900X CPU with 96 GB of RAM and a 256 GB NVMe boot drive. At the moment, I have a GTX 1660Ti in there to experiment with PCIe passthrough for the new setup. The VMs themselves will be hosted on a mirror of 2x 1Tb 970 Evo Plus SSDs I have from last year when I was running Proxmox.

The case for this server is, yet again, an InterTech one, the 4U 4098S. In all honesty, it's not THAT great, but for the price, I really cannot complain. I hope to upgrade this to another one of the Sliger cases, but I wonder if I can really justify that. The PSU is a 550W unit that is a temporary stand-in for the 1KW unit I will put in here once I get everything sorted out.

### The Forgotten Child

{{<
  figure src = "img/9700k.webp"
         caption = "The forgotten child"
>}}

Finally, we have my 9700K & RTX 2070S system. I don't have a plan for this one. For now, I put it in the piece-of-junk case I got as a bundle with my 6850K purchase. I think I will just install windows on it and use it as a game-streaming server until I get my Kubernetes setup up and running and then sell it. Really not sure what to do here. Let me know in the comments if you have any suggestions for what I could do with it!

### Configuration as Code

The way I plan to implement IaC in my setup is that the Kubernetes cluster will "manage itself" via Flux/ArgoCD, and the underlying hosts (the Kubernetes nodes), alongside OPNsense and TrueNAS, will be managed via Ansible. Whenever something changes in my git repo, my cluster should start taking care of the rest.

As for the git server that stores this infrastructure definition, I am a bit torn. Since I don't really want it to be deployed inside the Kubernetes cluster, I could either:

- deploy GitLab on the Storage Server as a docker container
- use the hosted GitHub/GitLab platforms
- self-host a GitLab/Gitea instance in the cloud

I am considering the first option, but I am unsure. For this one, we'll have to wait and see.

## Conclusion

As I look back on my homelab journey in 2022 and think about the future, I'm excited to continue learning, experimenting, and growing my setup! The upgrades and projects I have planned for 2023 excite me, and I can't wait to get started!

I'm looking forward to sharing my progress and experiences with all of you in the coming year. Whether you have a homelab of your own or are interested in learning more about mine, I hope this blog post has been informative and inspiring. Here's to a successful and productive 2023!

What upgrades do you have planned for 2023? What new services do you want to deploy, and what new technologies do you want to learn? Let me know in the comments below!
