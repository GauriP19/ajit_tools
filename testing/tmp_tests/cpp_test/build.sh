#!/usr/bin/env bash

MAIN=basic

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AJIT_TOOLS_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
TOOLCHAIN_ROOT="${TOOLCHAIN_ROOT:-$AJIT_TOOLS_ROOT/sparc_ctng/x-tools/sparc-ajit-linux-uclibc}"
TARGET=sparc-linux
BIN="$TOOLCHAIN_ROOT/bin"
SYSROOT="$TOOLCHAIN_ROOT/sparc-ajit-linux-uclibc/sysroot"
AAR="$AJIT_TOOLS_ROOT/ajit-processor/AjitPublicResources/tools/ajit_access_routines"
PT="$AJIT_TOOLS_ROOT/ajit-processor/AjitPublicResources/tools/minimal_printf_timer"

export PATH="$BIN:$AJIT_TOOLS_ROOT/ajit-processor/AjitPublicResources/tools/scripts:$AJIT_TOOLS_ROOT/ajit-processor/AjitPublicResources/tools/genVmapAsm/bin:$AJIT_TOOLS_ROOT/ajit-processor/AjitPublicResources/tools/misc/bin:$PATH"
export AJIT_UCLIBC_INSTALL_DIR="${AJIT_UCLIBC_INSTALL_DIR:-$SYSROOT/usr}"
export AJIT_UCLIBC_HEADERS_DIR="${AJIT_UCLIBC_HEADERS_DIR:-$SYSROOT/usr/include}"
export AJIT_LIBGCC_INSTALL_DIR="${AJIT_LIBGCC_INSTALL_DIR:-$TOOLCHAIN_ROOT/lib/gcc/sparc-ajit-linux-uclibc/15.2.0}"

CXX="${CXX:-$BIN/$TARGET-g++}"

cd "$SCRIPT_DIR"

# The AJIT bare-metal compiler wrapper handles C and assembly. Compile the
# C++ test to assembly first, then feed that assembly into the normal flow.
"$CXX" -std=c++11 -O2 -Wall -Wextra -m32 -mcpu=v8 \
  -ffreestanding -fno-exceptions -fno-rtti -fno-threadsafe-statics \
  -fno-use-cxa-atexit -fno-asynchronous-unwind-tables \
  -D USE_VMAP \
  -S src/basic.cpp -o basic_cpp.s

compileToSparcUclibc.py \
  -I "$AJIT_UCLIBC_HEADERS_DIR" \
  -I ./ \
  -I "$AAR/include" \
  -I "$PT/include" \
  -V vmap.txt \
  -s init.s \
  -s trap_handlers.s \
  -s "$AAR/asm/mutexes.s" \
  -s basic_cpp.s \
  -C "$AAR/src" \
  -C "$PT/src" \
  -N "$MAIN" \
  -L LinkerScript.lnk \
  -D AJIT \
  -D USE_VMAP \
  -U

echo "built $MAIN.elf"
echo "wrote $MAIN.mmap"
echo "wrote $MAIN.mmap.remapped"
