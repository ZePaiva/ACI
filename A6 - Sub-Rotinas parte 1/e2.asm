	.data
string: .asciiz "ITED - orievA ed edadisrevinU"
str0:	.asciiz "String: "
str1:	.asciiz "Reversed string: "
str2:	.asciiz "\n"
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv c1, $t0
	.eqv c2, $t2
	.eqv str, $s0
	.eqv p1, $s1
	.eqv p2, $s2 
	.eqv char, $s3
	.text
	.globl main
main:
	la arg0, str0
	li func, print_string
	syscall
	la arg0, string
	syscall
	la arg0, str2
	syscall
	la arg0, str1
	syscall
	la arg0, string
	sw $ra, ($sp)
	jal strrev
	lw $ra, ($sp)
	move arg0, func
	li func, print_string
	syscall
	la arg0, str2
	syscall
	jr $ra
	
strrev:
	subu $sp, $sp, 16
	sw   $ra, ($sp)
	sw   str, 4($sp)
	sw   p1, 8($sp)
	sw   p2, 12($sp)
	move str, arg0
	move p1, arg0
	move p2, arg0
	
while1:	# counts length
	lb char, (p2)
	beq char, '\0', endWhile1
	addi p2, p2, 1
	j while1
	
endWhile1:
	subi p2, p2, 1

while2:	# troca as letras
	bge p1, p2, endWhile2
	move arg0, p1
	move arg1, p2
	jal exchange
	addi p1, p1, 1
	subi p2, p2, 1
	j while2
	
endWhile2:
	move func, str
	lw   $ra, ($sp)
	lw   str, 4($sp)
	lw   p1, 8($sp)
	lw   p2, 12($sp)
	addu $sp, $sp, 16
	jr $ra
	
exchange:
	lb c1,0(arg0)
	lb c2,0(arg1)
	sb c1,0(arg1)
	sb c2,0(arg0)
	jr $ra