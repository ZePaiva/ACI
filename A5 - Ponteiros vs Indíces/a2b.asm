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
	.eqv arrLast, $t1
	.eqv arrCont, $t3
	.text 
	.globl main
main:
	la arr, array
	li arrLast, SIZE
	sll arrLast, arrLast, 2
	addu arrLast, arrLast, arr
	
while:	# arr < arrLast
	bge arr, arrLast, endCycle
	lw arg0, (arr)
	li func, print_string
	syscall
	li arg0, '\n'
	li func, print_char
	syscall
	addu arr, arr, 4
	j while

endCycle:
	la arg0, str4
	li func, print_string
	syscall
	jr $ra