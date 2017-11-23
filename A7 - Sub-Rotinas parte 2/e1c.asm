	.data
string:	.asciiz "100"
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
	subiu $sp, $sp, 4	
	sw $ra, ($sp)
	la $a0, string
	jal atoi
	move $a0, $v0
	li $v0, print_int10
	syscall
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	
###################################################################################################
# modified ascii to integer
# unsigned int atoi(char *s)
# $so -> pointer
# $s1 -> digit
# $s2 -> res
# $t0 -> char
atoi:
	subiu $sp, $sp, 16
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	move $s0, $a0			# pointer = *s
	li   $s2, 0			# res = 0
while:
	lb $t0, ($s0)
	blt $t0, '0', endatoi
	bgt $t0, '1', endatoi
	sub $s1, $t0, '0'
	sll $s2, $s2, 1
	addu $s2, $s2, $s1
	addiu $s0, $s0, 1
	j while
	
endatoi:
	move $v0, $s2
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp, $sp, 16	
	jr $ra