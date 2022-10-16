		.data
input: 	.asciiz "Introduci un numero: "
output: .asciiz "Numero di elementi nella sequenza: "
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
		jal sequenzaDiCollatz
		move $t0, $v0
		la $a0, output
		li $v0, 4
		syscall
		move $a0, $t0
		li $v0, 1
		syscall
		lw $ra, ($sp)
		addiu $sp, 4
		jr $ra
		.end main
		
		
		.ent sequenzaDiCollatz
sequenzaDiCollatz:
		addi $sp, $sp, -8
		sw $ra, 4($sp)
		sw $s0, ($sp)
		li $s0, 1 # numero di elementi nella successione
ciclo: 
		beq $a0, 1, fineCiclo
		jal calcolaSuccessivo
		move $a0, $v0
		addi $s0, $s0, 1
		b ciclo
fineCiclo: 
		move $v0, $s0
		lw $s0, ($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra
		.end sequenzaDiCollatz
		
		
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