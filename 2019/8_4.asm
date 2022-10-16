		DIM = 5
		.data
vet1: .word 56, 12, 98, 129, 58
vet2: .word 1, 0, 245, 129, 12
risultato: .word space 20
		.text
		.globl main
		.ent main
main: 	subu $sp, $sp, 4
		sw $ra, ($sp)
		la $a0, vet1
		la $a1, vet2
		la $a2, risultato
		li $a3, DIM
		jal calcola_distanzaH
		lw $ra, ($sp)
		addiu $sp, $sp, 4
		jr $ra
		.end main
		
		
		.ent calcola_distanzaH
calcola_distanzaH: 
		# $a0= ind. vet1 $a1= ind. vet2 $a2= ind. risultato $a3=DIM
		li $t0, 0 # $t0 contatore Cicli
ciclo: 
		beq $t0, $a3, fine_ciclo
calcoloH: 
		lw $t7, ($a0)
		lw $t8, ($a1)
		xor $t2, $t7, $t8
		and $t3, $0, $0 	# azzeramento risultato
		and $t4, $0, $0 	# azzeramento indice
		li $t5, 1 			# mask per lettura bit a 1
cicloH: 
		and $t6, $t2, $t5
		beq $t6, 0, nextH
		addiu $t3, $t3, 1
nextH: 
		sll $t5, $t5, 1
		addiu $t4, $t4, 1
		bne $t4, 32, cicloH	# in $t3 il risultato
		sb $t3, ($a2)
		addiu $t0, $t0,1
		addiu $a0, $a0, 4
		addiu $a1, $a1, 4
		addiu $a2, $a2, 1
		j ciclo
fine_ciclo: 
		jr $ra
		.end calcola_distanzaH