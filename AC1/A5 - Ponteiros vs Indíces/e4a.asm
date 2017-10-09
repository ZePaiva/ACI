	.data
	# constantes
	.eqv SIZE, 10
	.eqv TRUE, 1
	.eqv FALSE, 0
	# functions
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv print_string, 4
	# language upgrade
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv swap, $t0
	.eqv aux, $t1
	.eqv princ, $t2
	.eqv pointer, $t3
	.eqv pLast, $t4
lista: 	.word 0:SIZE
str1:	.asciiz "\nNumero: "
str2:	.asciiz "\nArray ordenado: "
str3:	.asciiz "; "
str4:	.asciiz "\n"
	.text
	.globl main
main:
	# pointer to last element of list
	la   pointer, lista
	la   pLast, lista
	li   aux, SIZE
	sll  aux, aux, 2
	addu pLast, pLast, aux
	
readInts:
	# quando termina de ler salta
	bge pointer, pLast, endRead
	
	# Imprime a string inicial
	li  func, print_string
	la  arg0, str1
	syscall
	
	# le o inteiro
	li func, read_int
	syscall
	sw   func, (pointer)			# guarda o inteiro no indice i do arrray
	addu pointer, pointer, 4		# move para o proximo indice do array
	j readInts
	
endRead:

	# pointer to last element of list
	la   pLast, lista
	li   aux, SIZE
	sll  aux, aux, 2
	addu pLast, pLast, aux
	
do:	# bubbleSort
	li swap, FALSE
	la pointer, lista
	
for:	# percorre todo o array
	bge pointer, pLast, endFor
	lw princ, (pointer)
	lw aux, 4(pointer)

ifBig:	# compara
	ble princ, aux, noSwap
	sw  princ, 4(pointer)
	sw  aux, (pointer)
	li  swap, TRUE

noSwap: # se nao era maior
	addu pointer, pointer, 4	# pointer++
	j for

endFor:
	beq swap, TRUE, do
	li func, print_string
	la arg0, str2
	syscall
	
	la pointer, lista
printInts:
	# impressao do array ordenado
	bge pointer, pLast, endPrint
	li func, print_int10
	lw arg0, (pointer)
	syscall
	li func, print_string
	la arg0, str3
	syscall
	addu pointer, pointer, 4
	j printInts
	
endPrint:
	li func, print_string
	la arg0, str4
	syscall
	jr $ra
	