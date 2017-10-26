	.data
string: .asciiz "Arquitetura de computadores I"
str0:	.asciiz "String: "
str1:	.asciiz "String length: "
str2:	.asciiz "\n"
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv len, $t0
	.eqv strp, $t1
	.eqv char, $t2
	.eqv 
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
	li func, print_string
	syscall 
	la arg0, string
	sw $ra, ($sp)		# guarda o endere?o de retorno da main
	jal strlen		# chama a funcao
	lw $ra, ($sp)		# repoe o ender?o de retorno da main
	move arg0, func
	li   func, print_int10
	syscall
	la   arg0, str2
	li   func, print_string
	syscall
	jr $ra
	
	
strlen:	# string length
	li len, 0
	move strp, arg0
while:	lb char, (strp)
	beq char, '\0', endWhile
	addi len, len, 1
	addi strp, strp, 1
	j while

endWhile:
	move func, len
	jr $ra