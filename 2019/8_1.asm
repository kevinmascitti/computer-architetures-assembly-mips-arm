		.data
ora_in: .byte 12, 47
ora_out: .byte 18, 14
X: 		.byte 1
Y: 		.byte 40
		.text
		.globl main
		.ent main
main: 	
		sub $sp, 4
		sw $ra, ($sp)
		la $a0, ora_in # indirizzo di ora_in
		la $a1, ora_out # indirizzo di ora_out
		lbu $a2, X
		lbu $a3, Y
		jal costoParcheggio
		lw $ra, ($sp)
		jr $ra
		.end main


		.ent costoParcheggio
costoParcheggio: lbu $t0, 0($a1) # data la dimensione dei dati 
								# non puo’ verificarsi overflow
		lbu $t1, 0($a0)
		subu $t0, $t0, $t1
		li $t1, 60
		multu $t0, $t1
		lbu $t0, 1($a1)
		lbu $t1, 1($a0)
		subu $t0, $t0, $t1
		mflo $t1
		addu $t0, $t0, $t1
		divu $t0, $a3
		mflo $t0
		mfhi $t1
		beqz $t1, next
		addiu $t0, $t0, 1
next: multu $t0, $a2
		mflo $v0
		jr $ra # return
		.end costoParcheggio