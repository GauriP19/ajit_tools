	.file	"ajit_mmap.c"
	.section	".text"
	.align 4
	.global initPageTableAllocator
	.type	initPageTableAllocator, #function
	.proc	020
initPageTableAllocator:
	save	%sp, -96, %sp
	mov	0, %i4
	mov	%i3, %l0
	mov	0, %i5
	mov	%i2, %i3
	cmp	%l0, 0
	mov	%i1, %i2
	be	.L4
	 mov	0, %i1
	addcc	%i3, %i5, %o2
.L10:
	mov	0, %o0
	call	__ajit_store_word_to_physical_address__, 0
	 addx	%i2, %i4, %o1
	addcc	%i5, 4, %i5
	addx	%i4, 0, %i4
	cmp	%i1, %i4
	bne	.L4
	 cmp	%l0, %i5
	bgu	.L10
	 addcc	%i3, %i5, %o2
.L4:
	std	%i2, [%i0]
	st	%g0, [%i0+8]
	st	%l0, [%i0+12]
	st	%g0, [%i0+16]
	st	%g0, [%i0+20]
	jmp	%i7+8
	 restore
	.size	initPageTableAllocator, .-initPageTableAllocator
	.align 4
	.global allocatePageTableBlock
	.type	allocatePageTableBlock, #function
	.proc	016
allocatePageTableBlock:
	save	%sp, -96, %sp
	mov	0, %g2
	cmp	%i1, 1
	bgu	.L12
	 mov	256, %g3
	mov	0, %g2
	mov	1024, %g3
.L12:
	ldd	[%i0+16], %o4
	addcc	%o5, %g3, %i5
	ldd	[%i0], %o2
	addx	%o4, %g2, %i4
	addcc	%g3, %o3, %o1
	addx	%g2, %o2, %o0
	cmp	%i4, %o0
	bgu	.L16
	 nop
	be	.L18
	 cmp	%i5, %o1
	std	%o4, [%i2]
.L19:
	std	%i4, [%i0+16]
	jmp	%i7+8
	 restore %g0, 0, %o0
.L18:
	bleu,a	.L19
	 std	%o4, [%i2]
.L16:
	jmp	%i7+8
	 restore %g0, 1, %o0
	.size	allocatePageTableBlock, .-allocatePageTableBlock
	.align 4
	.global ajit_mmap_index_into_table
	.type	ajit_mmap_index_into_table, #function
	.proc	016
ajit_mmap_index_into_table:
	cmp	%o0, 2
	be	.L21
	 cmp	%o0, 3
	be	.L22
	 cmp	%o0, 1
	bne	.L25
	 mov	0, %o0
	jmp	%o7+8
	 srl	%o1, 24, %o0
.L22:
	srl	%o1, 12, %o1
	and	%o1, 63, %o0
.L25:
	jmp	%o7+8
	 nop
.L21:
	srl	%o1, 18, %o1
	jmp	%o7+8
	 and	%o1, 63, %o0
	.size	ajit_mmap_index_into_table, .-ajit_mmap_index_into_table
	.align 4
	.global ajit_mmap_is_pte
	.type	ajit_mmap_is_pte, #function
	.proc	014
ajit_mmap_is_pte:
	and	%o0, 3, %o0
	xor	%o0, 2, %o0
	cmp	%g0, %o0
	jmp	%o7+8
	 subx	%g0, -1, %o0
	.size	ajit_mmap_is_pte, .-ajit_mmap_is_pte
	.align 4
	.global ajit_mmap_is_ptd
	.type	ajit_mmap_is_ptd, #function
	.proc	014
ajit_mmap_is_ptd:
	and	%o0, 3, %o0
	xor	%o0, 1, %o0
	cmp	%g0, %o0
	jmp	%o7+8
	 subx	%g0, -1, %o0
	.size	ajit_mmap_is_ptd, .-ajit_mmap_is_ptd
	.align 4
	.global ajit_mmap_get_phy_addr_from_ptd
	.type	ajit_mmap_get_phy_addr_from_ptd, #function
	.proc	017
ajit_mmap_get_phy_addr_from_ptd:
	and	%o0, -4, %g1
	sll	%o2, 2, %o2
	sll	%g1, 4, %g1
	srl	%o0, 28, %o0
	jmp	%o7+8
	 or	%o2, %g1, %o1
	.size	ajit_mmap_get_phy_addr_from_ptd, .-ajit_mmap_get_phy_addr_from_ptd
	.align 4
	.global ajit_mmap_get_phy_addr_from_pte
	.type	ajit_mmap_get_phy_addr_from_pte, #function
	.proc	017
ajit_mmap_get_phy_addr_from_pte:
	cmp	%o1, 3
	be	.L34
	 cmp	%o1, 2
	be	.L35
	 cmp	%o1, 1
	bne	.L36
	 srl	%o0, 8, %o1
	sethi	%hi(-16777216), %g1
	andn	%o2, %g1, %o2
	srl	%o0, 28, %o0
	sll	%o1, 12, %o1
	jmp	%o7+8
	 or	%o2, %o1, %o1
.L35:
	sethi	%hi(-16384), %g1
	andn	%o2, %g1, %o2
	srl	%o0, 8, %o1
.L36:
	srl	%o0, 28, %o0
	sll	%o1, 12, %o1
	jmp	%o7+8
	 or	%o2, %o1, %o1
.L34:
	and	%o2, 4095, %o2
	srl	%o0, 8, %o1
	srl	%o0, 28, %o0
	sll	%o1, 12, %o1
	jmp	%o7+8
	 or	%o2, %o1, %o1
	.size	ajit_mmap_get_phy_addr_from_pte, .-ajit_mmap_get_phy_addr_from_pte
	.align 4
	.global ajit_mmap_make_ptd
	.type	ajit_mmap_make_ptd, #function
	.proc	016
ajit_mmap_make_ptd:
	sll	%o1, 26, %o1
	srl	%o2, 6, %o2
	add	%o1, %o2, %o2
	sll	%o2, 2, %o2
	jmp	%o7+8
	 or	%o2, 1, %o0
	.size	ajit_mmap_make_ptd, .-ajit_mmap_make_ptd
	.align 4
	.global ajit_mmap_make_pte
	.type	ajit_mmap_make_pte, #function
	.proc	016
ajit_mmap_make_pte:
	sll	%o3, 20, %o3
	sll	%o1, 2, %o1
	srl	%o4, 12, %o4
	add	%o3, %o4, %o4
	sll	%o4, 8, %o4
	or	%o4, %o1, %o4
	jmp	%o7+8
	 or	%o4, 2, %o0
	.size	ajit_mmap_make_pte, .-ajit_mmap_make_pte
	.align 4
	.global ajit_lookup_mmap
	.type	ajit_lookup_mmap, #function
	.proc	04
ajit_lookup_mmap:
	save	%sp, -96, %sp
	stb	%g0, [%i4]
	st	%g0, [%i5]
	st	%g0, [%i5+4]
	ld	[%fp+92], %l1
	sll	%i2, 2, %i2
	st	%g0, [%l1]
	addcc	%i1, %i2, %g3
	st	%g0, [%l1+4]
	addx	%i0, 0, %g2
	ld	[%fp+96], %l0
	mov	%g2, %i0
	mov	%g3, %i1
	st	%g0, [%l0]
	mov	0, %i2
	mov	%i0, %o0
	call	__ajit_load_word_from_physical_address__, 0
	 mov	%i1, %o1
	stb	%i2, [%i4]
	std	%i0, [%l1]
	and	%o0, 3, %g1
	cmp	%g1, 1
	bne	.L40
	 st	%o0, [%l0]
.L52:
	add	%i2, 1, %i2
	and	%i2, 0xff, %g1
	cmp	%g1, 2
	be	.L41
	 cmp	%g1, 3
	be	.L42
	 cmp	%g1, 1
	bne	.L56
	 mov	1, %i0
	srl	%i3, 24, %g1
.L44:
	sll	%g1, 2, %g1
	and	%o0, -4, %g2
	sll	%g2, 4, %g2
	srl	%o0, 28, %i0
	or	%g1, %g2, %i1
	mov	%i0, %o0
	call	__ajit_load_word_from_physical_address__, 0
	 mov	%i1, %o1
	stb	%i2, [%i4]
	std	%i0, [%l1]
	and	%o0, 3, %g1
	cmp	%g1, 1
	be	.L52
	 st	%o0, [%l0]
.L40:
	cmp	%g1, 2
	bne	.L56
	 mov	1, %i0
	and	%i2, 0xff, %i2
	cmp	%i2, 3
	be	.L53
	 cmp	%i2, 2
	be	.L54
	 cmp	%i2, 1
	bne,a	.L55
	 srl	%o0, 8, %g1
	sethi	%hi(-16777216), %g1
	andn	%i3, %g1, %i3
.L47:
	srl	%o0, 8, %g1
.L55:
	srl	%o0, 28, %o0
	sll	%g1, 12, %g1
	st	%o0, [%i5]
	or	%g1, %i3, %g1
	st	%g1, [%i5+4]
	jmp	%i7+8
	 restore %g0, 0, %o0
.L41:
	srl	%i3, 18, %g1
	b	.L44
	 and	%g1, 63, %g1
.L56:
	jmp	%i7+8
	 restore
.L42:
	srl	%i3, 12, %g1
	b	.L44
	 and	%g1, 63, %g1
.L53:
	b	.L47
	 and	%i3, 4095, %i3
.L54:
	sethi	%hi(-16384), %g1
	b	.L47
	 andn	%i3, %g1, %i3
	.size	ajit_lookup_mmap, .-ajit_lookup_mmap
	.align 4
	.global ajit_mmap_operation
	.type	ajit_mmap_operation, #function
	.proc	04
ajit_mmap_operation:
	save	%sp, -128, %sp
	add	%fp, -20, %g1
	st	%g1, [%sp+96]
	add	%fp, -16, %g1
	mov	%i2, %o1
	mov	%i1, %o0
	mov	%i0, %l0
	ld	[%fp+104], %i2
	ld	[%fp+100], %l2
	ldub	[%fp+95], %l1
	st	%g1, [%sp+92]
	add	%fp, -8, %o5
	add	%fp, -21, %o4
	ld	[%fp+96], %o3
	call	ajit_lookup_mmap, 0
	 mov	%i4, %o2
	orcc	%o0, 0, %i0
	bne	.L58
	 cmp	%i3, 1
	be	.L79
	 cmp	%i3, 2
	be	.L60
	 mov	0, %o0
	ld	[%fp-20], %o0
.L60:
	ld	[%fp-16], %o1
	call	__ajit_store_word_to_physical_address__, 0
	 ld	[%fp-12], %o2
.L61:
	mov	0, %i0
.L82:
	jmp	%i7+8
	 restore
.L58:
	bne,a	.L82
	 mov	0, %i0
	ldub	[%fp-21], %i4
	and	%i4, 0xff, %g1
	cmp	%g1, %i5
	bgu	.L61
	 ldd	[%fp-16], %o0
	add	%i4, 1, %i4
.L84:
	mov	0, %g2
	and	%i4, 0xff, %i3
	cmp	%i3, 1
	bgu	.L64
	 mov	256, %g3
	mov	0, %g2
	mov	1024, %g3
.L64:
	ldd	[%l0+16], %l4
	addcc	%l5, %g3, %l7
	ldd	[%l0], %o4
	addx	%l4, %g2, %l6
	addcc	%g3, %o5, %o3
	addx	%g2, %o4, %o2
	cmp	%l6, %o2
	bgu	.L82
	 nop
	bne	.L83
	 add	%i5, 1, %g1
	cmp	%l7, %o3
	bgu	.L82
	 nop
.L83:
	and	%g1, 0xff, %g1
	cmp	%i3, %g1
	be	.L80
	 std	%l6, [%l0+16]
	sll	%l4, 26, %g2
	srl	%l5, 6, %g1
	add	%g2, %g1, %g1
	sll	%g1, 2, %g1
	or	%g1, 1, %g1
.L68:
	mov	%o1, %o2
	mov	%o0, %o1
	call	__ajit_store_word_to_physical_address__, 0
	 mov	%g1, %o0
	cmp	%i3, 2
	be	.L69
	 cmp	%i3, 3
	be	.L70
	 mov	%l4, %o0
	cmp	%i3, 1
	be	.L81
	 mov	%l5, %o1
.L71:
	cmp	%i3, %i5
	bleu	.L84
	 add	%i4, 1, %i4
	jmp	%i7+8
	 restore %g0, 0, %o0
.L79:
	sll	%l2, 20, %l2
	srl	%i2, 12, %i2
	sll	%l1, 2, %l1
	add	%l2, %i2, %i2
	sll	%i2, 8, %o0
	or	%o0, %l1, %o0
	b	.L60
	 or	%o0, 2, %o0
.L81:
	ld	[%fp+96], %g1
	srl	%g1, 24, %g1
	sll	%g1, 2, %g1
	addcc	%l5, %g1, %o1
	b	.L71
	 addx	%l4, 0, %o0
.L70:
	ld	[%fp+96], %g1
	srl	%g1, 10, %g1
	and	%g1, 252, %g1
	addcc	%l5, %g1, %o1
	b	.L71
	 addx	%l4, 0, %o0
.L69:
	ld	[%fp+96], %g1
	srl	%g1, 16, %g1
	and	%g1, 252, %g1
	addcc	%l5, %g1, %o1
	b	.L71
	 addx	%l4, 0, %o0
.L80:
	sll	%l2, 20, %g3
	srl	%i2, 12, %g1
	sll	%l1, 2, %g2
	add	%g3, %g1, %g1
	sll	%g1, 8, %g1
	or	%g1, %g2, %g1
	b	.L68
	 or	%g1, 2, %g1
	.size	ajit_mmap_operation, .-ajit_mmap_operation
	.ident	"GCC: (crosstool-NG 1.28.0.35_14025c5) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
