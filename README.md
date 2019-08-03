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
In order to get the mEDBG to run properly the AREF pin on the Arduino Pro Micro has to be connected to 5V. Sadly, the AREF pin is not available as a prysical pin for the user, so we have to do a small modification to the Pro Micro itself. Solder a tiny wire from the capacitor to the voltage regulator as seen in the picture below. If this is not done you might (and most likely will) experience issues when trying to communicate with the target.

**Click to enlarge:**

<img src="https://i.imgur.com/5Pwiufn.jpg" width="400">


### Usage
After the Pro Micro is flashed with mEDBG firmware it will present itself to the computer as an CMSIS DAP device. In Atmel Studio it will show up as a generic mEDBG device, while in Arduino IDE it will show up as an Arduino UNO WiFi Rev2.
