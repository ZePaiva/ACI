.data
str1: .asciiz "Introduza um numero: "
str2: .asciiz  "\nO valor em bin'ario e': "
.eqv print_str, 4
.eqv read_int, 5
.eqv print_char, 11
.eqv print_int16, 34
.text 
.globl main
main:	ori $t0, $0, 0 # value
	ori $t1, $0, 0 # bit
	ori $t2, $0, 0 # i
	
	#  pergunta o valor
	ori $v0, $0, print_str
	la  $a0, str1
	syscall
	
	# le o valor a ser convertido em binario
	ori $v0, $0, read_int
	syscall
	
	# imprime a string informacional
	or  $t0, $0, $v0
	ori $v0, $0, print_str
	la  $a0, str2
	syscall
	
	# ciclo para imprimir  cada um dos 32 bits e identificar se estao ou nao ativos
for:	bge  $t2, 32,  end	  # controla o ciclo
	andi $t1, $t0, 0x80000000 # isola o bit mais significativo
	srl  $t1, $t1, 31	  # coloca o msbit na posi??o do ls bit
	sll  $t0, $t0, 1	  # torna o segundo bit ms para primeiro bit ms
	rem  $t3, $t2, 4	  # $t3 = i % 4
	addi $t2, $t2, 1	  # incrementa i
	beq  $t3, $0,  if_4al	  # se i % 4 == 0, imprime espa?o
	
	# imprime o bit e identifica se esta ativo(1) ou nao(0)
print:	ori  $v0, $0,  print_char # load do codigo da opera?ao
	or   $t3, $0,  $t1	  # carrega o estado do bit para um registo adicional 
	addi $t3, $t3, 0x30	  # transforma no caracter ascii (se 0x31 -> bit ativo, se 0X30 -> bit nao ativo)
	or   $a0, $0,  $t3	  # carrega o caracter para o argumento da fun?ao print_char
	syscall
	j for 
	
if_4al: ori  $v0, $0, print_char # load da opera?ao
	ori  $a0, $0, ' '	 # load do caracter a ser impresso
	syscall
	j print
	
end:	jr $ra
