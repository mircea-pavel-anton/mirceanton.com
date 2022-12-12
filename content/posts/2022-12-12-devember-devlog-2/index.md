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
date: "2022-12-05"
---

Monday:
- did not get around to work on devember, sadly, as I had my CKA exam and took the day off to decompress a bit

Tuesday:
- worked on modding the gutted out psu by adding DC jacks to it
- removed all of the old buttons from the controller front plate
- mounted the new buttons on the controller frontplate
- soldered individual wires to the buttons and LEDs

Wednesday:
- soldered components to a protoboard, trying to make a custom PCB for the controller

Thursday:
- worked on the custom pcb a bit more, got frustrated, gave up
- designed a custom PCB in KiCAD for the controller
- wrote some code to interact with the LCD

Friday:
- no work on devember today, sadly. I had to study for the CKAD exam I have on monday as I was behind

Saturday:
- set up the controller circuit on a breadboard with the gutted out psu and a pi 4 for development

Sunday:
- wrote quite a bit of code for the controller
- created the config class singleton
- create an LCD singleton to interact with the LCD display
- implemented some basic scraping of the prometheus endpoint served by the pipdu server
