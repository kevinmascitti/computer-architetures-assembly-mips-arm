		.data
str_orig: 	.asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente %"
str_sost: 	.asciiz "per me si va"
str_new: 	.space 200
		.text
		.globl main
		.ent main
main: 
		subu $sp, 4
		sw $ra, ($sp)
		la $a0, str_orig
		la $a1, str_sost
		la $a2, str_new
		jal sostituisci
		la $a0, str_new
		li $v0, 4
		syscall
		lw $ra, ($sp)
		addiu $sp, 4
		jr $ra
		.end main
		
		
		.ent sostituisci
sostituisci: 
		subu $sp, 4
		sw $a2, ($sp) # salvataggio indirizzo str_new (per calcolo lunghezza)
ciclo1: 
		lbu $t0, ($a0)
		beqz $t0, fine # controllo fine stringa
		bne $t0, '%', copia # controllo carattere da sostituire
		move $t1, $a1 # sostituzione
ciclo2: 
		lbu $t2, ($t1)
		beqz $t2, next
		sb $t2, ($a2)
		addiu $t1, 1
		addiu $a2, 1
		j ciclo2
copia: 
		sb $t0, ($a2) # copia caratteri stringa
		addiu $a2, 1
next: 
		addiu $a0, 1
		j ciclo1
fine: 
		sb, $0, ($a2)
		lw $t0, ($sp) # calcolo lunghezza della nuova stringa
		addiu $sp, 4
		subu $v0, $a2, $t0
		jr $ra
		.end sostituisci