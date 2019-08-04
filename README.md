# microUPDI
DIY mEDBG programmer with open source hardware!


### Hardware
The microUPDI programmer is based on the [Sparkfun Pro Micro 5V/16MHz board](https://www.sparkfun.com/products/12640) (cheapers knock-offs also compatible) together with a daughterboard. This makes the programmer both cheap and easy to assemble.

<img src="https://i.imgur.com/Pb6wjoD.png" width="265">  <img src="https://i.imgur.com/Rl2J9at.png" width="260">  <img src="https://i.imgur.com/gsxmxBR.png" width="261">


### Features
* A 6-pin UPDI programming connector
  - UPDI interface for programming and debugging
  - Serial interface for communicating with the target over UART
* Voltage selection jumper where you can choose between 5V, 3.3V or no target power
* RXD and TXD LEDs
* Buffered RXD and TXD lines for high impedance inputs and low impedance outputs
* Status LED
  - Power up -> LED is briefly lid
  - Normal operation -> LED is not lid
  - Programming -> Activity indicator
* Small in size (18.3mm x 49.6mm)
* **Open source hardware!**


### Pro Micro hardware modification
In order to get the mEDBG to run properly the AREF pin on the Arduino Pro Micro has to be connected to 5V. Sadly, the AREF pin is not available as a prysical pin for the user, so we have to do a small modification to the Pro Micro itself. Solder a tiny wire from the capacitor to the voltage regulator as seen in the picture below. If this is not done you might (and most likely will) experience issues when trying to communicate with the target. <br/>

*Click to enlarge:*

<img src="https://i.imgur.com/5Pwiufn.jpg" width="400">


### Firmware flashing
In order to flash the Pro Micro with MEDBG firmware you'll have to connect a programmer to the 6-pin connector labled *32U4 ISP*.
Open the build script (Load_firmware.bat on Windows, Load_firmware.sh on Mac/Linux) and edit AVRDUDE_PATH, PROGRAMMER and EXTRA_FLAGS. Then execute the script.

### Usage
After the Pro Micro is flashed with mEDBG firmware it will present itself to the computer as an *mEDBG CMSIS-DAP* device. In Atmel Studio it will show up as a generic mEDBG device, while in Arduino IDE it will show up as an Arduino UNO WiFi Rev2.


Here's an example command on how you can communicate with an ATmega4809 through Avrdude:
```
$ avrdude -Cavrdude.conf -v -patmega4809 -cxplainedmini_updi -Pusb -b115200
```

### Pinout
The UPDI pinout is based on the standard 6-pin ISP pinout. It's revese insertion tolerant, just like the "old" ISP interface. It's also compatible with the Atmel ICE UPDI pinout. This means if you've designed a board to work with this (microUPDI) programmer, you can safely connect and use an Atmel ICE programmer without damaging your board or the ICE programmer.<br/>

Note that this shows the pinout **on the programmer, not the target**. Make sure you connect the targets RXD line to the programmers TXD line, and vice versa.<br/>

*Click to enlarge:*

<img src="https://i.imgur.com/zmy97co.png" width="300">
