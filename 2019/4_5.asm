			.data
NUMCOL = 6
NUMRIG = 4
DIMRIG = 4 * NUMCOL
wMat: 		.word 154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24,
					12, 55, -45, 0, 0, 0, 0, 0, 0, 0
			.text
			.globl main
			.ent main
main: 		la $t0, wMat

			li $t1, 1 # contatore righe
ciclorig1: 	li $t2, 1 # contatore colonne
			li $t3, 0 # accumulatore
			
ciclocol1: 	lw $t4, ($t0)
			add $t3, $t3, $t4
			addi $t0, $t0, 4
			addi $t2, $t2, 1
			blt $t2, NUMCOL, ciclocol1
			
			sw $t3, ($t0)
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			blt $t1, NUMRIG, ciclorig1
			
			li $t1, 0 # contatore colonne
ciclocol2: 	la $t0, wMat
			sll $t3, $t1, 2
			add $t0, $t0, $t3 # indirizzo del primo elemento della colonna
			li $t2, 1 # contatore righe
			li $t3, 0 # accumulatore
			
ciclorig2:	lw $t4, ($t0)
			add $t3, $t3, $t4
			addi $t0, $t0, DIMRIG
			addi $t2, $t2, 1
			blt $t2, NUMRIG, ciclorig2
			
			sw $t3, ($t0)
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			blt $t1, NUMCOL, ciclocol2
			
			li $v0, 10
			syscall
			.end main