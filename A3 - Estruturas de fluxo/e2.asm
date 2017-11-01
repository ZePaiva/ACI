.data
str1: .asciiz "Introduza um numero: "
str2: .asciiz  "\nO valor em bin'ario e': "
.eqv print_str, 4
.eqv read_int, 5
.eqv print_char, 11
.text 
.globl main
main:	ori $t0, $0, 0 # value
	ori $t1, $0, 0 # bit
	ori $t2, $0, 0 # i
	
	ori $v0, $0, print_str
	la  $a0, str1
	syscall
	
	ori $v0, $0, read_int
	syscall
	
	or  $t0, $0, $v0
	
	ori $v0, $0, print_str
	la  $a0, str2
	syscall
	
for:	bge  $t2, 32, end	  # controla o ciclo
	andi $t1, $t0, 0x80000000 # isola o bit 	
	sll $t0, $t0, 1		  # shif left de 1 bit	
	rem $t3, $t2, 4		  # i % 4
	addi $t2, $t2, 1	  # incrementa i
	beq $t3, $0, if_4al	  # se i % 4 == 0, print ' '	
	
if:	beq  $t1, $0, else
	ori  $v0, $0, print_char
	ori  $a0, $0, '1'
	syscall
	j for

else:	ori  $v0, $0, print_char
	ori  $a0, $0, '0'
	syscall
	j for
	
if_4al: ori  $v0, $0, print_char
	ori  $a0, $0, ' '
	syscall
	j if
	
end:	jr $ra
