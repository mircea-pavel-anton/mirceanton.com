---
title: New Year, Same Devember
description: TODO

series: [ Devember 2022 ]
series_order: 5

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2023-01-12"
---

Hey everyone! I hope you're all having a great start to the new year. I'm here to give you an update on my Devember project. It's been put on hold over the holidays, but I have started working on it again, and I'm excited to share my progress with you.

As you may know, this is technically the sixth week of my Devember project, but I took a week off for the Christmas holidays and New Year's. Thus, this is the fifth week I've been actively working on this.

One of the biggest challenges I faced this week was staying on schedule ☹️. Between work, university, and all the other things life throws at us, I've been pretty busy. That being said, I'm determined to make this project a success and finish it by the end of the month, so I put in the time and effort to make progress. 

## "Fifth" Week Review

### Monday

{{< 
  figure src = "img/controller_pcb_v1_front.png"
         caption = "v1.0 of the controller PCB, backside"
>}}

On Monday, I attempted to print version 1 of the PCB for the controller with my dad. I say "attempted" because the result wasn't really all that great. We tried using the "Iron on Glossy paper method", but we used regular paper 😆.

{{< 
  figure src = "img/controller_pcb_v1_back.png"
         caption = "v1.0 of the controller PCB, backside"
>}}

We printed the PCB from KiCAD on a sheet of paper, setting the scale to `1:1`. We then took the printed paper, cut it to size to fit on the PCB, and went to town ironing it. After about 5 minutes of ironing, we put it in water so the paper would dissolve and tear apart, leaving only the toner on the PCB. That worked decently well, but some tracks were not continuous after corroding it with Ferric chloride. Overall, it was not as good of a result as I had hoped.

### Tuesday

{{< 
  figure src = "img/server_schematic.png"
         caption = "The circuit diagram for the server"
>}}

On Tuesday, I created a circuit schematic for the server circuit to get an idea of the components I need and the required connections.

I considered getting a few I2C ADCs (Analog-to-Digital Converters) for the Raspberry Pi. I soon dropped the idea, mainly due to cost considerations. For some context, I am currently using an Arduino Mega to act as a glorified I2C device, providing the Pi with 16 analog inputs as well as 16 digital outputs. I quickly realized that getting the same amount of analog channels via ADC boards would be more expensive than getting an Arduino Mega. Furthermore, I already had the Arduino, so it felt like a waste of money to buy more components I didn't need.

### Wednesday

> I forgot to take a picture of the circuit drawing on the PCB... 😅

On Wednesday, I teamed up with my dad again, and we worked on creating a small PCB for the server circuit I had designed the day before. We decided to try a different method for this one, namely drawing the circuit on a piece of copper-clad laminate by hand, using a paint marker. We chose this approach for 3 reasons:

- this PCB had a much simpler layout which could reasonably be drawn by hand
- I really didn't feel like making a PCB design for this 
- we wanted to try another method of printing PCBs at home to see what kinds of results we're getting

Next, we brainstormed a bit (a bit more than just a bit)  for the layout of the components inside the server case. It's gonna be a pretty tight fit, but it might just work.

We also debated simplifying the controller PCB layout, given the sub-par results we got earlier this week. I proposed using I2C GPIO expanders instead of running direct connections to the Pi. Not only will this simplify the overall design, but it would also allow us to link each button individually to the Pi instead of using a matrix.

### Thursday

{{< 
  figure src = "img/server_pcb.png"
         caption = "v1.0 of the server PCB"
>}}

On Thursday, we etched the server PCB, which we had drawn the day before, and drilled some of the holes. The results for this one were much, much better. We used a thick (thicc) marker to draw the traces, so we had high hopes from the start. The only downside is that, since the marker was so thick, we ended up with a bunch of shorts, especially for the pins of the current sensors, since they are so close to one another. We fixed those by scratching off the copper with a flat-head screwdriver.

{{< 
  figure src = "img/controller_case_power_hole.png"
         caption = "The hole cut into the back panel of the controller case, for the power socket"
>}}

We also cut the hole for the power socket in the controller case.

{{< 
  figure src = "img/controller_case_power_mounted.png"
         caption = "The power socket, mounted to the back of the controller case"
>}}

And then mounted it.

### We don't talk about Friday

On Friday, I took a break. I figured I deserved a little time off after all the work I've been putting in these days. /s

In this context, time off meant working on my master's thesis. Apparently, they require us to upload some progress on it every semester instead of doing all the work in the last 2 weeks... you know... like any "normal" student would 😅

### Saturday

{{< 
  figure src = "img/controller_pcb_v2.png"
         caption = "The PCB for the controller, version 2.0"
>}}

We gave it another go on Saturday and printed the controller PCB v2. Thankfully, the results this time were a heck of a lot better! We used the same process, with some minor tweaks, given what we learned:

- print the circuit on a piece of paper, glossy this time
- cut the paper to size to fit on the copper-clad laminate
- iron it (for closer to 10 minutes this time)
- let it rest in water
- peel off the paper (the glossy paper peeled straight off, as opposed to regular paper)
- give it a nice ferric chloride bath (for ~30 minutes, so that all the copper came off)
- wash the board and clean it with some paint thinner to get the toner off

Let me know in the comments if you want me to do a write-up on how we printed the PCBs and go into more detail about the process.

{{< 
  figure src = "img/ethernet_jack.png"
         caption = "The panel-mount RJ45 socket"
>}}

Finally, the panel-mount ethernet sockets came in today.

{{< 
  figure src = "img/controller_case_ethernet_hole.png"
         caption = "The hole for the panel-mount RJ45 socket"
>}}

We drilled a hole for it in the back panel of the controller case.

{{< 
  figure src = "img/controller_case_ethernet_mounted.png"
         caption = "The panel-mount RJ45 socket, mounted to the case"
>}}

And finally mounted it as well.

### Sunday

Sunday was a team effort with my dad again. We worked on the Pi PDU server case this time. There were quite a few mods required to make it work, so we got down to business.

First things first, we were worried that the front panel for the 5U case I got would be too thin and would not support the forces when I pushed and pulled on the sockets to plug things in over time. As such, we cut the new front panel from a 3mm sheet of metal.

{{< 
  figure src = "img/power_sockets_holes.png"
         caption = "The new front-panel for the server, with the holes for the power sockets drilled"
>}}

Next, we decided on a layout for the power sockets, marked them down, and started drilling. Let me tell you... It may not sound like a lot, but 3mm of metal is much stronger than you think. Just give it a go and try to drill 45mm holes in that... As if that wasn't enough, we had to drill 4 mounting holes for each socket, a total of 64 more holes 😓. It took us almost the whole day, but we got it done 🎖️.

{{< 
  figure src = "img/power_sockets_mounted.png"
         caption = "The new front-panel for the server, with the power sockets mounted"
>}}

Finally, we decided we couldn't leave the front panel to be the detachable side of the case, since that will hold all of the higher voltage wires. Hence, we had to cut the case at basically every edge so we could redesign the way it closes. We still need to finish that, but hopefully, we'll get it done next week!

## Final Thoughts

As I get closer to the project's end, I'm unsure which direction I want to take this series in for the next four weeks. I've been thinking about a few different options.  
One idea is to continue this series as a weekly log and start a new series in parallel, something like Pi PDU DevLog or BuildLog. This will probably be a four-part series, with one part per section of the project (Controller hardware, Controller software, Server hardware, Server software).  
Another idea is to integrate that series as the four closing posts for this one, but it feels weird to change the mid-series format.

If you have any suggestions on which direction I should go, let me know in the comments down below! Until then, stay tuned for the next update on my Devember project.

I'll see you in the next one!
