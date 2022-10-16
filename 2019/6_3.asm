		.data
stringa: .asciiz "parola"
		.text
		.globl main
		.ent main
main: 	
		li $t0, 0
ciclo: 	
		lbu $a0, stringa($t0)
		jal converti
		sb $v0, stringa($t0)
		addi $t0, $t0, 1
		bne $t0, 6, ciclo
		
		li $v0, 10
		syscall
		.end main
		
		
		.ent converti
converti: 
		addi $a0, $a0, 'A'
		li $v0, 'a'
		sub $v0, $a0, $v0
		jr $ra
		.end converti