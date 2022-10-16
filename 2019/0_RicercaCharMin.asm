				.data
wVet: 			.space 5
wRes: 			.space 1
message_in: 	.asciiz "Inserire caratteri\n"
message_out:	.asciiz "\nValore Minimo : "
				.text
				.globl main
				.ent main
main:
				la $t0, wVet # puntatore a inizio del vettore
				li $t1, 0 # contatore
				la $a0, message_in # indirizzo della stringa
				li $v0, 4 # system call per stampare stringa
				syscall