.data
.text
.globl	main
main:	ori $v0, $0, 5		# chama teclado
	syscall 
	or  $t0, $0, $v0        # obtem do teclado pro registo 1
	ori $t2, $0, 8		# faz os calculos
	add $t1, $t0, $t0
	sub $t1, $t1, $t2
	
	or  $a0, $0, $t1	# mete valor como argumento em a0
	ori $v0, $0, 36		# envia para o ecra
	syscall
	
	jr  $ra
