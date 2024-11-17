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
* Open the Arduino IDE
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


### Tinkering with the EEPROM content
The EEPROM content of the microUPDI content contains things like serial number, kit name, manufacturer string, target device ID, and name. The content is loosely documented in [this Avrfreaks forum post](https://www.avrfreaks.net/s/topic/a5C3l000000UkjBEAS/t192342?comment=P-1635680).

<details>
<summary><b>mEDBG EEPROM mapping</b></summary>

```
MEDBG_CONFIG_SERIAL_NUMBER_BANK = 0x00
MEDBG_CONFIG_SERIAL_NUMBER_ADDRESS = 0x04
MEDBG_CONFIG_SERIAL_NUMBER_LEN = 20
 
MEDBG_CONFIG_KIT_NAME_BANK = 0x00
MEDBG_CONFIG_KIT_NAME_ADDRESS = 0x18
MEDBG_CONFIG_KIT_NAME_LEN_MAX = 50
 
MEDBG_CONFIG_MANUFACTURER_NAME_BANK = 0x00
MEDBG_CONFIG_MANUFACTURER_NAME_ADDRESS = 0x4A
MEDBG_CONFIG_MANUFACTURER_NAME_LEN_MAX = 50
 
MEDBG_CONFIG_TARGET_NAME_BANK = 0x00
MEDBG_CONFIG_TARGET_NAME_ADDRESS = 0x7C
MEDBG_CONFIG_TARGET_NAME_LEN_MAX = 30
 
MEDBG_CONFIG_FIRE_BANK = 0x00
MEDBG_CONFIG_FIRE_ADDRESS = 0xFE
MEDBG_CONFIG_FIRE_LEN = 1
 
MEDBG_CONFIG_FIRE_ISPDW_VALUE = 0xFF
MEDBG_CONFIG_FIRE_SWD_VALUE = 0xFE
MEDBG_CONFIG_FIRE_TPI_VALUE = 0XFD
MEDBG_CONFIG_FIRE_UPDI_VALUE = 0xFC
 
MEDBG_CONFIG_SUFFER_BANK = 0x01
MEDBG_CONFIG_SUFFER_ADDRESS = 0x220
MEDBG_CONFIG_SUFFER_LEN = 1
```

</details>

It's very easy to use Avrdude (8.0 or newer is highly recommended) to change the content. Simply connect an ISP programmer, connect it to the ISP connector on the underside of the microUPDI programmer (a 6-pin male header can be press-fitted), and run Avrdude. In the example below I'm using the USBasp programmer with Avrdude 8.0 to view and modify the EEPROM content:

```
$ avrdude -c usbasp -p atmega32u4 -t

avrdude> read eeprom 0 256 # Read 256 bytes from EEPROM starting from address 0
Reading | ################################################## | 100% 0.09 s 
0000  ff ff ff ff 4d 49 43 52  4f 55 50 44 49 50 52 4f  |....MICROUPDIPRO|
0010  47 52 41 4d 4d 45 52 58  6d 69 63 72 6f 55 50 44  |GRAMMERXmicroUPD|
0020  49 20 70 72 6f 67 72 61  6d 6d 65 72 00 ff ff ff  |I programmer....|
0030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
0040  ff ff ff ff ff ff ff ff  ff ff 4d 69 63 72 6f 63  |..........Microc|
0050  68 69 70 00 ff ff ff ff  ff ff ff ff ff ff ff ff  |hip.............|
0060  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
0070  ff ff ff ff ff ff ff ff  ff ff ff ff 41 54 6d 65  |............ATme|
0080  67 61 34 38 30 39 00 ff  ff ff ff ff ff ff ff ff  |ga4809..........|
0090  ff ff ff ff ff ff ff ff  ff ff 00 1e 96 51 ff ff  |.............Q..|
00a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00b0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00d0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00e0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff fc ff  |................|

avrdude> write eeprom 4 20 0xff ... # Wipe the existing serial number by writing 20 0xff bytes to the EEPROM, starting from address 4
Caching | ################################################## | 100% 0.00 s

avrdude> read eeprom 0 256
Reading | ################################################## | 100% 0.00 s 
0000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
0010  ff ff ff ff ff ff ff ff  6d 69 63 72 6f 55 50 44  |........microUPD|
0020  49 20 70 72 6f 67 72 61  6d 6d 65 72 00 ff ff ff  |I programmer....|
0030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
0040  ff ff ff ff ff ff ff ff  ff ff 4d 69 63 72 6f 63  |..........Microc|
0050  68 69 70 00 ff ff ff ff  ff ff ff ff ff ff ff ff  |hip.............|
0060  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
0070  ff ff ff ff ff ff ff ff  ff ff ff ff 41 54 6d 65  |............ATme|
0080  67 61 34 38 30 39 00 ff  ff ff ff ff ff ff ff ff  |ga4809..........|
0090  ff ff ff ff ff ff ff ff  ff ff 00 1e 96 51 ff ff  |.............Q..|
00a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00b0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00d0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00e0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff fc ff  |................|

avrdude> write eeprom 4 "MYSERIALNUMBER" # Write new serial number to EEPROM, starting from address 4
Caching | ################################################## | 100% 0.00 s

avrdude> read eeprom 0 256
Reading | ################################################## | 100% 0.00 s 
0000  ff ff ff ff 4d 59 53 45  52 49 41 4c 4e 55 4d 42  |....MYSERIALNUMB|
0010  45 52 00 ff ff ff ff ff  6d 69 63 72 6f 55 50 44  |ER......microUPD|
0020  49 20 70 72 6f 67 72 61  6d 6d 65 72 00 ff ff ff  |I programmer....|
0030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
0040  ff ff ff ff ff ff ff ff  ff ff 4d 69 63 72 6f 63  |..........Microc|
0050  68 69 70 00 ff ff ff ff  ff ff ff ff ff ff ff ff  |hip.............|
0060  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
0070  ff ff ff ff ff ff ff ff  ff ff ff ff 41 54 6d 65  |............ATme|
0080  67 61 34 38 30 39 00 ff  ff ff ff ff ff ff ff ff  |ga4809..........|
0090  ff ff ff ff ff ff ff ff  ff ff 00 1e 96 51 ff ff  |.............Q..|
00a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00b0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00d0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00e0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff fc ff  |................|

avrdude> quit
Synching cache to device ... 
Writing | ################################################## | 100% 0.04 s 

Avrdude done.  Thank you.
```

