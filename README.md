# microUPDI
DIY UPDI programmer with open-source hardware.
**Available for purchase at my [Tindie store](https://www.tindie.com/products/MCUdude/microupdi-programmer/)!**


## Hardware
The microUPDI programmer is based on the [Sparkfun Pro Micro 5V/16MHz board](https://www.sparkfun.com/products/12640) (cheaper knock-offs also compatible) together with a daughterboard. This makes the programmer both cheap and easy to assemble.

<img src="https://i.imgur.com/Pb6wjoD.png" width="265">  <img src="https://i.imgur.com/Rl2J9at.png" width="260">  <img src="https://i.imgur.com/gsxmxBR.png" width="261">


## Features
* A 6-pin UPDI programming connector
  - UPDI interface for programming and debugging
  - Serial interface for communicating with the target over UART
* Voltage selection jumper where you can choose between 5V, 3.3V, or no target power
* RXD and TXD LEDs
* Buffered RXD and TXD lines for high-impedance inputs and low-impedance outputs
* Status LED
  - Power up -> LED is briefly lid
  - Normal operation -> LED is not lid
  - Programming -> Activity indicator
* Small in size (18.3mm x 49.6mm)
* **Open source hardware!**


## Firmware
To flash the Pro Micro with mEDBG firmware you'll have to install a hardware package to Arduino IDE.

#### Boards Manager Installation
* Open the Arduino IDE 1.8.x. IDE 2.x is not yet supported.
* Open the **File > Preferences** menu item.
* Enter the following URL in **Additional Boards Manager URLs**:
    ```
    https://mcudude.github.io/microUPDIcore/package_MCUdude_microUPDIcore_index.json
    ```
* Separate the URLs using a comma ( **,** ) if you have more than one URL
* Open the **Tools > Board > Boards Manager...** menu item.
* Wait for the platform indexes to finish downloading.
* Scroll down until you see the **microUPDI flash tool** entry and click on it.
* Make sure you have selected the latest version.
* Click **Install**.
* After installation is complete close the **Boards Manager** window.

#### Manual Installation
Visit [microUPDIcore](https://github.com/MCUdude/microUPDIcore), and click on the "Download ZIP" button. Extract the ZIP file, and move the extracted folder to the location "**~/Documents/Arduino/hardware**". Create the "hardware" folder if it doesn't exist.
Open Arduino IDE and a new category in the boards menu called "microUPDI Firmware Uploader" will show up.

### Flashing the Arduino Pro Micro
* Select **microUPDI Firmware Uploader** from the boards menu.
* Connect your Arduino Pro Micro hardware to your computer through a micro USB cable.
* Click on the upload button. This will upload some pre-built binaries, and the code in the current sketch isn't touched at all.
* The IDE will now automatically try to reset the Pro Micro and load it with new firmware.
  - If you've already flashed your Pro Micro with mEDBG firmware and want to upgrade or re-flash it you will most likely encounter issues with the auto reset functionality and uploading will fail. All you have to do is click *Upload* in Arduino IDE and then manually reset the Pro Micro within about three seconds. Resetting can be done by shorting out pin 5 and 6 on the 32U4 ISP header for a brief second with a tweezer, screwdriver, or jumper wire. If you need a longer timeout delay, you can quickly reset the 32U4 twice. This will make the board stay in bootloader mode for an extended period, usually about 8 seconds. Read more about manual bootloader entry [here](https://learn.sparkfun.com/tutorials/pro-micro--fio-v3-hookup-guide/troubleshooting-and-faq#ts-reset).
* After uploading is finished you may get an error telling you there's **content mismatch from flash address 0x7000**. This is normal and is to be expected due to the protected bootloader area, and the standard Pro Micro bootloader is retained.
* Congratulations, you now have a working UPDI programmer!

### Usage
After the Pro Micro is flashed with mEDBG firmware it will present itself to the computer as an **mEDBG CMSIS-DAP** device. In Atmel Studio it will show up as a generic mEDBG device, while in Arduino IDE it will show up as an **Arduino UNO WiFi Rev2*.

If you're using the microUPDI programmer with [megaTinyCore](https://github.com/SpenceKonde/megaTinyCore) you just select the *Xplained Mini (mEDBG, debug chip: ATmega32u4)* option in the Programmers menu. For [MegaCoreX](https://github.com/MCUdude/MegaCoreX) it's *Atmel mEDBG (microUPDI)*.

Here's an example command on how you can communicate with an ATmega4809 through Avrdude:
```
$ avrdude -C avrdude.conf -v -p atmega4809 -c xplainedmini_updi
```

### Pinout
The UPDI pinout is based on the standard 6-pin ISP pinout. It's reverse insertion tolerant, just like the "old" ISP interface. It's also compatible with the Atmel ICE UPDI pinout. This means if you've designed a board to work with this (microUPDI) programmer, you can safely connect and use an Atmel ICE programmer without damaging your board or the ICE programmer.<br/>
**Note that the RXD and TXD lines are swapped on the target.**

*Click to enlarge:*

<img src="https://i.imgur.com/pUzZbEq.png" width="500">
