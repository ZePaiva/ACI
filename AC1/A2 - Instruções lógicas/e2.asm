.data
.text
.globl main
main:	ori $t0, $0, 0x862a5c1b
	sll $t2, $t0, 4
	srl $t3, $t0, 4
	sra $t4, $t0, 4
	jr  $ra