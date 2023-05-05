---
title: Should You Virtualize Your Firewall?
description: >
  In this one, I explore the debate virtual vs bare-metal infrastructure for critical services. Specifically, I will be discussing firewalls, which are arguably the most critical component of any network. I share my personal experiences of running my firewall both on a dedicated server as well as a virtual appliance.

  I cover the three main problems I encountered with virtualization, as well as 3 scenarios in which I think it makes sense.
  
  If you're trying to decide whether to virtualize your firewall or not, this video is for you!

tags:
  - Firewall
  - Virtualization

author: "Mircea-Pavel Anton"
date: "2023-05-05"
---

When it comes to managing critical infrastructure, there is an ongoing debate about whether to run it on bare metal or virtualize it.

In this post, I want to talk mainly about firewalls. Namely, I want to address the question “Should You Virtualize Your Firewall?” In terms of critical infrastructure inside the homelab, I think that the firewall is the most critical. You can have all your other services up and running, but if you can’t get to them, who cares?

Before I dive into the topic, let me just mention that my personal preference is to run critical services on dedicated hardware whenever possible. It generally makes life much simpler. That being said, I have ran my firewall as a VM in the past.

In my previous post, where I talk about my [Homelab Plans for 2023](https://mirceanton.com/posts/2023-01-07-homelab-goals/), I mention that at the beginning of 2022, I was running my firewall on a dedicated server. Later on, I moved to a virtual machine instance, and now, in 2023, I am migrating back to a bare-metal installation. In this blog post, I want to go over some of the reasons.

## The 3 main problems I have with virtualization

### Complexity by Design

{{< figure src="img/complexity_by_design.webp" caption="" >}}

> Do I really need a whole entire server JUST for my firewall?  
>
> \* points in the general direction of a big beefy server running many VMs *

Running your firewall as a virtual machine if you already have a virtualization server on 24/7 kind of makes sense; not gonna lie. I had the same thought process and quickly discovered that it had a hidden cost I did not foresee: **complexity**.

I trust pretty much any firewall to behave nicely in a VM and perform as well as they would on bare hardware, given that it is properly configured. The problem is that the extra layer introduced by virtualization allows more things to go wrong.

Don't get me wrong, though. I don't mean to say that running anything as a VM is inherently unstable and you shouldn't do it. What I want to emphasize is that when you put something in a VM, you introduce some more complexities and abstractions into the mix. There are now more variables to take into account, variables that would be out of the equation if we were running on bare hardware.

Here are a couple of examples that I ran into at one point or another.

#### PCIe device allocation

Say you are setting up a firewall VM and have decided to pass through a couple of NICs instead of using virtual adapters. Great! A few weeks have passed, and you are now adding a new GPU, an NVMe card, or any other PCIe device.

Why is that a problem? Oh, I am glad you asked!

It is likely that the PCIe device address has changed, especially if the NIC wasn't in the top slot, closest to the CPU. Now, you no longer have the network card passed through to the VM but some other device. Go figure!

Needless to say, this will cause the VM to either not start or boot but not work correctly, even though you didn't touch it or any related configuration. T'was but an oversight, but a very annoying one to troubleshoot.

#### Resource Overcommitment

Again, say you have a firewall VM, but now you set up virtual adapters instead of passing through the NICs, in light of my previous point. You should be safe now, right? Well, yes, but... not quite.

Running your firewall as a VM implies, by definition, that you will also be running other things on that server. But how can that be a problem? Is that not the whole point of a virtualization server? Well, over time, as you add more workloads to the server, you may get to a point where they start slowing the system down.

Say you have 6 Windows VMs chugging alongside your firewall, and they all decide to update at once, causing a sudden and unexpected spike in CPU usage. This could impact the performance of your firewall.

There may be better examples than this, but the concept is what matters. When running it as a VM, your firewall uses SHARED hardware. Its performance can now be impacted by the other workloads running on that same host, a situation you wouldn't have to consider if you had a dedicated device just for the firewall.

### Power Consumption

{{< figure src="img/power_consumption.webp" caption="" >}}

Another problem you may encounter is the actual running cost for that virtual infrastructure, especially if you were not keeping your virtualization server on 24/7 before. It is likely that, in the long run, it would be cheaper to buy an older, lower-powered system and keep that always on to run your firewall.

The hardware requirements for running pfSense, OPNsense, OpenWRT, or any other firewall are pretty low. You can get a cheap computer from the second-hand market to run your firewall. Any old i3 or i5 would do, especially if your internet speed is at or below 1 gigabit. It will also most likely run cooler and quieter than the virtualization server.

{{< figure src="img/old_pfsense.webp" caption="" >}}

Personally, I had my first taste of pfSense on a Frankensteined together server with components from a computer I found in my parent's attic. It had a Core 2 Duo with 2.5 gigs of DDR2.

For more inspiration, you can take a look at this [50 euro router build](https://www.youtube.com/watch?v=uAxe2pAUY50) from [Wolfgang](https://www.youtube.com/@WolfgangsChannel).

### Network Design Nightmare

{{< figure src="img/network_design.webp" caption="" >}}

Finally, let's talk about IP assignments. There are only two cases here, each with its own advantages and disadvantages. Either you want your hypervisor behind your firewall or next to it.

#### Hypervisor behind the Firewall

Having your hypervisor behind your firewall means its IP address is in the LAN network your firewall manages. This is cumbersome because this network does not exist when installing the hypervisor and doing the initial configuration. This means you must juggle IP addresses and re-assign network interfaces after the firewall VM is up.

There is also the annoyance of you losing access to your hypervisor if the firewall is down, so there is hardly any way to debug or fix the issue without getting a local console. This is especially true if you have VLANs set up.

Basically, having the hypervisor behind the firewall creates a chicken-and-egg kind of issue that, for some reason, really annoys me. The hypervisor depends on the firewall for the networking, and the firewall depends on the hypervisor to run.

#### Hypervisor next to the firewall

Having your hypervisor next to your firewall, on the other hand, means its IP address is in the WAN network from your firewall's perspective. This has the disadvantage that you basically ruled out the option of this being your primary firewall. You would need multiple public IP addresses, one for your firewall VM and one for your hypervisor.

On the other hand, you no longer have the problem of losing access to your hypervisor if the firewall is down. You win some, you lose some.

Whichever way the cookie crumbles, it still leaves a mess behind.

## 3 situations in which I think it makes sense

### Homelab in a Box

Due to financial or space constraints, you may be limited to a single computer to tinker with. That is perfectly fine. You don’t need an entire rack to have a Homelab, and you can do some pretty nifty things with a single box. I started off with a single computer, back when I built my first gaming PC and used my old one as a server.

The nice thing about such a setup is that you don’t really need to worry about setting up any networking between servers. It can all be done in software, which is much easier to reconfigure and move around. If your server has a single NIC, you could set that as the WAN on your firewall, have all your other networks as virtual bridges without an associated physical port, and use a VPN to get into your lab.

Basically, running your firewall as a VM makes sense if all of the clients using that firewall are also VMs on the same host. For more inspiration on this topic, check out Wendell from [Level1Techs](https://www.youtube.com/@Level1Techs) with the [“Forbidden Router” series](https://www.youtube.com/playlist?list=PL10NWKboioZRzCsTw9WedxId9sa0GC7nx), [HardwareHaven](https://www.youtube.com/@HardwareHaven) with [The Ultimate Router](https://www.youtube.com/watch?v=8QTdW0Q8U3E), or [TechnoTim](https://www.youtube.com/@TechnoTim) with his review of the [Protectli Appliance](https://www.youtube.com/watch?v=Aq6eoMjW7V0).

### Virtual Playground

{{< figure src="img/virtual_playground.webp" caption="" >}}

Needless to say, if you want to try out pfSense or some other firewall distribution, you shouldn't buy a computer just for that. It's a perfectly reasonable idea to set up a proof of concept setup with VMs and migrate to dedicated hardware once your lab evolves.

Another interesting use case for running a virtualized firewall is if you have some VMs in your hypervisor that you need to separate from your existing LAN. You may already have a firewall running on bare metal, but you have some VMs on which you want to play with malware or something similar. You could deploy an entire virtualized lab for that, complete with its own firewall, ensuring your actual LAN is secured.

Similarly, if you want to replicate some Kubernetes functionality for your Homelab, namely namespaces with their network policies, you could deploy a firewall VM exclusively for your virtualization infrastructure and set up different VLANs with individual rules on a per-VM/per-group-of-VMs basis. Though at that point, there are likely better ways to tackle this issue.

### Single User Setups

Finally, if you are the only person relying on that firewall for internet access and are okay with the caveats discussed here, then by all means, go for it. There isn’t really a right or wrong answer, as you may have guessed. A lot of people are running their firewall in a VM and are having a great time.

Having no other person reliant on this firewall basically means you have no SLA and no angry SO will come knocking down your door when your Proxmox kernel update requires you to reboot the server. :man_shrugging:

## Final Thoughts

As is usually the case, there are pros and cons to each of the options. While virtualization can offer more flexibility and scalability, it can also introduce complexity and instability. Ultimately, it’s up to you to decide whether to virtualize your firewall or run it on bare metal. There is no right or wrong answer here, it’s only the setup that suits your needs the best.

What are you running in your Homelab? Is your firewall virtualized, or do you have a dedicated server just for running it? What made you take that decision? Let me know in the comments.
