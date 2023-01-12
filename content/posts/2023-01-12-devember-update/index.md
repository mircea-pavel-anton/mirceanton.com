---
title: Status Update
description: In this blog post, I go over the upgrades and changes I have planned for my homelab in the coming year.

series: [ Devember 2022 ]
series_order: 5

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2023-01-12"
---

## Mon

- (tried to) print and etch the PCB v1 for the controller but it turned out bad
- updated the controller PCB to version v1.1 to use 2mm tracks and larger viases to maybe have better results when etching

## Tue

- Created a circuit schematic for the server PCB to get an idea of the components and connections required; considered getting an I2C ADC for the Pi but I soon dropped the idea, mainly due to cost considerations, since I already had the arduino Mega and even so, getting enough analog channels would be more expensive via ADC boards than by using an Arduino as an ADC

## Wed

- worked with dad to create a PCB for the pipdu server to connect all the current sensors by manually drawing with a paint marker
- brainstormed and came with a layout for the components inside the pipdu server case
- updated the pcb for the pipdu controller to v2 to use GPIO expanders for a much much simpler design

## Thu

- etched the pipdu server pcb and drilled some of the holes
- cut the hole for the power socket in the pipdu controller case

## Fri

N/A

## Sat

- printed the controller pcb v2
- etched the controller pcb v2 -> turned out great, actually!
- drilled the hole for the ethernet module in the back panel of the controller case
- drilled the pipdu server pcb pin-holes

## Sun

- worked with dad on the pipdu server case:
  - cut the new front panel from a 3mm sheet of metal
  - cut the case into pieces
  - drilles the holes for the power plugs and mounting screws
