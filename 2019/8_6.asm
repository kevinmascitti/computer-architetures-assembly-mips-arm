		RIGHE = 4
		COLONNE = 5
		.data
matrice: .byte 0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 24, 8, 25, 43, 62
		.text
		.globl main
		.ent main
main: 
		subu $sp, $sp, 4
		sw $ra, ($sp)
		la $a0, matrice
		li $a1, 19
		li $a2, RIGHE
		li $a3, COLONNE
		jal contaVicini
		lw $ra, ($sp)
		addu $sp, $sp, 4
		jr $ra
		.end main
		
		
		.ent contaVicini
contaVicini: 
		divu $a1, $a3
		mflo $t0, 			# indice riga
		mfhi $t1, 			# indice colonna
		move $v0, $0 # somma delle celle vicine
		addi $t2, $t0, -1 	# indice riga sopra
		bne $t2, -1, indiceRigaSotto
		move $t2, $0
indiceRigaSotto: 
		addi $t3, $t0, 1
		bne $t3, $a2, indiceColonnaASinistra
		sub $t3, $a2, 1
indiceColonnaASinistra: 
		addi $t4, $t1, -1
		bne $t4, -1, indiceColonnaADestra
		move $t4, $0
indiceColonnaADestra: 
		addi $t5, $t1, 1
		bne $t5, $a3, indiciCelle
		sub $t5, $a3, 1
indiciCelle: 
		mul $t1, $t2, $a3
		add $t0, $t1, $t4 # indice dell'elemento a sinistra nella riga sopra
		add $t1, $t1, $t5 # indice dell'elemento a destra nella riga sopra
		mul $t2, $t3, $a3
		add $t2, $t2, $t4 # indice dell'elemento a sinistra nella riga sotto
		add $t0, $t0, $a0 # somma l'indirizzo iniziale della matrice
		add $t1, $t1, $a0
		add $t2, $t2, $a0
		add $a1, $a1, $a0
cicloEsterno: 
		move $t3, $t0
cicloInterno: 
		beq $t3, $a1, saltaElemento
		lb $t4, ($t3)
		add $v0, $v0, $t4
saltaElemento: 
		add $t3, $t3, 1
		bleu $t3, $t1, cicloInterno
		add $t0, $t0, $a3
		add $t1, $t1, $a3
		bleu $t0, $t2, cicloEsterno
		jr $ra
		.end contaVicini