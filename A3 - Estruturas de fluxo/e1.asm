.data
str1: .asciiz "Introduza um numero: "
str2: .asciiz "Valor ignorado\n"
str3: .asciiz "A soma dos positivos e': "
.eqv print_str, 4
.eqv print_int10, 36
.eqv read_int, 5
.text
.globl main
main:	li  $t2, 0
	li  $t0, 0
	
for:	bge $t2, 5, end
	ori $v0, $0, print_str
	la  $a0, str1
	syscall
	
	ori $v0, $0, read_int
	syscall
	
	bgt $v0, 0, if
	ori $v0, $0, print_str
	la  $a0, str2
	syscall
	addi $t2,$t2,1
	j for
	
if:	add $t0, $t0, $v0
	addi $t2,$t2,1
	j for

end:	ori $v0, $0, print_str
	la  $a0, str3
	syscall
	
	ori $v0, $0, print_int10
	or  $a0, $0, $t0
	syscall
	
	jr $ra
	
	