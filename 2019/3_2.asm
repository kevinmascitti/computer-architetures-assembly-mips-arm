		.data
error:	.asciiz "\nErrore: non è stato inserito un numero!\n"
empty:	.asciiz "\nErrore: non è stato inserito alcun carattere.\n"
ok:		.asciiz "\nE' stato inserito correttamente il numero: "

		.text
		.globl main
		.ent main
main:	move $t1, $0 #contatore numero di caratteri letti
		move $t2, $0 #contenitore di numeri
		li $t3, 10
		
for:	li $v0, 12
		syscall
		move $t0, $v0
		beq $t0, '\n', exit
		blt $t0, '0', err # Verifico se il char
		bgt $t0, '9', err # immesso è una cifra
		
		sub $t0, $t0, '0'
		mulou $t3, $t2, $t3
		
		add $t2, $t2, $t0
		mulou $t3, $t2, $t3
		
		addi $t1, $t1, 1
		j for
		
err:	la $a0, error
		li $v0, 4
		syscall
		j end

exit:	beq $t1, $0, none
		li $v0, 4
		la $a0, ok
		syscall
		li $v0, 1
		move $a0, $t2
		syscall
		j end

none:	la $a0, empty
		li $v0, 4
		syscall

end:	li $v0, 10
		syscall
		.end main