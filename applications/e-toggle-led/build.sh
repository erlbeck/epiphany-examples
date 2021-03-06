#!/bin/bash

set -e

ESDK=${EPIPHANY_HOME}
ELIBS=${ESDK}/tools/host/lib
EINCS=${ESDK}/tools/host/include
ELDF=${ESDK}/bsps/current/fast.ldf

# Create the binaries directory
mkdir -p bin/

# Build HOST side application
gcc src/e-toggle-led.c -o bin/e-toggle-led.elf -I ${EINCS} -L ${ELIBS} -le-hal

# Build DEVICE side program
e-gcc -T ${ELDF} src/device-e-toggle-led.c -o bin/device-e-toggle-led.elf -le-lib

# Convert ebinary to SREC file
e-objcopy --srec-forceS3 --output-target srec bin/device-e-toggle-led.elf bin/device-e-toggle-led.srec


