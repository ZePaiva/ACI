	.data
array:	.word str1, str2, str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:	.asciiz ": "
str5:	.asciiz "\nString #"
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv SIZE, 3
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arr, $t0
	.eqv i, $t1
	.eqv o, $t2
	.eqv arrCont, $t3
	.eqv strCont, $t4
	.eqv char, $t5
	.text 
	.globl main

main:	li i, 0
	la arr, array
	
for:	bge i, SIZE, endfor
	la arg0, str5
	li func, print_string
	syscall
	move arg0, i
	li   func, print_int10
	syscall
	la arg0, str4
	li func, print_string
	syscall
	li o, 0
	
while:	sll  arrCont, i, 2
	addu arrCont, arr, arrCont
	lw   strCont, (arrCont)
	addu strCont, strCont, o
	lb   char, (strCont)
	beq  char, '\0', endwhile
	li   func, print_char
	move arg0, char
	syscall
	addi o, o, 1
	j while
endwhile:
	addi i, i, 1
	j for
endfor:	
	jr $ra