		NUM = 5
		DIM = NUM * 4
		SCONTO = 30
		ARROTONDA = 1
		.data
prezzi: 	.word 39, 1880, 2394, 1000, 1590
scontati: 	.space DIM
totSconto: 	.space 4
		.text
		.globl main
		.ent main
main: 
		subu $sp, $sp, 4
		sw $ra, ($sp)
		la $a0, prezzi
		la $a1, scontati
		li $a2, NUM
		li $a3, SCONTO
		li $t0, ARROTONDA
		subu $sp, 4
		sw $t0, ($sp)
		jal calcola_sconto
		sw $v0, totSconto
		lw $ra, 4($sp)
		addu $sp, $sp, 8
		jr $ra
		.end main
		
		
		.ent calcola_sconto
calcola_sconto: 
		subu $fp, $sp, 4
		move $t0, $a0 		# prezzi
		move $t1, $a1 		# scontati
		move $t2, $0 		# indice ciclo
		li $t5, 100 		# costante
		sub $t3, $t5, $a3 	# percentuale del prezzo dopo lo sconto
		lw $t4, 4($fp) 		# arrotondamento
		move $v0, $0 		# sconto totale
ciclo: 
		lw $t6, ($t0)
		mul $t7, $t6, $t3
		div $t7, $t5
		mflo $t7
		beqz $t4, noArrotondamento
							# arrotonda il prezzo
		mfhi $t8
		blt $t8, 50, noArrotondamento
		addiu $t7, $t7, 1
noArrotondamento: 
		sw $t7, ($t1)
		subu $t8, $t6, $t7
		addu $v0, $v0, $t8
		addiu $t0, $t0, 4
		addiu $t1, $t1, 4
		addiu $t2, $t2, 1
		bne $t2, $a2, ciclo
		jr $ra
		.end calcola_sconto