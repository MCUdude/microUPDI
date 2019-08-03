@ECHO off

::#################################################################################################::
::## Created by MCUdude for flashing mEDBG UPDI firmware onto Arduino Pro Micro boards           ##::
::## https://github.com/MCUdude/microUPDI                                                        ##::
::##                                                                                             ##::
::## If you're a *NIX user it's easier to run Load_firmware.sh instead.                          ##::
::##                                                                                             ##::
::## All you need to do is modify AVRDUDE_PATH and PROGRAMMER + EXTRA_FLAGS fields to match your ##::
::## programming hardware.                                                                       ##::
::##                                                                                             ##::
::#################################################################################################::

:: Modify these fields to set correct Avrdude path, programmer type and flags
SET AVRDUDE_PATH=mEDBG_firmware\avrdude.exe
SET PROGRAMMER=usbasp
SET EXTRA_FLAGS=-Pusb

:: Target spesific
SET TARGET=atmega32u4
SET HFUSE=0x99
SET LFUSE=0x1E
SET EFUSE=0xC6

:: File spesific
SET FLASH_FILE=mEDBG_firmware/mEDBG_UPDI_1.13.hex
SET EEPROM_FILE=mEDBG_firmware/mEDBG_UPDI_1.13.eep

@ECHO on


.\%AVRDUDE_PATH% -Cavrdude.conf -c%PROGRAMMER% %EXTRA_FLAGS% -p%TARGET% -e -Uhfuse:w:%HFUSE%:m -Ulfuse:w:%LFUSE%:m -Uefuse:w:%EFUSE%:m -Ueeprom:w:%EEPROM_FILE% -Uflash:w:%FLASH_FILE%

PAUSE

:end