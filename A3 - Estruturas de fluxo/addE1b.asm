.data
str1: .asciiz "Introduza um numero: "
str2: .asciiz  "\nO valor em hexadecimal: "
.eqv print_str, 4
.eqv read_int, 5
.eqv print_char, 11
.eqv i, $t0
.eqv value, $t1
.eqv digito, $t2
.eqv func, $v0
.eqv arg1, $a0
.text 
.globl main
main:	
	# tirar o lixo dos registos a usar
	li i, 0
	li value, 0
	li digito, 0
	li arg1, 0
	
	# print string 1
	li func, print_str
	la arg1, str1
	syscall
	
	# ler int
	li func, read_int
	syscall
	move value, func
	
	# print string 2
	li func, print_str
	la arg1, str2
	syscall
	
	# i = 8
	li i, 8

while:	# ciclo para obter o primeiro HEX digit
	andi $t3, value, 0xE00000
	bne  $t3, $0, do
	ble  i, $0, do
	sll  value, value, 3
	subi  i, i, 1
	j while
	
do:	# quando acaba o ciclo do primeiro HEX, neste caso passa diretamente pra outro ciclo do{}while()
	andi $t3, value, 0xE00000
	srl  digito, $t3, 21
	bgt  digito, 8, else
	li   func, print_char
	addi arg1, digito, 0x30
	syscall
	j endIF

else:	# se digito > 9
	li   func, print_char
	addi arg1, digito, 0x30
	addi arg1, arg1, 7
	syscall
	j endIF

endIF:	# fim do if
	sll  value, value, 3
	subi i, i, 1
	bgt  i, 0, do
	
fim:	jr $ra
