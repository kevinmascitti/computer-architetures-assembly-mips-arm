		.data
hugeNumber:	.word 3141592653
		.text
		.globl main
		.ent main
main: 	lw $a0, hugeNumber
		li $v0, 1
		syscall #stampa errata: -1153374643
		
		li $t0, 0 # numero di cifre da stampare
		li $t1, 10 # costante
		lw $t2, hugeNumber
ciclo1: 
		divu $t2, $t1
		mfhi $t2
		addu $t0, $t0, 1
		subu $sp, $sp, 4 	# push
		sw $t2, ($sp)	 	# push
		mflo $t2
		bne $t2, $0, ciclo1
		
		li $v0, 11
		li $a0, '\n'
		syscall
ciclo2:
		lw $a0, ($sp)		# pop
		addu $a0, $a0, '0'
		syscall
		addu $sp, $sp, 4	# pop
		subu $t0, $t0, 1
		bne $t0, $0, ciclo2
		
		li $v0, 10
		syscall
		.end main