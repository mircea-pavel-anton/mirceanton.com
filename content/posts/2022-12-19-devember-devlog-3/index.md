---
title: Week 3 | 58% of the time, it works every time
description: In this blog post, I talk about the challenges I faced during the 3rd week of Devember

series: [ Devember 2022 ]
series_order: 3

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2022-12-19"
---

Welcome to this week's devlog! It's been quite a week, that's for sure! There were plenty of unexpected setbacks thrown in for good measure. God knew I'd be too powerful if everything just worked out for me...

## Third Week Review

### Monday

On Monday, I had my Certified Kubernetes Application Developer (CKAD) exam, which was the primary focus for me the previous week. While I was eager to take the exam and assess my performance, I also knew that it would be a mentally and emotionally draining day. That turned out to be accurate, especially since I encountered quite a lot of difficulty during the exam. Therefore, I decided to take the rest of the day off to decompress and relax.

### Tuesday

On Tuesday, I was ready to tackle some more work on the piPDU project. I began by refactoring some of the code for the controller into "Arduino-style" functions. This involved implementing a setup function that would be called once when the controller starts up, as well as a loop function that would be called repeatedly thereafter. I also set up functions to initialize the LEDs, which will be used to indicate the status of the various sockets on the power strip.

In addition to that, I also implemented singleton classes for the metrics collector and the button matrix. The metrics class is responsible for collecting and caching metrics from the Prometheus endpoint exposed by the server, which will be used to monitor the performance and status of the power strip. The button matrix class will be used to control the power strip through the use of long and short button presses.

### Wednesday

Unfortunately, today was a rough day as I was very sick and unable to work on anything. I spent the entirety of the day in bed, feeling too unwell to do much of anything.

### Thursday

On Thursday, I was still feeling a bit under the weather, but I managed to push through and get some work done. I focused on the controller code and implemented the actual API calls for the long and short button presses. These API calls will be used to communicate with the server and control the power strip remotely.  

Next, I implemented some "state" logic for the LCD. The display will be used to show various information about the power strip to the user. There are two main states the LCD can be in: idle or info. During idle, the display will show generic information about the PDU as a whole, such as the total power draw. The info state is triggered when a button is pressed. Each button corresponds to a particular socket on the PDU, so a press of a button will cause the LCD to show specific information about the associated socket.

Finally, I also implemented the update function for the LED array, which will be used to turn them on and off based on the status of the various sockets on the power strip. This is done in the background by scraping the metrics endpoint and seeing if the power consumption is greater than a given threshold. I may have to change this later on to send dedicated API calls to the socket status endpoint, but for now, I think this works well enough as it integrates nicely with the metrics collection thread that runs in the background already.

### Friday

Unfortunately, Friday was a busy day and I was unable to work on the devember project. Life seemed to get in the way, and I didn't have the time or energy to make any progress on the project.

### Saturday

On Saturday, I managed to squeeze in a little bit of work on the piPDU project. I started by desoldering the screw terminals from my previous attempt of a protoboard, as I wanted to reuse them for the custom PCB I'm working on. In my language, we have a saying that goes something like this: "he who does and undoes, has something to do all day". I think this is pretty suggestive for my current state, as I now have to spend time to undo that which I previously spent time to do...

I also spent some time troubleshooting and fixing errors that were reported by KiCad on my PCB design, but I did not manage to make too much progress due to the time (and energy, honestly) constraints. I will have to continue this work on Sunday.

### Sunday

Sunday was a bit of a mixed bag for the piPDU project. While I was able to get some work done in the morning, I eventually had to shift my focus to studying for my CKS exam, which is scheduled for tomorrow. I spent most of the day focusing on preparing for the exam and making sure I was as well-equipped as possible to succeed, especially since this is a field in which I do not have as much experience as opposed to the CKA and CKAD. On the bright side, this is the last exam I have planned, so I will have more time to focus on the Devember project starting next week!

## Wrapping Up

Overall, it's been a relatively productive but also challenging week for the piPDU project. While I was able to make some progress on the controller code and PCB design, I also had to deal with plenty of unexpected setbacks, including a sick day, a busy day where I was unable to function at all and a dedicated studying day.

Despite these challenges, I'm trying to be positive and appreciate the progress I've made. I am looking forward to continuing to work on the project in the coming weeks and I hope the sailing will be smoother from now on... *knock on wood*
