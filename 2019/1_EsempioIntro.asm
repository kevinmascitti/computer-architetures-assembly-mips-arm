#caricare un valore in memoria
#decremento il registro
#visualizzo a video
#salvo il registro in memoria

		.data
num:	.word 10 	#funziona anche con -10 ma con -1mld non vedo il carattere '-'
					#prima del valore nella memoria perché non c'è spazio!
					#se uso -3mld, il numero salvato è assurdo
					#se uso +3mld, il numero salvato è quello in C2
					#se faccio +3mld-2mld, ho errore in run perché
					#non dico che voglio usare 3mld in C2 in binario puro
					#quindi lo dico al compilatore usando SUBU unsigned
		.text
		.globl main
		.ent main
main:	lw $t0, num
		sub $t0, $t0, 1
		li $v0, 1
		move $a0, $t0
		syscall
		sw $t0, numli $v0, 10
		syscall
		.end main