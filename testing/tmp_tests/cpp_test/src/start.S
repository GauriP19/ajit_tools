    .section .text.start
    .global _start

_start:
    call main
    nop

1:
    ba 1b
    nop
