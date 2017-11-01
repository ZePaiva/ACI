	.data
str1:	.asciiz "Nro de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv SIZE, 3
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv i, $t0
	.eqv argc, $t1
	.eqv argv, $t2
	.text 
	.globl main
main:	
	move argc, arg0
	move argv, arg1
	la   arg0, str1
	li   func, print_string
	syscall
	move arg0, argc
	li   func, print_int10
	syscall
	li   i, 0
for:	bge  i, argc, endfor
	la   arg0, str2
	la   func, print_string
	syscall
	move arg0, i
	li   func ,print_int10
	syscall
	la   arg0, str3
	la   func, print_string
	syscall
	sll  $t3, i, 2
	add  $t3, argv, $t3
	lw   arg0, ($t3)
	la   func, print_string
	syscall
	addi i, i, 1
	j for
endfor:		
	jr $ra