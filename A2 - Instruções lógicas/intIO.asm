.data
str1: .asciiz "Introduza 2 numeros\n"
str2: .asciiz "A soma dos dois numeros e': "
.eqv print_string, 4
.eqv read_int, 5
.eqv print_int, 1
.text
.globl main
main:
	la  $a0, str1
	ori $v0, $0, print_string
	syscall 
	ori $v0, $0, read_int
	syscall
	or  $t0, $v0, $0
	ori $v0, $0, read_int
	syscall
	add $t0, $t0, $v0
	la  $a0, str2
	ori $v0, $0, print_string
	syscall
	or  $a0, $t0, $0
	ori $v0, $0, print_int
	syscall
	jr  $ra