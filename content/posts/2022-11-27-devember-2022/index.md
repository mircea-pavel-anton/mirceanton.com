---
title: Devember 2022 DevLog Introduction
description:
slug: devember-2022-introduction

series: devember-2022
tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2022-11-27"
---

> I, Mircea Anton, will participate to the next Devember. My Devember project will be “PiPDU”. I promise I will program for my Devember for at least an hour, every day of the next December. I will also write a ~~daily~~ weekly public devlog and will make the produced code publicly available on the internet. No matter what, I will keep my promise.

## What is a piPDU

If the name is not suggestive enough, piPDU is a smart PDU, powered by Raspberry Pi and Arduino. I intend to build it and mount in my Home Lab rack, all by the end of December (hopefully before Christmas, but we'll see about that 😅).

## Why am I building this

I was inspired by projects such as the TinyPilot and the PiKVM and I want to contribute to the community. To do so, I decided to build a project in that same style: an enterprise DNA product built with Raspberry Pis.

The problem I am solving with this project is twofold:

1. I want to be able to see the power consumption for each of my servers, individually. To do that, I don't want to use a Kill-a-watt and crawl behind my server rack. I want the data to be displayed in a webpage.
2. I want to be able to turn devices on and off remotely, without crawling to the back of the server rack to pull plugs out. Ideally, I want a webpage which I can visit to toggle individual plugs.

## What are the goals of the project

At the end of this project, I will have 2 boxes that I can mount on my rack. One will be the PDU itself while the other will be a controller.

The first of the two boxes, the PDU itself, will have 16 power plugs on it, which I will be able to turn on and off by sending some API requests to a specific address, as well as monitor the power consumption on each plug individually.  
Additionally, this box will also host a small web page which will show the power consumption for each socket in real time as well as a button to turn that socket on and off.

The second box, the controller, will have 16 buttons on it and an LCD display. Each button will be controlling one of the outlets on the server and the LCD display will be used to show stats. There are two possible actions to be triggered by the buttons:

- a short press will show the current power consumption for the associated plug on the LCD
- a long press will toggle that socket on/off on the PDU;

Additionally, each button will have a status LED to show whether or not the socket is on or off.

The reason I am making them as 2 separate boxes is that I want to mount the PDU itself on the back of my rack, somewhere in the middle (height-wise) while the controller will be mounted at the top on the front of my rack, for easy access.

### The piPDU Server
<!-- todo add image here? -->
In my current configuration, the server itself will be a 5U box that is going to have 16 Schuko plugs on it.  
Each plug will be wired to both a current sensor and a relay. Since that requires 16 Analog inputs to get the reading from each current sensor, as well as 16 digital pins to control the relays, I will use an Arduino mega to interface with all these components.

To expose everything over a REST API, I will add a Raspberry Pi zero which will host the web server. It will communicate with the Arduino over I2C and it will serve as an interface to all the sensors and relays. There will be API endpoints for each plug to turn them on and off, while the metrics themselves will be exposed over WebSockets for real-time communication (probably).

### The piPDU Controller
<!-- todo add image here? -->
The piPDU controller will be a 2U box with 16 arcade buttons mounted on it alongside a 2004 LCD display.

I chose arcade buttons because they have an LED built-in I can use for status indicators and, due to their circular shape, drilling holes in a 2U plate should be easy. For the display, I went with a 2004 LCD, for no reason other than I already had one lying around.   All these components will wired to a raspberry pi zero which will be sending out API requests to the server to control the PDU.

The internals for this one are much simpler. It is just going to be a Raspberry Pi Zero connected to the buttons and the LCD directly that will send out API requests to the server.
