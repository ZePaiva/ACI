	.data
	.eqv SIZE, 10
	.eqv TRUE, 1
	.eqv FALSE, 0
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv func, $v0
	.eqv arg0, $a0
	.eqv arg1, $a1
	.eqv i, $t0
	.eqv o, $t1
	.eqv dim, $t2		# este size e igual a 9 pois e mais pratico para utilizar no BubbleSort
	.eqv princ, $t3		# lista[i]
	.eqv aux, $t4		# lista[i+1]
	.eqv array, $t5		# &lista
	.eqv arraySize, $t6	# &lista[SIZE-1]
lista: 	.word 0:SIZE
str1:	.asciiz "\nNumero: "
str2:	.asciiz "\nArray ordenado: "
str3:	.asciiz "; "
str4:	.asciiz "\n"
	.text
	.globl main
main:
	# faz os loads
	la   array, lista			# array = &lista[0]
	li   arraySize, SIZE
	sll  arraySize, arraySize, 2 		# multplica por 4 pois cada int ocupa 4 e nao 1
	addu arraySize, arraySize, array 	# coloca listSize como ponteiro para o ultimo int do array
	
readInts:
	# quando termina de ler salta
	bge array, arraySize, endRead
	
	# Imprime a string inicial
	li  func, print_string
	la  arg0, str1
	syscall
	
	# le o inteiro
	li func, read_int
	syscall
	
	sw   func, (array)		# guarda o inteiro no indice i do arrray
	addu array, array, 4		# move para o proximo indice do array
	j readInts
	
	
endRead:
	# sequential sort
	li i, -1				# i = 1
	li dim, 9			# dim = 9
	la array, lista			# apontar para o primeiro indice
for1:	
	# quando termina nao voltar a repetir
	bge i, dim, endSort		
	addi i, i, 1
	li o, 0				# o = 0
	la array, lista
	
for2:
	# repeat till not
	bge o, SIZE, for1		# if o < 10
	lw  princ, (array)
	lw  aux, 4(array)
	ble princ, aux, noswap
	sw  princ, 4(array)
	sw  aux, (array)

noswap:
	addu array, array, 4		# ponteiro++
	addu o, o, 1			# o++
	j for2

endSort:
	# string para informacao do utilizador
	li func, print_string
	la arg0, str2
	syscall
	
	# loads inicias
	li i, 0				# i = 0
	la array, lista			# aponta para o primeiro
printOrd:
	# impressao do array ordenado
	bge i, SIZE, endPrint
	li func, print_int10
	lw arg0, (array)
	syscall
	li func, print_string
	la arg0, str3
	syscall
	addu i, i, 1
	addu array, array, 4
	j printOrd
	
endPrint:
	li func, print_string
	la arg0, str4
	syscall
	jr $ra
