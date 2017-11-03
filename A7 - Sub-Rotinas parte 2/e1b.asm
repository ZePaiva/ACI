	.data
string:	.asciiz "2016 e 2020 sao anos bissextos"
	.eqv print_int10, 1
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv pointer, $t0
	.eqv digit, $t1
	.eqv char, $t2
	.text
	.globl main
main:
	sw $ra, ($sp)
	la arg0, string
	jal atoi
	move arg0, func
	li func print_int10
	syscall
	lw $ra, ($sp)
	jr $ra
	
atoi:
	la pointer, (arg0)
	li func, 0
while:
	lb char, (pointer)
	blt char, '0', endatoi
	bgt char, '9', endatoi
	sub digit, char, '0'
	mul func, func, 10
	addu func, func, digit
	addiu pointer, pointer, 1
	j while
	
endatoi:
	jr $ra