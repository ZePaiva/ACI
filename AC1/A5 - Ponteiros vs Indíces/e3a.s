	.file	"e3a.c"
	.section	.rodata
.LC0:
	.string	"N\303\272mero: "
.LC1:
	.string	"%i"
.LC2:
	.string	"Array ordenado: "
.LC3:
	.string	" %i, "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	leaq	lista.2250(%rip), %rax
	movq	%rax, -8(%rbp)
	jmp	.L2
.L3:
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	addq	$4, -8(%rbp)
.L2:
	leaq	40+lista.2250(%rip), %rax
	cmpq	%rax, -8(%rbp)
	jb	.L3
.L7:
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L4
.L6:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	-12(%rbp), %eax
	addl	$1, %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	lista.2250(%rip), %rax
	movl	(%rcx,%rax), %eax
	cmpl	%eax, %edx
	jle	.L5
	movl	$1, -16(%rbp)
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	-12(%rbp), %eax
	addl	$1, %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	lista.2250(%rip), %rax
	movl	(%rcx,%rax), %eax
	leal	(%rdx,%rax), %ecx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	-12(%rbp), %eax
	addl	$1, %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	lista.2250(%rip), %rax
	movl	(%rcx,%rax), %eax
	movl	-12(%rbp), %ecx
	leal	1(%rcx), %esi
	movl	%edx, %ecx
	subl	%eax, %ecx
	movslq	%esi, %rax
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	-12(%rbp), %eax
	addl	$1, %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	lista.2250(%rip), %rax
	movl	(%rcx,%rax), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	%ecx, (%rdx,%rax)
.L5:
	addl	$1, -12(%rbp)
.L4:
	cmpl	$8, -12(%rbp)
	jle	.L6
	cmpl	$0, -16(%rbp)
	jne	.L7
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -12(%rbp)
	jmp	.L8
.L9:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	lista.2250(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -12(%rbp)
.L8:
	cmpl	$9, -12(%rbp)
	jle	.L9
	movl	$10, %edi
	call	putchar@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.local	lista.2250
	.comm	lista.2250,40,32
	.ident	"GCC: (GNU) 7.2.0"
	.section	.note.GNU-stack,"",@progbits
