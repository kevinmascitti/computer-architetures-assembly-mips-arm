		.data
error:	.asciiz "\nErrore: non è stato inserito un numero!\n"
empty:	.asciiz "\nErrore: non è stato inserito alcun carattere.\n"
ok:		.asciiz "\nE' stato inserito un numero corretto.\n"

		.text
		.globl main
		.ent main
main:	move $t1, $0 #contatore numero di caratteri letti
		
for:	li $v0, 12
		syscall
		move $t0, $v0
		beq $t0, '\n', exit
		blt $t0, '0', err # Verifico se il char
		bgt $t0, '9', err # immesso è una cifra
		addi $t1, $t1, 1
		j for
		
err:	la $a0, error
		j end

exit:	beq $t1, $0, none
		la $a0, ok
		j end

none:	la $a0, empty

end:	li $v0, 4
		syscall
		li $v0, 10
		syscall
		.end main