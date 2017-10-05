.data
str1: .asciiz "Introduza um numero: "
str2: .asciiz  "\nO valor em bin'ario e': "
.eqv print_str, 4
.eqv read_int, 5
.eqv print_char, 11
.eqv print_int16, 34
.eqv value, $t0
.eqv bit, $t1
.eqv i, $t2
.eqv spaces, $t3
.eqv flag, $t4
.eqv func, $v0
.eqv arg1, $a0
.text 
.globl main
main:	
	li bit, 0
	li value, 0
	li i, 0
	li flag, 0
	
	#  pergunta o valor
	li func, print_str
	la arg1, str1
	syscall
	
	# le o valor a ser convertido em binario
	li func read_int
	syscall
	
	# imprime a string informacional
	move value, func
	li   func, print_str
	la   arg1, str2
	syscall
	
do:	# ciclo para imprimir  cada um dos 32 bits e identificar se estao ou nao ativos
	andi bit, value, 0x80000000 # isola o bit mais significativo
	srl  bit, bit, 31	    # coloca o msbit na posicao do ls bit
	addi i, i, 1	            # incrementa i
	beq  flag, $0, ifFlag       # testa se a flag e positiva ou nao caso ainda nao seja
	j insideIf		    # continua se a flag = 1

ifFlag: # testa a flag
	or   flag, $0, bit	    # flag = bit
	j insideIf
	
insideIf:  # continua apos teste da flag
	sll  value, value, 1	         # torna o segundo bit ms para primeiro bit ms
	beq  flag, $0, do	    	 # se flag = 0 e bit = 0, nao faz nada
	
print:	# imprime o bit e identifica se esta ativo(1) ou nao(0)
	li  func, print_char      # load do codigo da opera?ao
	or   $t7, $0,  bit	  # carrega o estado do bit para um registo adicional 
	addi $t7, $t7, 0x30	  # transforma no caracter ascii (se 0x31 -> bit ativo, se 0X30 -> bit nao ativo)
	or   arg1, $0,  $t7	  # carrega o caracter para o argumento da funcao print_char
	syscall
	rem  spaces, i, 4	  # $t3 = i % 4
	beq  spaces, $0,  if_4al  # se i % 4 == 0, imprime espaco
	blt  i, 32, do		  # enquanto i < 32 
	
if_4al: li  func, print_char 	  # load da opera?ao
	li  arg1, ' '	     	  # load do caracter a ser impresso
	syscall
	blt  i, 32, do		  # enquanto i < 32
	
endLoop:	
	jr $ra
