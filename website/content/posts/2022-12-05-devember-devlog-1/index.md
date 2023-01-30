---
title: Planning is Essential, but Plans are Useless
description: In this blog post, I go over the progress I made on my Devember project during the first week of development.

series: [ Devember 2022 ]
series_order: 1

tags:
  - DIY
  - Raspberry Pi
  - Arduino

author: "Mircea-Pavel Anton"
date: "2022-12-05"
---

## Things never go as planned... do they?

Wow, what a week it's been on the PiPDU project! I've had some major successes and a few frustrating setbacks, but overall I'm feeling pretty good about the progress I've made. My plan was to finish up the cases and circuits for both the server and controller this week, but as usual, things didn't quite go as planned. 😬

For those who don't know, the PiPDU is a little gizmo I'm building to make it easy to remotely control the power to my home server rack. It'll let me turn devices on and off from anywhere, as well as keep an eye on their power usage.

## First Week Summary

### Monday

{{< lead >}}Starting with excitement {{< /lead>}}

On **Monday**, I started off the week by fixing up the controller's front plate. I cheated on the start date and asked my dad to drill the 16 holes for the arcade buttons and the cutout for the LCD display last weekend. The edges were a tad bit rough, so I decided to touch 'em up a bit with a black sharpie and it ended up looking much better if I do say so myself!

{{< figure src="img/frontplate.png" caption="The Controller front plate" >}}

After contouring the holes, I mounted the buttons and got them all lined up nicely.

{{< figure src="img/buttons-mounted.png" caption="The front plate with the buttons mounted" >}}

Next up was the soldering! I dusted off dads old, and I do mean old, soldering iron (I am pretty sure it's older than me) and got to work. I soldered the wires for the LED matrix and made sure they were all secure by adding some heat-shrink to every (perfectly executed and with definitely an appropriate amount of solder) joint.

### Tuesday

{{< lead >}}Slow and steady wins the race {{< /lead >}}

**Tuesday** was quite a short and slow day with more of the same. - I connected the i2c controller to the LCD display and then mounted the display on the front plate. \**chef's kiss*\* A perfect fit!

{{< figure src="img/combover.png" caption="I call this one The COMBOVER" >}}

Finally, I soldered the wires for the button matrix and called it a day.

{{< figure src="img/spaghetti-side.png" caption="Do you believe in the flying spaghetti monster?" >}}

### Wednesday

{{< lead >}}I was staring defeat straight in the eyes, and it was looking back at me{{< /lead >}}

**Wednesday** was when things started to get a little tricky. I realized that some of the arcade buttons I bought were a bit different. I noticed that their housing was a different color back on Monday as well, but I thought nothing of it, as I specifically ordered ones with 5V LEDs. BOY WAS I WRONG... Apparently, 3 of the buttons I was using had 12v LEDs, which wasn't going to work with the rest of the system. I spent the day trying to figure out a solution that would not involve tearing out all the buttons (thus undoing all the work I did in the previous days), but eventually, I hit a bit of a roadblock and wasn't sure how to proceed. 😕

{{< figure src="img/buttons.png" caption="Caught red handed!" >}}

If you look closely, you can see in this image that one of the buttons has a grey housing on the inside while the others are black.

### Thursday

{{< lead >}}If nothing's right, go left{{< /lead >}}

**Thursday** was a bit of a change of pace - instead of working on the controller, I decided to focus on the server component. I set up a prototype by connecting the Arduino Mega to the relay board and, using an old PC PSU that I gutted, powered everything. I wrote some code that lets me control the relays and reads data from the analog sensors (which are not connected yet, but some "placeholder" code is there just in case 😅).

{{< figure src="img/abomination.png" caption="An abomination of a circuit" >}}

The code was set up to run the two jobs in pseudo-multithreading via some handy tutorial I found online. One of the jobs listens for commands on the serial connection while the other polls the sensors and prints the data back. For now, I was sending commands manually from my computer over the USB connection to the Arduino and using the serial monitor to test everything out, but it all seemed good.

### Friday

{{< lead >}}Great communication begins with a connection{{< /lead >}}

**Friday** was all about implementing the serial communication between the Arduino and Raspberry boards. I expected this to be a bit of a challenge, but I figured it out and got everything working quite rapidly.

Then, I moved on to setting up a basic Flask API server. I configured a "default" route to a `/ping` endpoint that simply responds with `/pong` (funny and unique, I know) to validate the server is actually running and responding to requests. I then set up a `POST` endpoint at `/api/v1/sockets/<number>` to send commands to the Arduino. Since the Arduino is reading `chars` over the serial connection, I cannot send the socket IDs over to instruct it on which to toggle, as numbers over 9 require 2 characters. As such, I decided to map them to letters of the alphabet and called it a day for now.

### Saturday

{{< lead >}}Teamwork makes the dream work{{< /lead >}}

**Saturday** was a team effort 🤝 - I worked with my dad to come up with a circuit diagram for the controller to work with the 12V arcade buttons. We spent a few hours brainstorming, sketching out ideas, and browsing online for parts, and finally landed on a plan. We decided to wire only the buttons as an array and then use individual connections for the LEDs as that would allow easier granular control over them. We were concerned initially that the Pi might not have enough GPIO pins for this, but apparently, we will be using 26 out of 28, so we're good! Then, we picked up a nifty little power supply that outputs both 12V 1A and 5V 1A, allowing me to supply both the LEDs and the Pi with power. Finally, to control the LEDs we picked some 2n2222 NPN transistors.

I then went online and ordered the parts I needed (and quite a few I did not, but maybe will, though probably not, but eh, better safe than sorry, right?). In the afternoon, I did some brainstorming on the internal layout for the components inside the boxes, trying to figure out the best way to arrange everything.

### Sunday

{{< lead >}}Code is like a joke. If you have to explain it, it’s probably not that great{{< /lead >}}

**Sunday** was all about code code code - I spent the day tinkering with the python code I had written the previous days. I also refactored the spaghetti code (it was all in a single file... can you imagine?? 😰) into classes to make it more organized and easier to work with.

I isolated all the code related to parsing the config file to a dedicated singleton class. That way, whenever I instantiate a `Config()` object, I am reusing the instance that was previously created or create a new one if none are already existing. This basically ensures that the actual `config.yml` file on disk is parsed a single time during the lifecycle of the application and that the data is always there when I need it. Similarly, I implemented a singleton for establishing the serial connection to the Arduino and sending/receiving messages. Was this the best design choice? To be honest, I don't think so, but it was easy for me to implement and it got the job done nicely!

Then, I added a `GET` endpoint to the same `/api/v1/sockets/<number>` path to retrieve the current status of a given socket and finally configured a Prometheus exporter to show the 16 measurements sent by the Arduino over serial as gauges in the `/metrics` endpoint. This exporter runs in a separate thread.

## Conclusion

All in all, it's been a great week on the PiPDU project. I'm really happy with the progress I've made even though none of it was in the areas it was planned to be in. I'm excited to move forward with the next steps. In the coming week, I plan to work on the case and code for the controller (oh, the irony). The order for the missing components is already placed and I hope it will arrive on time for me to wire up the buttons and LEDs, mount them to the front plate and have the hardware in place to start doing some work on the code.
