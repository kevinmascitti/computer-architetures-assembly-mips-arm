		.data
input: 	.asciiz "Introduci un numero: "
		.text
		.globl main
		.ent main
main: 	
		subu $sp, 4
		sw $ra, ($sp)
		la $a0, input
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $a0, $v0
		jal calcolaSuccessivo
		lw $ra, ($sp)
		addiu $sp, 4
		jr $ra
		.end main
		
		
		.ent calcolaSuccessivo
calcolaSuccessivo:
		and $t0, $a0, 1
		beqz $t0, pari
		mulou $t0, $a0, 3 # il numero e' dispari
		addi $t0, $t0, 1
		b fine
pari: 	
		sra $t0, $a0, 1
fine: 	
# stampa il numero seguito da un new line
		move $a0, $t0
		li $v0, 1
		syscall
		li $a0, '\n'
		li $v0, 11
		syscall
		move $v0, $t0
		jr $ra
		.end calcolaSuccessivo