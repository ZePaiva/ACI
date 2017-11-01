.data
.eqv print_int16,34
.eqv print_char,11
.text
.globl main
main:
	ori  $t0, $0, 0x1234
	andi $a0, $t0, 0xF000
	srl  $a0, $a0, 12
	ori  $v0, $0, print_int16
	syscall
	ori  $v0, $0, print_char
	ori  $a0, $0, '\n'
	syscall
	andi $a0, $t0, 0x0f00
	srl  $a0, $a0, 8
	ori  $v0, $0, print_int16
	syscall
	ori  $v0, $0, print_char
	ori  $a0, $0, '\n'
	syscall
	andi $a0, $t0, 0x00f0
	srl  $a0, $a0, 4
	ori  $v0, $0, print_int16
	syscall
	ori  $v0, $0, print_char
	ori  $a0, $0, '\n'
	syscall
	andi $a0, $t0, 0x000f
	srl  $a0, $a0, 0
	ori  $v0, $0, print_int16
	syscall
	ori  $v0, $0, print_char
	ori  $a0, $0, '\n'
	jr $ra