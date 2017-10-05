	.data
	.eqv size, 20
	.eqv read_string, 8
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv i, $t0
	.eqv num, $t1
	.eqv pstr, $t2
	.eqv strIndex, $t3
	.eqv char, $t4
str1:	.asciiz "\nstring: "
str2:	.asciiz "\n\nnums: "
str:	.space 20
	.text
	.globl main
main:
	la arg0, str1
	li func, print_string
	syscall
	
	# read string
	la arg0, str		# load pointer to string
	li arg1, size		# load string max size
	li func, read_string
	syscall
	
	# i = 0
	li i, 0
	
	# num = 0
	li num, 0
	
	# while cycle to count numbers in string
while:
	la pstr, str			# set pointer of string to $t2
	addu strIndex, pstr, i		# $t3 = str[i]
	lb char, (strIndex)			# char = str[i]
	beq char, 0, endw		# if str[i] == '\0' (terminator) go to end
	
	# check if it is a number
if:	
	ble char, 0x2f, endif
	bge char, 0x3a, endif
	addi num, num, 1
	
endif:
	addi i, i, 1
	j while
	
endw:
	la arg0, str2
	li func, print_string
	syscall
	move arg0, num
	li func, print_int10
	syscall
	jr $ra