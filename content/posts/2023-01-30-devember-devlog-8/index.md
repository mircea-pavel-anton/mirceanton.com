---
title: We almost made it!
description: In this blog post, I give you some updates on the progress I made in the eigth and last week of my Devember 2022 Project.

series: [ Devember 2022 ]
series_order: 8

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2023-01-30"
---

Hey everyone! Can you believe it's been eight weeks since I started the 2022 Devember Project? I certainly can't! Time has flown by and I'm both happy and a bit sad to say that we've just almost made it!

The overall goal for this challenge was for me to set up a barebone and basic prototype to validate the ideea itself, not to get to a robust and production-ready system. In that regard, I guess you could say we actually reached the goal, even though the final product is even more trimmed down than I initially envisioned.

In this blog post, I'll give you some updates on the progress I've made in the final week of the project. I'll probably write another blog post sometime next week in which I'll wrap up the Devember challenge for 2022 and give some more information on the future plans for the project, so stay tuned for that!

## Eight Week Review

### Monday

Monday was a bit of a rough start. If you recall from the previous weeks, the Controller itself is more or less done, and it was just time to put it all together. Upon assembly, I found out that there were some imperfect connections on the PCB. I didn't let that get me down, though.

I spent the day troubleshooting and was able to identify and fix the issues. By the end of the day, I had closed up the controller case and started testing and adjusting the code. It wasn't the most exciting day, but alas, it was a necessary step.

### Tuesday

Tuesday was every bit as interesting as Monday was 😆. I apparently still had 2 buttons which were refusing to cooperate. Upon further investigation, I came to the conclusion that one of them still had some bad solder joints and one of them was simply broken. After I finished fixing the connections and replaced the button, I moved on to finishing up the code.

In the "original" design, the buttons were connected as a matrix to the Pi directly, and the LEDs were individually addressed. In order to simplify the circuit and make the code a bit more flexible, we decided a few weeks ago to move to I2C GPIO expanders. That way there would only be 2 wires coming off the Pi and going to the PCB. That made it simpler if I ever need to change the Pi or take it out for whatever reason. I changed up the code a bit in order to handle the buttons and LEDs via I2C and that was about it.

### Wednesday

> TODO: Server pcb with components soldered

Wednesday was all about soldering. I spent the entire evening/night with dad, soldering the components to the server PCB. It was a tedious task, but I made sure to double-check all of the connections and test everything before moving on to the next step, given my Monday and Tuesday experience.

> TODO: Arduino with paperclip

We realised we had a bit of an issue in the component choice. The cables on this PCB are connecting directly to the Arduino, but both the cables and the Arduino board have female dupont connectors, so there is no easy way to connect them. I did not manage to find the appropriate dupont pins since they had to be long on either side, so we had to improvise. This is a very "do as I say not as I do" moment. I took a paper clip, straightened it and started cutting pieces of it to shove them into the connectors to get them together... 😅

### Friday

> TODO: The THING, assembled and wired up

Friday was the big day. We spent the entire evening assembling the server circuitry and doing the low-voltage wiring. It looks jank af and I am unsure if I would actually trust it if somebody else showed it to me, but hey... ugly as it may be, it **should** get the job done!

### Sunday

TODO

## Conclusion

To wrap things up, I'm thrilled with the progress I've managed to make on this project and I'm excited to see it come to life. I've learned a lot during these eight weeks and I'm grateful for the opportunity to work on something so challenging and rewarding. I want to thank you for following along on my journey, it's been a pleasure to share my experience with you all. I hope you've found my updates helpful, and maybe even a bit entertaining. I can't wait to show you the final result!
