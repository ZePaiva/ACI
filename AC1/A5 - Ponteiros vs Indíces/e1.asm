	.data
	.eqv size, 5
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv i, $t0
	.eqv list, $t1
	.eqv incList, $t2
str:	.asciiz "\nIntroduza um numero: "
	.align 2
lista:	.space 20
	.text
	.globl main
main:
	li i, 0
	
while:	bge i, size, endw
	
	# imprime a string
	la arg0, str
	li func, print_string
	syscall
	
	#le a int
	li func, read_int
	syscall
	
	# stores int 
	la list, lista
	sll incList, list, 2
	addu incList, list, $t3
	sw func, 0(incList)
	addi i, i, 1
	sll $t3, i, 2
	j while

endw:
	jr $ra
