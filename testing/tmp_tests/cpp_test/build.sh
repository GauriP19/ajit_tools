#!/usr/bin/env bash

TOOLCHAIN_ROOT=/home/sparcv8/ajit_tools/sparc_ctng/x-tools
TARGET=sparc-linux
BIN=$TOOLCHAIN_ROOT/sparc-unknown-linux-uclibc/bin

CXX=$BIN/$TARGET-g++
AS=$BIN/$TARGET-as
AR=$BIN/$TARGET-ar
LD=$BIN/$TARGET-ld
NM=$BIN/$TARGET-nm
SIZE=$BIN/$TARGET-size
OBJDUMP=$BIN/$TARGET-objdump
OBJCOPY=$BIN/$TARGET-objcopy
READELF=$BIN/$TARGET-readelf

OUT=build

mkdir -p $OUT

$CXX -std=c++11 -O2 -Wall -Wextra -ffreestanding -fno-exceptions -fno-rtti -c src/basic.cpp -o $OUT/basic.o
$AS src/start.S -o $OUT/start.o
$AR rcs $OUT/libbasic.a $OUT/basic.o
$LD -T linker.ld $OUT/start.o $OUT/libbasic.a -o $OUT/basic.elf

$NM $OUT/basic.elf > $OUT/basic.nm
$SIZE $OUT/basic.elf > $OUT/basic.size
$OBJDUMP -d $OUT/basic.elf > $OUT/basic.dump
$READELF -h $OUT/basic.elf > $OUT/basic.readelf
$OBJCOPY -O binary $OUT/basic.elf $OUT/basic.bin

echo "built $OUT/basic.elf"
echo "wrote $OUT/basic.bin"
echo "wrote $OUT/basic.dump"
echo "wrote $OUT/basic.readelf"
