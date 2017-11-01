	.data
	.eqv size, 4
	.eqv read_string, 8
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv ponteiro, $t0
	.eqv ultimo, $t1
	.eqv valor, $t2
	.eqv soma, $t3
array:	.word 7692, 23, 5, 234
str:	.asciiz "\nSoma: "
	.text
	.globl main
main:	
	li soma, 0			# soma = 0
	li $t4, size			# tamanho
	sll $t4, $t4, 2			# como sao inteiros, espa?o ocupado == 4, tamanho tem ser *4 (ou sll 2)
	la ponteiro, array		# ponteiro pro primeiro indice do array
	addu ultimo, ponteiro, $t4	# ponteiro para o ultimo indice do array
	
while:
	beq ponteiro, ultimo, endw	# se apontar para o ultimo valor no array termina
	lw valor, (ponteiro)		# obtem o valor
	addu soma, soma, valor		# calcula a soma atual
	add ponteiro, ponteiro, size	# incrementa o ponteiro
	j while
	
endw:
	la arg0, str
	li func, print_string
	syscall
	
	move arg0, soma
	li func, print_int10
	syscall
	
	jr $ra