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

## "Fifth" Week Review

Hey everyone! I hope you're all having a great start to the new year. I'm here to give you an update on my Devember project. It's been a wild ride so far and I'm excited to share my progress with you.

As you may know, this is technically the sixth calendaristic week of my Devember project, but I did take a week off for the Christmas holidays and New Year's. So, this week is the fifth week that I've been working on this.

One of the biggest challenges I faced this week was staying on schedule. Between work, university, and all the other things life throws at us, I've been pretty busy. That being said, I'm determined to make this project a success and finish it by the end of the month, so I put in the time and effort to make progress.

### Monday

On Monday, I attempted to print and etch the version 1 of the PCB for the controller but it didn't turn out well. I was pretty disappointed but I didn't give up. I decided to update the controller PCB to version v1.1, using 2mm tracks and larger vias to hopefully have better results when etching.

### Tuesday

On Tuesday, I created a circuit schematic for the server PCB to get an idea of the components and connections required. I considered getting an I2C ADC for the Raspberry Pi but soon dropped the idea, mainly due to cost considerations. I already had the Arduino Mega and even so, getting enough analog channels would be more expensive via ADC boards than by using an Arduino as an ADC.

### Wednesday

On Wednesday, I teamed up with my dad to create a PCB for the Pi PDU server to connect all the current sensors by manually drawing with a paint marker. It was pretty cool to work with him on this project. We also brainstormed and came up with a layout for the components inside the Pi PDU server case. I also updated the PCB for the Pi PDU controller to v2 to use GPIO expanders for a much simpler design.

### Thursday

On Thursday, I etched the Pi PDU server PCB and drilled some of the holes. I also cut the hole for the power socket in the Pi PDU controller case. It was a bit of a tedious process but it was worth it in the end.

### We don't talk about Friday

On Friday, I took a break. I figured I deserved a little time off after all the work I've been putting in these days.

In this context, time off meant working on my masters thesis. Apparently they require us to upload some progress on it every semester instead of doing all of the work in the last 2 weeks... you know... like any "normal" student would 😅

### Saturday

On Saturday, I printed the controller PCB v2. I also etched the controller PCB v2 and it turned out great! I was so relieved and excited. I also drilled the hole for the ethernet module in the back panel of the controller case and drilled the Pi PDU server PCB pin-holes.

### Sunday

On Sunday, I worked with my dad on the Pi PDU server case. We cut the new front panel from a 3mm sheet of metal, cut the case into pieces and drilled the holes for the power plugs and mounting screws. It was a pretty fun and satisfying process.

## Final Thoughts

As I come closer to the end of the project, I'm not sure which direction I want to take this series in for the next four weeks. I've been thinking about a few different options.  
One idea is to continue this series as a weekly log and start a new series in parallel, something like Pi PDU DevLog or BuildLog. This will probably be a four-part series, with one part per section of the project (Controller hardware, Controller software, Server hardware, Server software).  
Another idea is to integrate that series as the four closing posts for this one, but it feels a bit weird to me to change the format mid-series.

If you have any suggestions on which direction I should go, let me know in the comments down below! Until then, stay tuned for the next update on my Devember project.

I'll see you in the next one!
