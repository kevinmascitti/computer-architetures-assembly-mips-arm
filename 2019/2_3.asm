		.data
word0:	.word 12
word1:	.word 31
word2:	.word 1

		.text
		.globl main
		.ent main
main:	lw $t0, word0
		lw $t1, word1
		lw $t2, word2
		
		blt $t0, $t1, ac
		move $t3, $t0
		move $t0, $t1
		move $t1, $t3

ac:		blt $t0, $t2, bc
		move $t3, $t0
		move $t0, $t2
		move $t2, $t3
		
bc:		blt $t0, $t2, stampa
		move $t3, $t1
		move $t1, $t2
		move $t2, $t3
		
stampa:	move $a0, $t0
		li $v0, 1
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		move $a0, $t1
		li $v0, 1
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		move $a0, $t2
		li $v0, 1
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		li $v0, 10
		syscall
		.end main