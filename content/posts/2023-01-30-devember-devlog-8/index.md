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

Hey everyone! Can you believe it's been eight weeks since I started the 2022 Devember Project? I certainly can't! Time has flown by, and I'm both happy and sad to say that we've just almost made it!

The overall goal for this challenge was for me to set up a barebone and basic prototype to validate the idea itself, not to get to a robust and production-ready system. In that regard, you could say we actually reached the goal, even though the final product is even more trimmed down than I initially envisioned.

In this blog post, I'll give you some updates on the progress I've made in the final week of the project. I'll probably write another blog post next week in which I'll wrap up the Devember challenge for 2022 and give some more information on the future plans for the project. Stay tuned for that!

## Eighth Week Review

### Monday

Monday was a rough start. If you recall from the previous weeks, the Controller is more or less done, and it was time to put it all together. Upon assembly, I found out that there were some imperfect connections on the PCB. I didn't let that get me down, though.

I spent the day troubleshooting and was able to identify and fix the issues. By the end of the day, I had closed up the controller case and started testing and adjusting the code. It wasn't the most exciting day, but alas, it was a necessary step.

### Tuesday

Tuesday was every bit as interesting as Monday was 😆. I apparently still had 2 buttons that were refusing to cooperate. Upon further investigation, I concluded that one of them still had some bad solder joints, and one was simply broken. After fixing the connections and replacing the button, I moved on to finishing up the code.

In the "original" design, the buttons were connected as a matrix to the Pi directly, and the LEDs were individually addressed. To simplify the circuit and make the code more flexible, we decided to move to I2C GPIO expanders a few weeks ago. That way, there would only be 2 wires coming off the Pi and going to the PCB. That made it simpler if I ever needed to change the Pi or take it out for whatever reason. I changed up the code to handle the buttons and LEDs via I2C, and that was about it.

### Wednesday

> TODO: Server PCB with components soldered

Wednesday was all about soldering. I spent the entire evening/night with dad, soldering the components to the server PCB. It was a tedious task, but I made sure to double-check all the connections and test everything before moving on to the next step, given my Monday and Tuesday experience.

> TODO: Arduino with the paperclip

We had an issue with the component choice. The cables on this PCB connect directly to the Arduino. Still, both the cables and the Arduino board have female Dupont connectors, so there is no easy way to connect them. I did not manage to find the appropriate DuPont pins since they had to be long on either side, so we had to improvise. This is a very "do as I say, not as I do" moment. I took a paper clip, straightened it, and started cutting pieces of it to shove them into the connectors to get them together... 😅

### Friday

> TODO: The THING, assembled and wired up

Friday was the big day. We spent the entire evening assembling the server circuitry and doing the low-voltage wiring. It looks jank af, and I am unsure if I would actually trust it if somebody else showed it to me, but hey... ugly as it may be, it **should** get the job done!

### Sunday

- added a power switch to the server case
- added the 5V PSU and wired mains power to it
- mounted the contraption to the server case
- mounted a bunch of terminal strips and wired them to the relays NC and the sensors (power -> sensor -> relay -> socket)
- designed a mounting system for the pi as well, on top of the arduino
- added a terminal block to split up the 5V and GND from the PSU to power multiple components
- ran the 5V power to the server PCB, relay board, arduino and Pi
- wired the I2C from the pi to the arduino

## Conclusion

To wrap up, I'm thrilled with the progress I've made on this project, and I'm excited to see it come to life. I've learned a lot during these eight weeks, and I'm grateful for the opportunity to work on something so challenging and rewarding. I want to thank you for following along on my journey. It's been a pleasure to share my experience with you all. I hope you've found my updates helpful and maybe even a bit entertaining. I can't wait to show you the final result!
