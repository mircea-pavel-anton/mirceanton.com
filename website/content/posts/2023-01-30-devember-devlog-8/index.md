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

Hey everyone! Can you believe it's been eight weeks since I started the 2022 Devember Project? I certainly can't! Time has flown by, and I'm both happy and sad to say that we've just almost made it! We've come a really long way since we started. Unfortunately, we did not manage to complete everything we set out to at the start.

In this blog post, I'll give you some updates on the progress I've made in the final week of the project. I'll probably write another blog post next week in which I'll wrap up the Devember challenge for 2022 and give some more information on the future plans for the project. Stay tuned for that!

## Eighth Week Review

### Monday

Monday was a rough start. If you recall from the previous weeks, the Controller is more or less done, and it was time to put it all together. Upon assembly, I found out that there were some poor connections on the PCB. I didn't let that get me down, though.

I spent the day troubleshooting and was able to identify and fix the issues. By the end of the day, I had closed up the controller case and started testing and adjusting the code. It wasn't the most exciting day, but alas, it was a necessary step.

### Tuesday

Tuesday was every bit as interesting as Monday was 😆. I apparently still had 2 buttons that were refusing to cooperate. Upon further investigation, I concluded that one had some bad solder joints, and one was simply broken. After fixing the connections and replacing the button, I moved on to finishing up the code.

In the "original" design, the buttons were connected as a matrix to the Pi directly, and the LEDs were individually addressed. To simplify the circuit and make the code more flexible, I decided to move to I2C GPIO expanders a few weeks ago. That way, there would only be 2 wires coming off the Pi and going to the PCB. That made it more straightforward if I ever needed to change the Pi or take it out for whatever reason. I changed up the code to handle the buttons and LEDs via I2C, and that was about it.

### Wednesday

Wednesday was all about soldering. I spent the entire evening/night with dad, soldering the components to the server PCB. It was a tedious task, but I made sure to double-check all the connections and test everything before moving on to the next step, given my Monday and Tuesday experience.

{{< figure src="img/server_pcb_components_soldered.webp" caption="The server PCB with the components soldered on." >}}

We had an issue with the component choice. The cables on this PCB connect directly to the Arduino. Still, both the wires and the Arduino board have female Dupont connectors, so there is no easy way to connect them. I did not manage to find the appropriate DuPont pins since they had to be long on either side, so we had to improvise.

This is a very "do as I say, not as I do" moment. I took a paper clip, straightened it, and started cutting pieces of it to shove them into the connectors to get them together... 😅

### Friday

{{< carousel images="img/server_contraption_assembled*.webp" aspectRatio="16-9" >}}

Friday was a pretty exciting day. We spent the entire evening assembling the server circuitry outside of the case and doing some of the low-voltage wirings. It looks jank af, and I am unsure if I would actually trust it if somebody else showed it to me, but hey... ugly as it may be, it **should** get the job done!

### Sunday

Sunday was a big and eventful day as we worked on many things.

{{< carousel images="img/power_switch*.webp" aspectRatio="21-9" >}}

Firstly, we added an on/off switch to the case to cut off the mains' power to the entire thing... y'know... just in case 😃. We wired it up to the already mounted socket to the case and moved on with the other, more important tasks.

{{< carousel images="img/sensor_to_relay*.webp" aspectRatio="16-9" >}}

Next, we cut and bent some thicker wire to make the connection from the current sensors to the relays. For the wiring to be manageable, we decided to go from the mains in -> sensor IN, sensor OUT -> relay NC, and relay COM -> power socket.

{{< figure src="img/terminal_strips_mounted.webp" caption="The server PCB and terminal strips, mounted into the case" >}}

Now that the wiring that could be done before mounting the components inside the case was done, it was time to... well... mount the components inside the case, duh! We secured them with screws to the back of the case, making use of the already-existing perforated pattern. Next, we mounted some terminal strips to the left and right of the components to facilitate the wiring.

{{< carousel images="img/terminal_strips_wired*.webp" aspectRatio="16-9" >}}

Mains power comes in one of the strips and is then daisy chained to the other. In order to run the mains' power along the terminal strip, we bridged all the connections on one side. Finally, on the other side, we ran the cables to the sensors. Now, we have a connection coming in from the mains power into the sensor and then into the relays for each of the 16 sensors and relays.

{{< figure src="img/psu_wired.webp" caption="The 5V power supply, mounted and wired into the case" >}}

With some of the high-voltage wiring out of the way, we decided to mount the 5V power supply, again making use of the perforated holes on the back panel. We wired it to the same 220V going into the terminal strips by tapping into one of the bridged connections. Then, we added another terminal strip just underneath the PSU to get "more" `5V,` and `GND` outputs from it. Being a small capacity PSU (5V3A), it only had one `5V` out and one `GND`. Since we have 4 components that require `5V` in, that was not enough, so that's how we solved that.

{{< figure src="img/final_assembly.webp" caption="The final assembly of the server." >}}

With the PSU mounted and wired, we continued to design a mounting system for the Pi to sit on top of the Arduino. We cut yet another plastic piece to screw into the one on which the Arduino is mounted and then proceeded to connect all the components to the `5V` rail. The 4 parts that need a `5V` input are:

- the server PCB, which holds all of the current sensors
- the relay board, holding the 16 relays and control circuitry
- the Arduino board, acting as an I2C controller
- the Raspberry Pi, acting as the web server host

## Conclusion

To wrap up this week, I'm thrilled with the progress I've made on this project, and I'm excited to see it come to life. I've learned a lot during these eight weeks, and I'm grateful for the opportunity to work on something so challenging and rewarding. I ran into many obstacles and problems I did not foresee, and I got to spend some time with my dad, working together to solve them. All in all, I am calling this a win, even though we did not manage to finish everything on time.

I want to thank you for following along on my journey. It's been a pleasure to share my experience with you all. I hope you've found my updates helpful and maybe even a bit entertaining. I can't wait to show you the final result!
