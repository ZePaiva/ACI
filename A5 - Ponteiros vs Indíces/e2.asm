	.data
	.eqv size, 10
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv p, $t0
	.eqv listSize, $t1
str:	.asciiz "; "
str1:	.asciiz "\nArray: "
str2:	.asciiz "\nFim.\n"
array:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27
	.text
	.globl main
main:
	# print string
	la arg0, str1
	li func, print_string
	syscall
	
	# faz os loads
	li listSize, size
	la p, array
	
	# multplica por 4 pois cada int ocupar 4 e nao 1
	sll listSize, listSize, 2
	
	# coloca listSize como ponteiro para o ultimo int do array
	addu listSize, listSize, p
	
	# print array cycle
while:
	bge p, listSize, endw
	
	# get value in array[i] and print it
	li func, print_int10
	lw arg0, (p)
	syscall
	
	# print string to separate
	la arg0, str
	li func, print_string
	syscall
	
	#increase pointer and jump
	addu p, p, 4
	j while
	
endw:
	li func, print_string
	la arg0, str2
	syscall
	jr $ra