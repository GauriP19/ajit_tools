	.file	"serial_io.c"
	.section	".text"
.LLtext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/sparcv8/ajit-toolchain/tests/C_example" "serial_io.c"
	.align 4
	.global halt
	.type	halt, #function
	.proc	020
halt:
.LLFB0:
	.file 1 "serial_io.c"
	.loc 1 8 1
	.cfi_startproc
	save	%sp, -96, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	.loc 1 9 2
! 9 "serial_io.c" 1
	ta 0; nop; nop;
! 0 "" 2
	.loc 1 10 1
	nop
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE0:
	.size	halt, .-halt
	.align 4
	.global __enable_serial
	.type	__enable_serial, #function
	.proc	04
__enable_serial:
.LLFB1:
	.loc 1 13 1
	.cfi_startproc
	save	%sp, -96, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	.loc 1 14 2
	mov	3, %o0
	call	__ajit_write_serial_control_register_via_bypass__, 0
	 nop
	.loc 1 15 8
	mov	0, %g1
	.loc 1 16 1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE1:
	.size	__enable_serial, .-__enable_serial
	.align 4
	.global __disable_serial
	.type	__disable_serial, #function
	.proc	04
__disable_serial:
.LLFB2:
	.loc 1 19 1
	.cfi_startproc
	save	%sp, -96, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	.loc 1 20 2
	mov	0, %o0
	call	__ajit_write_serial_control_register_via_bypass__, 0
	 nop
	.loc 1 21 8
	mov	0, %g1
	.loc 1 22 1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE2:
	.size	__disable_serial, .-__disable_serial
	.align 4
	.global __putchar
	.type	__putchar, #function
	.proc	04
__putchar:
.LLFB3:
	.loc 1 25 1
	.cfi_startproc
	save	%sp, -104, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	mov	%i0, %g1
	stb	%g1, [%fp+68]
	.loc 1 26 6
	st	%g0, [%fp-4]
	.loc 1 27 7
	b	.LL7
	 nop
.LL8:
	.loc 1 29 10
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g1, %o0
	call	__ajit_serial_putchar_via_bypass__, 0
	 nop
	st	%o0, [%fp-4]
.LL7:
	.loc 1 27 13
	ld	[%fp-4], %g1
	cmp	%g1, 0
	be	.LL8
	 nop
	.loc 1 31 9
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	.loc 1 32 1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE3:
	.size	__putchar, .-__putchar
	.align 4
	.global __getchar
	.type	__getchar, #function
	.proc	04
__getchar:
.LLFB4:
	.loc 1 36 1
	.cfi_startproc
	save	%sp, -104, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	.loc 1 37 6
	st	%g0, [%fp-4]
	.loc 1 38 7
	b	.LL11
	 nop
.LL12:
	.loc 1 40 10
	call	__ajit_serial_getchar_via_bypass__, 0
	 nop
	st	%o0, [%fp-4]
.LL11:
	.loc 1 38 13
	ld	[%fp-4], %g1
	cmp	%g1, 0
	be	.LL12
	 nop
	.loc 1 42 8
	ld	[%fp-4], %g1
	.loc 1 43 1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE4:
	.size	__getchar, .-__getchar
	.align 4
	.global __putstring
	.type	__putstring, #function
	.proc	020
__putstring:
.LLFB5:
	.loc 1 52 1
	.cfi_startproc
	save	%sp, -96, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	st	%i0, [%fp+68]
	.loc 1 53 8
	b	.LL15
	 nop
.LL16:
	.loc 1 55 3
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g1, %o0
	call	__putchar, 0
	 nop
	.loc 1 56 4
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.LL15:
	.loc 1 53 10
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	.loc 1 53 14
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.LL16
	 nop
	.loc 1 58 1
	nop
	nop
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE5:
	.size	__putstring, .-__putstring
	.align 4
	.global store_word_mmureg
	.type	store_word_mmureg, #function
	.proc	020
store_word_mmureg:
.LLFB6:
	.loc 1 64 1
	.cfi_startproc
	save	%sp, -96, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	.loc 1 65 9
	ld	[%fp+68], %g1
	ld	[%fp+72], %g2
! 65 "serial_io.c" 1
	sta %g1, [%g2] 4
	
! 0 "" 2
	.loc 1 67 1
	nop
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE6:
	.size	store_word_mmureg, .-store_word_mmureg
	.section	".rodata"
	.align 8
.LLC0:
	.asciz	"Hello World!\n"
	.align 8
.LLC1:
	.asciz	"\nGoodbye!\n"
	.section	".text"
	.align 4
	.global ajit_main
	.type	ajit_main, #function
	.proc	04
ajit_main:
.LLFB7:
	.loc 1 71 1
	.cfi_startproc
	save	%sp, -96, %sp
	.cfi_window_save
	.cfi_register 15, 31
	.cfi_def_cfa_register 30
	.loc 1 72 2
	mov	0, %o1
	mov	256, %o0
	call	store_word_mmureg, 0
	 nop
	.loc 1 73 2
	call	__enable_serial, 0
	 nop
	.loc 1 74 2
	sethi	%hi(.LLC0), %g1
	or	%g1, %lo(.LLC0), %o0
	call	__putstring, 0
	 nop
	.loc 1 75 2
	sethi	%hi(.LLC1), %g1
	or	%g1, %lo(.LLC1), %o0
	call	__putstring, 0
	 nop
	.loc 1 76 2
	call	halt, 0
	 nop
	.loc 1 77 9
	mov	0, %g1
	.loc 1 78 1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.cfi_endproc
.LLFE7:
	.size	ajit_main, .-ajit_main
.LLetext0:
	.file 2 "/home/sparcv8/ajit-toolchain/AjitPublicResources/tools/ajit_access_routines/include/ajit_access_routines.h"
	.file 3 "/home/sparcv8/x-tools/sparc-ajit32-elf/lib/gcc/sparc-ajit32-elf/15.2.0/include/stdint-gcc.h"
	.section	.debug_info,"",@progbits
.LLdebug_info0:
	.uaword	0x1c7
	.uahalf	0x5
	.byte	0x1
	.byte	0x4
	.uaword	.LLdebug_abbrev0
	.uleb128 0x8
	.uaword	.LLASF22
	.byte	0x1
	.uaword	.LLASF0
	.uaword	.LLASF1
	.uaword	.LLtext0
	.uaword	.LLetext0-.LLtext0
	.uaword	.LLdebug_line0
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.uaword	.LLASF2
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.uaword	.LLASF3
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.uaword	.LLASF4
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.uaword	.LLASF5
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.uaword	.LLASF6
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.uaword	.LLASF7
	.uleb128 0x9
	.uaword	.LLASF23
	.byte	0x3
	.byte	0x34
	.byte	0x19
	.uaword	0x5c
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.uaword	.LLASF8
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.uaword	.LLASF9
	.uleb128 0xa
	.byte	0x4
	.byte	0x5
	.asciz	"int"
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.uaword	.LLASF10
	.uleb128 0xb
	.uaword	.LLASF12
	.byte	0x2
	.uahalf	0x177
	.byte	0x9
	.uaword	0x6a
	.uaword	0x8b
	.uleb128 0xc
	.byte	0
	.uleb128 0xd
	.uaword	.LLASF24
	.byte	0x2
	.uahalf	0x176
	.byte	0x9
	.uaword	0x6a
	.uaword	0xa2
	.uleb128 0x2
	.uaword	0xa2
	.byte	0
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.uaword	.LLASF11
	.uleb128 0xe
	.uaword	.LLASF13
	.byte	0x2
	.uahalf	0x16a
	.byte	0x8
	.uaword	0xbc
	.uleb128 0x2
	.uaword	0x50
	.byte	0
	.uleb128 0xf
	.uaword	.LLASF25
	.byte	0x1
	.byte	0x46
	.byte	0x5
	.uaword	0x6a
	.uaword	.LLFB7
	.uaword	.LLFE7-.LLFB7
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x10
	.uaword	.LLASF16
	.byte	0x1
	.byte	0x3f
	.byte	0xd
	.uaword	.LLFB6
	.uaword	.LLFE6-.LLFB6
	.uleb128 0x1
	.byte	0x9c
	.uaword	0x105
	.uleb128 0x3
	.uaword	.LLASF14
	.byte	0x28
	.uaword	0x50
	.uleb128 0x3
	.byte	0x91
	.sleb128 68
	.uleb128 0x3
	.uaword	.LLASF15
	.byte	0x39
	.uaword	0x105
	.uleb128 0x3
	.byte	0x91
	.sleb128 72
	.byte	0
	.uleb128 0x4
	.uaword	0x50
	.uleb128 0x11
	.uaword	.LLASF17
	.byte	0x1
	.byte	0x33
	.byte	0x6
	.uaword	.LLFB5
	.uaword	.LLFE5-.LLFB5
	.uleb128 0x1
	.byte	0x9c
	.uaword	0x12e
	.uleb128 0x5
	.asciz	"s"
	.byte	0x33
	.byte	0x19
	.uaword	0x12e
	.uleb128 0x3
	.byte	0x91
	.sleb128 68
	.byte	0
	.uleb128 0x4
	.uaword	0xa2
	.uleb128 0x12
	.uaword	.LLASF18
	.byte	0x1
	.byte	0x23
	.byte	0x5
	.uaword	0x6a
	.uaword	.LLFB4
	.uaword	.LLFE4-.LLFB4
	.uleb128 0x1
	.byte	0x9c
	.uaword	0x15b
	.uleb128 0x6
	.uaword	.LLASF19
	.byte	0x25
	.uaword	0x6a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x13
	.uaword	.LLASF26
	.byte	0x1
	.byte	0x18
	.byte	0x5
	.uaword	0x6a
	.uaword	.LLFB3
	.uaword	.LLFE3-.LLFB3
	.uleb128 0x1
	.byte	0x9c
	.uaword	0x190
	.uleb128 0x5
	.asciz	"c"
	.byte	0x18
	.byte	0x14
	.uaword	0xa2
	.uleb128 0x3
	.byte	0x91
	.sleb128 68
	.uleb128 0x6
	.uaword	.LLASF19
	.byte	0x1a
	.uaword	0x6a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x7
	.uaword	.LLASF20
	.byte	0x12
	.uaword	0x6a
	.uaword	.LLFB2
	.uaword	.LLFE2-.LLFB2
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x7
	.uaword	.LLASF21
	.byte	0xc
	.uaword	0x6a
	.uaword	.LLFB1
	.uaword	.LLFE1-.LLFB1
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x14
	.uaword	.LLASF27
	.byte	0x1
	.byte	0x7
	.byte	0xd
	.uaword	.LLFB0
	.uaword	.LLFE0-.LLFB0
	.uleb128 0x1
	.byte	0x9c
	.byte	0
	.section	.debug_abbrev,"",@progbits
.LLdebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 63
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.uaword	0x1c
	.uahalf	0x2
	.uaword	.LLdebug_info0
	.byte	0x4
	.byte	0
	.uahalf	0
	.uahalf	0
	.uaword	.LLtext0
	.uaword	.LLetext0-.LLtext0
	.uaword	0
	.uaword	0
	.section	.debug_line,"",@progbits
.LLdebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LLASF22:
	.asciz	"GNU C89 15.2.0 -m32 -mcpu=v8 -g -std=gnu90 -ffreestanding"
.LLASF18:
	.asciz	"__getchar"
.LLASF14:
	.asciz	"value"
.LLASF13:
	.asciz	"__ajit_write_serial_control_register_via_bypass__"
.LLASF24:
	.asciz	"__ajit_serial_putchar_via_bypass__"
.LLASF27:
	.asciz	"halt"
.LLASF15:
	.asciz	"addr"
.LLASF6:
	.asciz	"unsigned char"
.LLASF17:
	.asciz	"__putstring"
.LLASF21:
	.asciz	"__enable_serial"
.LLASF8:
	.asciz	"long unsigned int"
.LLASF7:
	.asciz	"short unsigned int"
.LLASF25:
	.asciz	"ajit_main"
.LLASF19:
	.asciz	"rval"
.LLASF10:
	.asciz	"unsigned int"
.LLASF9:
	.asciz	"long long unsigned int"
.LLASF20:
	.asciz	"__disable_serial"
.LLASF12:
	.asciz	"__ajit_serial_getchar_via_bypass__"
.LLASF5:
	.asciz	"long long int"
.LLASF11:
	.asciz	"char"
.LLASF16:
	.asciz	"store_word_mmureg"
.LLASF3:
	.asciz	"short int"
.LLASF26:
	.asciz	"__putchar"
.LLASF23:
	.asciz	"uint32_t"
.LLASF4:
	.asciz	"long int"
.LLASF2:
	.asciz	"signed char"
	.section	.debug_line_str,"MS",@progbits,1
.LLASF0:
	.asciz	"serial_io.c"
.LLASF1:
	.asciz	"/home/sparcv8/ajit-toolchain/tests/C_example"
	.ident	"GCC: (crosstool-NG 1.28.0.21_3c5cc17) 15.2.0"
