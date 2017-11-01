	.data
str1:	.asciiz "\nIntroduza uma string: "
str2:	.asciiz "\nString alterada: "
str:	.space 20
	.eqv size, 20
	.eqv print_str, 4
	.eqv read_str, 8
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv func, $v0
	.eqv pointer, $t0
	.eqv char, $t1
	.text
	.globl main
main:
	# ask for string
	la arg0, str1
	li func, print_str
	syscall	
	
	# read the string
	la arg0, str
	li arg1, size
	li func, read_str
	syscall	
	
	la pointer, str			# *pointer -> str
	
while:
	lb char, 0(pointer)		# pick the character
	beq char, '\n', endw		# check if end of string
	subi char, char, 0x61		# char = char - 'a'
	addi char, char, 0x41		# char = char + 'A'
	sb char, 0(pointer)		# substitute the character
	addi pointer, pointer, 1	# pointer++
	j while
	
endw:
	la arg0, str2
	li func, print_str
	syscall
	
	la arg0, str
	li func, print_str
	syscall

	