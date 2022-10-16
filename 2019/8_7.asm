		.data
		RIGHE = 9
		COLONNE = 9
		DIM = RIGHE * COLONNE
		ITERAZIONI = 14
matrice1: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 1, 0, 0, 0, 0
		.byte 0, 0, 0, 1, 1, 1, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
		.byte 0, 0, 0, 0, 0, 0, 0, 0, 0
matrice2: .space DIM
		
		.text
		.globl main
		.ent main
main: 
		subu $sp, $sp, 4
		sw $ra, ($sp)
		move $s0, $0
cicloMain: 
		and $t0, $s0, 1 # passaggio parametri
		beqz $t0, pari 	# nelle iterazioni dispari, la matrice iniziale e' matrice2
		la $a0, matrice2
		la $a1, matrice1
		b altriParametri
pari: 
		la $a0, matrice1 # nelle iterazioni pari, la matrice iniziale e' matrice1
		la $a1, matrice2
		altriParametri: li $a2, RIGHE
		li $a3, COLONNE
		jal evoluzione
		addi $s0, $s0, 1
		bne $s0, ITERAZIONI, cicloMain
		lw $ra, ($sp)
		addu $sp, $sp, 4
		jr $ra
		.end main
		
		
		.ent evoluzione
evoluzione: 
		subu $sp, $sp, 36
		sw $ra, ($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		sw $s4, 20($sp)
		sw $s5, 24($sp)
		sw $s6, 28($sp)
		sw $s7, 32($sp)
		move $s0, $a0 # salvo gli argomenti perche' le procedure leaf potrebbero cambiarli
		move $s1, $a1
		move $s2, $a2
		move $s3, $a3
		move $s4, $0
		mul $s5, $a2, $a3 	# numero di elementi nella matrice
		move $s6, $s0 		# elemento corrente nella matrice corrente
		move $s7, $s1 		# elemento corrente nella matrice futura
ciclo: 
		move $a0, $s0
		move $a1, $s4
		move $a2, $s2
		move $a3, $s3
		jal contaVicini
		lb $t0, ($s6)
		beqz $t0, cellaMorta
		beq $v0, 2, cellaFuturaViva
		beq $v0, 3, cellaFuturaViva
		cellaFuturaMorta: li $t0, 0
		b next
cellaMorta: 
		bne $v0, 3, cellaFuturaMorta
cellaFuturaViva: 
		li $t0, 1
next: 
		sb $t0, ($s7)
		addi $s4, $s4, 1
		addi $s6, $s6, 1
		addi $s7, $s7, 1
		bne $s4, $s5, ciclo
		move $a0, $s1
		move $a1, $s2
		move $a2, $s3
		jal stampaMatrice
		lw $ra, ($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp)
		lw $s6, 28($sp)
		lw $s7, 32($sp)
		addu $sp, $sp, 36
		jr $ra
stampaMatrice: 
		li $v0, 11
		move $t0, $a0
		move $t1, $0 	# indice riga
cicloRighe: 
		move $t2, $0 	# indice colonna
cicloColonne: 
		lb $t3, ($t0)
		li $a0, ' '
		beqz $t3, stampaCarattere
		li $a0, '*'
stampaCarattere: 
		syscall
		addi $t0, $t0, 1
		addi $t2, $t2, 1
		bne $t2, $a2, cicloColonne
		li $a0, '\n'
		syscall
		addi $t1, $t1, 1
		bne $t1, $a1, cicloRighe
		syscall 		# stampa un altro new line
		jr $ra
		.end Evoluzione