	.data
	.eqv size, 20
	.eqv read_string, 8
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv num, $t0
	.eqv pointer, $t1
	.eqv char, $t2
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
	
	# num = 0
	li num, 0
	
	# p = str
	la pointer, str

while:
	lb char, (pointer)
	beq char, 0x00, endw
	ble char, 0x2f, endif
	bge char, 0x3a, endif
	addi num, num, 1
	
endif:
	addiu pointer, pointer, 1
	j while
	
endw:
	la arg0, str2
	li func, print_string
	syscall
	
	move arg0, num
	li func, print_int10
	syscall
	
	jr $ra