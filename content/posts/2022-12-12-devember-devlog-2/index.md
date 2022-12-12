---
title: "Devember 2022: "
description:

series: [ Devember 2022 ]
series_order: 2

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2022-12-12"
---

Introduction:

Hello and welcome to my Devember devlog for the 2nd week of December. This week I switched gears a bit from last week. Instead of continuing to work on the Server component, I decided to start coding up the Controller as well, to get an initial prototype going. Despite having to take a couple of days off to study for some exams, I believe I made some decent progress.

## Second Week Review

### Monday

On Monday I actually had my CKA certification exam around noon and then I decided to take the rest of the day off to catch up on some other aspects of life as well. While no progress on Devember has been made today, I still think it was a productive day as I managed to get my CKA and also to decompress a bit.

### Tuesday

Tuesday was both a funny and frustrating day. In the first part of the day I worked on soldering some DC jacks to that gutted out psu so that I can properly wire things up to it instead of taking the "trust me, I'm an engineer" approach.

Later in the day, the order for the missing components came in and you'll never guess what happened. All 16 of the 12V arcade buttons I ordered ended up having 5V LEDs instead 🙃. That means that the 12V PSU, the transistors and most of the other things that were part of that order are now useless for this project... GREAT!

I had already spent the time earlier today to undo all of the cabling for the previous buttons and remove them from the frontplate, so now I decided to make the thing more modular. Instead of mounting the buttons and then wiring the button matrix directly on them, I decided to solder individual wires for each button and LED and then design some circuit board that will implement the actual matrix itself. The buttons and LEDs will probably connect via screw terminals to the board so that they can be easily swapped if needed.

### Wednesday

Wednesday was a bit busy and I did not have a lot of time to work on Devember. I did, however, decide to do the little I can. As such, I ended up soldering the screw terminals on a protoboard and brainstorming some ideas as to how I should run the cabling later on.

### Thursday

{{< figure src="img/pcb_diagram.webp" caption="The PCB design I ended up creating in KiCAD" >}}

Today, I spent a good chunk of the day working on the protoboard circuit for the controller. I ended up getting frustrated because APPARENTLY, enthusiasm is not enough and you also need some skill or whatever 😒. I quickly realised that soldering anything remotely complex is quite a bit above my skill level and got very frustrated relatively quickly.

{{< figure src="img/pcb_model.webp" caption="A 3D render of the PCB design" >}}

In a futile attempt to maintain what was left of my sanity, I decided to just open up good ole' KiCad and create a custom PCB that the Pi Zero will just slot into and get that printed eventually. I managed to get an initial design done, but I decided to wait a bit before printing it in case I come up with any more adjustments or other boards to print.

### Friday

Unfortunately, friday was another day in which I didn't get a chance to work on Devember. I was quite busy and in the last part of the day I decided to spend some time studying for the CKAD exam I have on Monday, as I was a bit behind.

### Saturday

{{< figure src="img/circuit_schematic.webp" caption="Circuit Diagram for the PiPDU Controller" >}}

On saturday I set up the circuit for the controller component on a breadboard. I used the gutted out PSU to power everything. Next, I wired up the LCD display and wrote a bit of code to validate it is working. Finally, I connected the wires for a few of the buttons and LEDs to have a platform that I can write code for and test on.

### Sunday

{{< figure src="img/fe_vs_be.webp" caption="" >}}

While I do not have much to show visually for today, it was still a productive day at least in terms of coding. I started off slowly by creating some of the "supporting infrastructure" for the code. I firstly set up a Singleton class for the Configuration object and decided on a structure for the `config.yaml` file.

Next, I refactored all the code related to the LCD display in another Singleton class. I intend to implement only 2 public methods for this class. One of the functions should put the display in an "idle" state, which will just show maybe the "PiPDU" text alongside the overall power consumption for all of the sockets as well as todays' date. The second one should put the display in an "info" state to show information specific to a particular socket after a button was pressed.

Finally, I implemented some trivial scraping of the Prometheus metrics endpoint exposed by the Server component. I threw that in a `while True:` loop with a customizable delay, since I intend to implement the button press functionality via interrupts, and called it a day.

## Ending

That's about it for this week! While I did not get around to work every single day, as life managed to get in the way, I did make steady progress and I think that that's what counts!
