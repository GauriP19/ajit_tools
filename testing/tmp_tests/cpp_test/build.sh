#!/usr/bin/env bash

MAIN=basic

AAR="$AJIT_HOME/ajit-processor/AjitPublicResources/tools/ajit_access_routines_mt"
PT="$AJIT_HOME/ajit-processor/AjitPublicResources/tools/minimal_printf_timer"

CXX="${CXX:-$AJIT_BUILDROOT_BIN_DIR/$AJIT_TOOLCHAIN_TARGET-g++}"
if [[ ! -x "$CXX" ]]; then
  echo "error: C++ compiler not found or not executable: $CXX" >&2
  exit 1
fi

# C++ test to assembly first, then feed that assembly into the normal flow.
echo "compiling src/basic.cpp with $CXX"
"$CXX" -std=c++11 -O2 -Wall -Wextra -m32 -mcpu=v8 \
  -I "$AAR/include" \
  -I "$PT/include" \
  -ffreestanding -fno-exceptions -fno-rtti -fno-threadsafe-statics \
  -fno-use-cxa-atexit -fno-asynchronous-unwind-tables \
  -S src/basic.cpp -o basic_cpp.s

compileToSparcUclibc.py \
  -I "$AJIT_UCLIBC_HEADERS_DIR" \
  -I ./ \
  -I "$AAR/include" \
  -I "$PT/include" \
  -V vmap.txt \
  -s init.s \
  -s trap_handlers.s \
  -s basic_cpp.s \
  -c "$AAR/src/ajit_access_routines.c" \
  -C "$PT/src" \
  -N "$MAIN" \
  -L LinkerScript.lnk \
  -D AJIT \
  -U
