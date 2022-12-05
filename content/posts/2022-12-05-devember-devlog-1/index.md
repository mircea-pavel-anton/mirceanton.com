---
title: "Devember 2022: Planning is Essential, but Plans are Useless"
description: As my first week of devember has passed, I came to realize that planning itself is good, as it gives you a clearer path to walk on, but plans mean nothing in the end

series: [ Devember 2022 ]
series_order: 1

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2022-12-05"
---

## Introduction

## First Week Summary

### Monday

- touched up the controller front-plate after drilling
- mounted the buttons to the front plate
- soldered the i2c controller to the LCD display
- mounted the LCD display to the front-plate
- soldered the LED matrix wires.

### Tuesday

- soldered wires to the i2c controller for the LCD
- soldered the wires for the button matrix

### Wednesday

- realized i have an issue with some of the buttons being 12v
- troubleshoot and get discouraged

### Thursday

- changed gears to work on the server
- created a prototype for the server by hooking up the arduino to the relay board
- used an old, gutted out PC PSU to power the arduino and the board
- wrote the arduino code that turns on/off relays and reads data from the analog sensors and sends it twice per second via serial

### Friday

- implemented the actual serial communication between the arduino and the raspberry
- wrote the `POST` endpoint to send commands to the arduino to toggle relays
- wrote a background thread that prints the values the arduino sends over serial
- wrote a prometheus exporter to expose those metrics

### Saturday

- worked with dad to come up with a circuit diagram for the controller with the 12V buttons
- decided on which parts i need to buy next and placed the order
- did some brainstorming on the internal layout for the components inside the boxes

### Sunday

- fixed and validated the python code wrote yesterday
- refactored the code wrote the past few days into individual classes (config singleton, arduino singleton, exporter singleton)
- added the `/ping` route to test connectivity
- added the `GET` endpoint to see the status of the socket
- formatted the api responses as JSON

## Conclusion

Overall, it was a productive week on the PiPDU project. I am pleased with the progress I have made and am excited to move forward with the next steps. Stay tuned for updates on my continued work on the PiPDU.
