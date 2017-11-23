	.data
	.text
	.globl main
main:
	addi $2, $0, 0x1a
	addi $3, $0, -7
	add  $4, $2, $3
	sub  $5, $2, $3
	and  $6, $2, $3
	or   $7, $2, $3
	nor  $8, $2, $3
	xor  $9, $2, $3
	slt  $10, $2, $3
	slti $11, $7, -7
	slti $12, $9, -25
	nop
	jr $ra