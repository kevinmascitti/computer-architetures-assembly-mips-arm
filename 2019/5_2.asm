		.data
input: 				.asciiz "Introduci una stringa: "
outputVuoto: 		.asciiz "non hai inserito nessun carattere"
outputNoPalindromo: .asciiz "La stringa non e' palindroma"
outputPalindromo: 	.asciiz "La stringa e' palindroma"
		.text
		.globl main
		.ent main
main:
		move $t0, $sp 			#posizione iniziale dello stack
		move $s0, $sp			#salvo lo stack iniziale
		li $t1, 0 				#numero di caratteri introdotti dall'utente
		la $a0, input
		li $v0, 4
		syscall
cicloLettura:
		li $v0, 12
		syscall
		beq $v0, '\n', fineLettura
		addi $t1, $t1, 1
		subu $sp, $sp, 4		#push
		sw $v0, ($sp)			#push
		b cicloLettura
fineLettura: 
		beq $t1, 0, noInput
cicloControllo:
		subu $t0, $t0, 4		#pop primo valore inserito
		lw $t2, ($t0)			#pop primo valore inserito
		lw $t3, ($sp)			#pop ultimo valore inserito
		addu $sp, $sp, 4		
		bne $t2, $t3, noPalindromo
		addi $t1, $t1, -2
		bgt $t1, 0, cicloControllo
		la $a0, outputPalindromo
		b stampa
noPalindromo:
		la $a0, outputNoPalindromo
		b stampa
noInput:
		la $a0, outputVuoto
stampa:
		li $v0, 4
		syscall
		move $sp, $s0 			#ripristino lo stack pointer
		li $v0, 10
		syscall
		.end main