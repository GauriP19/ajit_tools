#!/bin/sh
# run AJIT C Model on the generated mmap file
_MAIN="basic";
ajit_C_system_model \
  -R 123456 \
  -n 1 \
  -t 1 \
  -p 8888 \
  -i 0x0 \
  -m ${_MAIN}.mmap.remapped \
