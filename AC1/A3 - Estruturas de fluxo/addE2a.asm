	.data
str1: .asciiz "Introduza dois numeros:\n"
str2: .asciiz "num1: "
str3: .asciiz "num2: "
str4: .asciiz "Resultado: "

.eqv print_str, 4
.eqv read_int, 5
.eqv print_int10, 1
.eqv i, $t0
.eqv res, $t1
.eqv mdo, $t2
.eqv mdor, $t3
.eqv func, $v0
.eqv arg1, $a0
	.text
	.globl main
	
main:
	# nao deixar lixo
	li i, 0
	li res, 0
	li mdor, 0
	li mdo, 0
	
	# print string 1
	li func, print_str
	la arg1, str1
	syscall
	
	# read int mdor and apply 0x0f bitwise and
	li func, print_str
	la arg1, str2
	syscall
	li func, read_int
	syscall
	move mdor, func
	andi mdor, mdor, 0x0f
	
	# read int mdo and apply 0x0f bitwise and
	li func, print_str
	la arg1, str3
	syscall
	li func, read_int
	syscall
	move mdo, func
	andi mdo, mdo, 0x0f
	
	
while:	# while cycle to calculate result	
	beq  mdor, 0, endWhile
	bge  i, 4, endWhile
	addi i, i, 1
	andi  $t4, mdor, 0x1
	beq  $t4, $0, else
	add  res, res, mdo
	
else:	# if mdor last bit != 0	
	sll mdo, mdo, 1
	srl mdor,mdor, 1
	j while
	
endWhile: # after cycle
	
	# cast string
	li func, print_str
	la arg1, str4
	syscall
	
	# show result
	li func, print_int10
	or arg1, res, $0
	syscall
	
	jr $ra