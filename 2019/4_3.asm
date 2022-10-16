		.data
NUM_ELEM = 4
DIM = 4 * NUM_ELEM
vetrig: .word 1,2,3,4
vetcol:	.word -1,-2,-3,-4
mat:	.space DIM * NUM_ELEM

		.text
		.globl main
		.ent main
		
main:
		li $t0, 0 # offset matrice
		li $t1, 0 # contatore vettore colonna
ciclocol: 
		lw $t3, vetcol($t1)
		li $t2, 0 # contatore vettore righe
ciclorig: 
		lw $t4, vetrig($t2)
		mult $t3, $t4
		mflo $t4
		mfhi $t5
		sra $t6, $t4, 31
		bne $t5, $t6, overflow # controllo segno sia uguale
		sw $t4, matrice($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, 4
		blt $t2, DIM, ciclorig
		
		addi $t1, $t1, 4
		blt $t1, DIM, ciclocol
		j end

overflow:
		

end:	li $v0, 10
		syscall
		.end main