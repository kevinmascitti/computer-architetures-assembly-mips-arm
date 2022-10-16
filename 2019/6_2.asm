		.data
input: 	.asciiz "Introduci un numero: "
		.text
		.globl main
		.ent main
main: 	la $a0, input
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $s0, $v0
		move $a0, $s0
		jal stampaTriangolo
		move $a0, $s0
		jal stampaQuadrato
		li $v0, 10
		syscall
		.end main
		
		
		.ent stampaTriangolo
stampaTriangolo: 
		addi $t2, $a0, 1
		li $t0, 1 #numero totale di righe stsmpate(min 1)
		li $v0, 11
cicloRigheTriangolo:
		li $a0, '*'
		li $t1, 0 #numero totale di asterischi stampati sulla riga
cicloColonneTriangolo:
		syscall
		addi $t1, $t1, 1
		bne $t1, $t0, cicloColonneTriangolo
		li $a0, '\n'
		syscall
		addi $t0, $t0, 1
		bne $t0, $t2, cicloRigheTriangolo
		jr $ra
		.end stampaTriangolo
		
		
		.ent stampaQuadrato
stampaQuadrato: 
		move $t2, $a0
		li $t0, 0 #indice riga
		li $v0, 11
cicloRigheQuadrato:
		li $a0, '*'
		li $t1, 0 #indice colonna
cicloColonneQuadrato:
		syscall
		addi $t1, $t1, 1
		bne $t1, $t2, cicloColonneQuadrato
		li $a0, '\n'
		syscall
		addi $t0, $t0, 1
		bne $t0, $t2, cicloRigheQuadrato
		jr $ra
		.end stampaQuadrato