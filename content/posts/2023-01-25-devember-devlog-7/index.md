---
title: Back on track!
description: In this blog post, I give you some updates on the progress I made in the seventh week of my Devember 2022 Project.

series: [ Devember 2022 ]
series_order: 7

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2023-01-25"
---

It's been a busy week, and I'm finally starting to make some real progress on the project again. Hopefully, it's not too late, and I will finish everything in time, as I only have 2 weeks left 😟. University is still kicking my ass as it is finals season, but I am determined to make it work!

Here's a quick overview of what I've been working on for the past 7 days:

## Seventh Week Review

### Monday

{{< figure src="img/controller_pcb_old.webp" >}}

If you recall, I did a DIY at-home PCB print a couple of weeks ago with my dad, which turned out better than I initially expected. We drilled all the mounting holes and the holes for the components 2 weeks ago and last week we soldered up the connections.

{{< carousel images="{img/controller_pcb_back.webp,img/controller_pcb_front.webp}" aspectRatio="21-9" >}}

I finally completed this section of the project by soldering all the screw terminals and wires to the board to connect everything together. This was a nice and chill Monday night project as I put some YouTube in the background and took my time with it.

### Wednesday

{{< figure src="img/components_mounted_ugly.webp" >}}

Next, I did a test fit for the components inside the controller case on Wednesday. With the buttons mounted, I connected the wires to the screw terminals. I laid out the PCB and the other components inside a case to decide on a proper layout.

While this doesn't sound like much, and I certainly did not expect it to take too long, there are 16 buttons with 4 wires per button and other components, so that's over 70 connections. 💀

### Friday

{{< carousel images="img/bottom_panel*" aspectRatio="21-9" >}}

On Friday, I marked the mounting spots for the components onto the case and went to town drilling the holes. You can tell dad wasn't there to help with this one as they just **BARELY** line up 😅. Nonetheless, I got it done eventually. Next, I screwed down the components with M3 screws and butchered the top of my desk as the countersunk screws did not really countersink all the way...

### Saturday

The weekend was off to an amazing start when we realized we were missing some components. We needed some terminations for the 220V wire to secure it to the main socket. After a quick trip to the local hardware store, we were good to go!

{{< figure src="img/components_mounted_pretty.webp" >}}

Since dad was busy today and I wanted his help continuing the progress on the server case, I decided to get some other things done. I did a bit of cable management inside the controller case, ensuring all the wires were now the appropriate length. To be honest, it looks almost pro right now. I kinda dig it!

### Sunday

Finally, on Sunday, dad came back to the rescue. We went back to his garage and had to redesign the internal layout for the components inside the server case as it got more crowded than we initially expected. We decided to mount the PCB and relay board to the back panel instead of the floor of the case.

{{< carousel images="img/server_pcb*" aspectRatio="21-9" >}}

We drilled all the mounting holes into the PCB to secure it to the back panel. Next, we needed to find a way to mount the relay board to the PCB, but the screws were not lining up, so we had to cut a middle layer of acrylic. The plan is to use longer screws when mounting the PCB to the case and secure this plastic sheet to them. Then, we can use it to mount the relay board to it. We did a similar thing to mount the Arduino on top of the relay board as well.

{{< carousel images="img/sandwich*" aspectRatio="21-9" >}}

We ended up with a funky-looking sandwich, but hey... if it works, it works, I guess. We still need to solder on all the wires to make the connections and wire up the sockets to the relay, but that's a task for future me!

## Conclusion

Overall, I'm finally starting to get back on track, but I fear it's a bit late, and I won't finish on time. It does stress me out a bit, as I worked quite a lot and poured a lot of effort into this project, but I will do my best to finish on time! Sleep is for the weak, anyway 🥲

Anyway, I'm excited as things are in the last stretch and are finally getting put together. Seeing my idea closer and closer to a finished product is nice and motivating!

I'll catch you in the next one! 👋
