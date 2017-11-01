	.data
array:	.word str1, str2, str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:	.asciiz "terminou\n"
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv SIZE, 3
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arr, $t0
	.eqv i, $t1
	.eqv arrCont, $t2
	.text 
	.globl main
main:
	li i, 0
	la arr, array
	
while:	# i < SIZE
	bge i, SIZE, endCycle
	sll arrCont, i, 2
	addu arrCont, arr, arrCont
	lw arg0, (arrCont)
	li func, print_string
	syscall
	li arg0, '\n'
	li func, print_char
	syscall
	addi i, i, 1
	j while
	
endCycle:
	la arg0, str4
	li func, print_string
	syscall
	jr $ra