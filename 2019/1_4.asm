		.data
var:	.word 0x3FFFFFF0
		.text
		.globl main
		.ent main
main:	lw $t0, var
		sll $t1, $t0, 1
		move $a0, $t1
		li $v0, 1
		syscall
		
		#addi $a0, $t1, 40 #Eccezione di overflow
		addiu $a0, $t1, 40
		li $v0, 1
		syscall
		
		li $t2, 40
		#add $a0, $t1, $t2 #Eccezione
		addu $a0, $t1, $t2
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
		.end main