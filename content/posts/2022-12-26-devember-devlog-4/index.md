---
title: Week 4 - Ho-Ho-Holidays are here
description: In this blog post, I go over the progress I made for my Devember project, the PiPDU, during the fourth week of development as well as announcing my week of for the holidays.

series: [ Devember 2022 ]
series_order: 4

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2022-12-24"
---


I swear these weeks are passing by quicker and quicker... I could have sworn yesterday was Monday!

## Fourth Week Review

### Monday

Monday actually marked the end of another challenge I set for myself in December. I thought it would be a good idea to set a goal for myself to get all 3 Kubernetes certifications (CKA, CKAD, and CKS) within 3 weeks, so starting from December 1st and ending just before Christmas. If you tuned in to my previous DevLogs, you already know that I got my CKAD last week and my CKA the week before that. Well, today I took my CKS exam, which marked the end of that journey.

No work has been done on the devember project today, sadly, but I am still counting this as a win.

### Tuesday

{{< figure src="img/pcb_schema_v1.1.webp" caption="PCB v1.1 diagram" >}}

On Tuesday, I decided to take some time and fix all the errors reported by KiCAD on my PCB design and finish it up so that I can send it to JLC PCB or some other PCB printing service to get it, hopefully, in January.

{{< figure src="img/pcb_v1.1.webp" caption="3D Model of the PCB v1.1" >}}

I made sure to add some mounting holes so I can bolt the PCB onto the case and then I moved some of the traces around.

### Wednesday

On Wednesday I sat down to work on the project and realized I am not too sure what to work on next. Not that there is nothing else to do (I wish), but rather, there are plenty of random things to do scrambled around and I did not have a clear image of exactly what is the best route to take. As such, I took some time to plan out my work for the rest of the week. I decided to focus on a few key areas for both the software and hardware of PiPDU.

On the software side, I think there are a few things left that I want to implement for the controller:

- At the moment, to trigger a long press on one of the buttons you have to hold down the button for at least 3 seconds and the long press event will be triggered when you release it. What I want is for the long press action to be triggered the moment the threshold has been passed, regardless if the button has been released or not.
- The status LED is currently checking if the power draw of a socket is low enough to be considered off, but a better solution would be to query the API server for the actual status of the socket.

For the server, there's quite a bit more to do:

- I want to implement the ability to trigger custom actions before powering off a socket. For example, I want to be able to send a `shutdown` command to a raspberry before cutting off the power.
- There should be dedicated endpoints for turning sockets on and off instead of a single toggle endpoint. This is not per se needed in the current implementation, as the controller is only sending toggle commands, but I think the API would be incomplete without this.
- There should be an info endpoint to get details about the sockets. This will most likely be useful when implementing the LED status lights properly.
- I want to create a `YAML` config file for storing custom names, commands, and the initial state for the sockets and implement certificate-based auth and HTTPS.

There are also some extra ideas I had, which would be standalone components. I'm considering adding a web UI for viewing PDU information and turning sockets on and off, as well as potentially creating a discord bot.

On the hardware side, the remaining tasks for the controller are:

- ordering and mounting the PCB
- mounting and wiring up the PSU
- drilling holes for the power plug and RJ45 socket
- putting the thing together

And for the server, some of the things I have left to do are:

- drilling holes in the case for the sockets (I don't have the right drill bit for this, so I have to look it up)
- drilling a hole for the RJ45 socket
- and mounting the components inside the case

### Thursday

On Thursday I came to the great realization that I actually have assignments for the master's degree I signed up for this year (crazy, I know... who would've thought 🤯), and I shamelessly neglected them for a while. As such, I had to power through a bunch of assignments as most of them were due before Christmas.

### Friday

I made some good progress on PiPDU on Friday. I refactored the API routes and moved them to dedicated files in a more organized directory structure using Flask blueprints. There is now a blueprint for the `v1` of the API as well as dedicated blueprints for the `/socket` and `/sockets/all` endpoints. This is great as it allows for easier management and versioning of the API.

I also "designed" a `sockets.yaml` file to store custom configurations for the sockets, such as a description/name and a default initial state, in case some of the sockets should be off by default. Next, I created the `Socket` object, which abstracts away the logic for turning sockets on/off via serial commands and formatting the associated information in a JSON dictionary. Finally, I created a `SocketArray` singleton which parses the sockets config file, creates the 16 `Socket` objects, and caches them.

Finally, I added dedicated `/on` and `/off` endpoints both for turning on or off individual sockets as well as all sockets at once. Additionally, I created the `/info` endpoint to retrieve information such as the name and current status of a given socket.

### Saturday

I continued coding on PiPDU on Saturday, making further updates to the code. I refactored the entire codebase 😟, added docstrings, and implemented the `Led` and `LedArray` classes for handling the LEDs on the controller and caching the array, just like I did yesterday with the `Socket` and `SocketArray`. I also added logging, although it is currently a bit broken.

The main achievement of today, in my opinion, is refactoring the entire codebase and adding logging and docstrings. I think it improved the quality of the code quite a bit and made it more manageable.

### Sunday

Sunday was actually Christmas so I did absolutely nothing but relax and spend time with friends and family! Also food... lots and lots of food... 🤒

## Conclusion

While I feel like progress on this project has definitely slowed down, I also feel like I have to give credit where credit is due. I am at least making *some* progress regularly, and I also had quite a lot of other things happening on the side. It is a little more crowded than I thought it would be, but at least my Kubernetes challenge is now over so I have fewer things on my mind for the Christmas break.

Since Christmas and New Years are up, I think I will skip the devlog for the next week and take some time off, especially since I feel like I reached a point at which I need to get the hardware done so I can properly test the hardware and I need to order the PCB.

That being said, this has been it for this devlog and I'll see you next year! Thanks for coming along on this ride and happy holidays! 👋
