		.data
		.text
		.globl main
		.ent main
main: 	jal stampaTriangolo
		jal stampaQuadrato
		li $v0, 10
		syscall
		.end main
		

		.ent stampaTriangolo
stampaTriangolo: 
		li $t0, 1 	#numero totale di righe stsmpate(min 1)
		li $v0, 11
cicloRigheTriangolo:
		li $a0, '*'
		li $t1, 0	#numero totale di asterischi stampati sulla riga
cicloColonneTriangolo:
		syscall
		addi $t1, $t1, 1
		bne $t1, $t0, cicloColonneTriangolo
		li $a0, '\n'
		syscall
		addi $t0, $t0, 1
		bne $t0, 9, cicloRigheTriangolo
		jr $ra
		.end stampaTriangolo
		
		
		.ent stampaQuadrato
stampaQuadrato: 
		li $t0, 0 #indice riga
		li $v0, 11
cicloRigheQuadrato:
		li $a0, '*'
		li $t1, 0 #indice colonna
cicloColonneQuadrato:
		syscall
		addi $t1, $t1, 1
		bne $t1, 8, cicloColonneQuadrato
		li $a0, '\n'
		syscall
		addi $t0, $t0, 1
		bne $t0, 8, cicloRigheQuadrato
		jr $ra
		.end stampaQuadrato