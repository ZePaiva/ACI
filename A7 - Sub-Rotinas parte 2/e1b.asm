	.data
string:	.asciiz "2016 e 2020 sao anos bissextos"
	.eqv print_int10, 1
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
# ascii to integer
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
	lb $t0, ($s0)			# $t0 = *s
	blt $t0, '0', endatoi
	bgt $t0, '9', endatoi
	sub $s1, $t0, '0'		# $s1 = *s - '0'
	mul $s2, $s2, 10		# $s2 = $s2 * 10
	addu $s2, $s2, $s1		# $s2 = $s2 * 10 + $s1
	addiu $s0, $s0, 1		# *s++
	j while
	
endatoi:
	move $v0, $s2
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp, $sp, 16	
	jr $ra