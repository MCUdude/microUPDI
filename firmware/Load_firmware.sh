#!/bin/bash

#################################################################################################
## Created by MCUdude for flashing mEDBG UPDI firmware onto Arduino Pro Micro boards           ##
## https://github.com/MCUdude/microUPDI                                                        ##
##                                                                                             ##
## If you're a Windows user it's easier to run Load_firmware.bat instead.                      ##
##                                                                                             ##
## Execute ./Load_firmware.sh to run this script from your terminal                            ##
## Run $ chmod +x Load_firmware.sh if this script isn't executable.                            ##
##                                                                                             ##
## All you need to do is modify AVRDUDE_PATH and PROGRAMMER + EXTRA_FLAGS fields to match your ##
## programming hardware.                                                                       ##
##                                                                                             ##
#################################################################################################

# Modify these to set correct Avrdude path, programmer type and flags
AVRDUDE_PATH="/usr/bin/avrdude"
PROGRAMMER="usbasp"
EXTRA_FLAGS="-Pusb"

# Target spesific
TARGET="atmega32u4"
HFUSE="0x99"
LFUSE="0x1E"
EFUSE="0xC6"

# File spesific
FLASH_FILE="mEDBG_firmware/mEDBG_UPDI_1.13.hex"
EEPROM_FILE="mEDBG_firmware/mEDBG_UPDI_1.13.eep"

# Avrdude command
$AVRDUDE_PATH -Cavrdude.conf -p$TARGET -c$PROGRAMMER $EXTRA_FLAGS -e -Uhfuse:w:$HFUSE:m -Ulfuse:w:$LFUSE:m -Uefuse:w:$EFUSE:m -Ueeprom:w:$EEPROM_FILE -Uflash:w:$FLASH_FILE 

