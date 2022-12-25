---
title: Week 4 - 
description: 

series: [ Devember 2022 ]
series_order: 4

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2022-12-26"
---

## Fourth Week Review

### Monday

- had my CKS exam, did not work on piPDU

### Tuesday

- fixed all errors in the PCB and Schematic designs
- added mounting holes and tweaked the traces a bit

### Wednesday

- I initially sat down to work on the project and realized I am not too sure what to work on. I thought I should take some time to plan out what is left to do, at least as general ideas to focus my work better. Some extra features I decided to work on next:

    - On the software side:
        - For the controller:
            - automatically trigger the long press action if the button has been held for more than the long press duration threshold
        - For the server:
            - implement the ability to trigger custom actions before actually powering off the socket. For example, sending some commands to gracefully shut down the system before powering it off
            - implement the ability to name sockets to know what is connected where
            - implement dedicated endpoints for turning sockets on/off instead of just a toggle endpoint
            - implement a full `info` endpoint to get status and other details for the sockets
            - create a `yaml` config file to store the custom names and commands for the sockets
            - implement certificate based auth and HTTPS
        - Extras:
            - implement a web UI for seeing PDU information and turning sockets on/off
            - implement a discord bot? maybe idk
    - On the hardware side:
        - For the controller
            - order and mount the PCB for the controller
            - mount and wire up the PSU for the controller
            - drill the hole for the power plug
            - drill the hole for the RJ45 socket
        - For the server:
            - drill the holes in the case for the sockets
            - drill the hole in the case for the RJ45 socket
            - mount the components inside the case

### Thursday

- realized I neglect my masters degree assignments for the past few weeks so I had to do all the assignments as most of them were due this week :')

### Friday

- Did quite a bit of coding today. Her is what I worked on:
    - refactored the api routes and moved them to dedicated files in a more organized folder structure via Flask blueprints
    - Implemented the `Socket` class to abstract away the logic for turning sockets on/off and initial states
    - Implemented custom serial commands for turning on/off sockets via lowercase or uppercase letter instead of basic toggle functionality
    - Implemented the `SocketArray` singleton to cache the array of 16 sockets
    - Implemented dedicated `/on` and `/off` endpoints in the API server instead of basic toggle functionality
    - Added the `/info` endpoint for a given socket
    - Implemented `sockets.yaml` config file to add the ability to name sockets and provide an initial state for them

### Saturday

- Did a lot of coding today. Her is what I worked on:
    - refactored the entirety of the code; added docstrings
    - added logging (but it is kinda broken for now)
    - added back the socket toggle functionality
    - implemented the `Led` and `LedArray` classes for handling the LEDs on the controller

### Sunday

- It's Christmas... give me a break
