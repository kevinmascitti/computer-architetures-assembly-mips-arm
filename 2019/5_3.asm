		.data
msgInput: 		.asciiz "Inserisci i valori di A, b e C (separati da invio): "
msg_due_sol: 	.asciiz "Esistono due soluzioni reali"
msg_no_sol: 	.asciiz "Non esistono soluzioni reali"
msg_sol_coinc: 	.asciiz "Due soluzioni coincidenti"
		.text
		.globl main
		.ent main
main: 
		la $a0, msgInput
		li $v0, 4
		syscall
		li $v0, 5 # legge A e lo salva in $t0
		syscall
		move $t0, $v0
		li $v0, 5 # legge B e lo salva in $t1
		syscall
		move $t1, $v0
		li $v0, 5 # legge C e lo salva in $t2
		syscall
		move $t2, $v0
		
		mul $t3, $t1, $t1 # $t3 = B^2
		mul $t4, $t0, $t2 # $t4 = AC
		sll $t4, $t4, 2 # $t4 = 4AC
		sub $t3, $t3, $t4 # $t3 = DISCRIMINANTE
		beq $t3, 0, sol_coinc
		slt $t3, $t3, 0
		bne $t3, 0, no_sol
		la $a0, msg_due_sol
		b print
sol_coinc: 
		la $a0, msg_sol_coinc
		b print
no_sol: 
		la $a0, msg_no_sol
1print: 
		li $v0, 4
		syscall
		li $v0, 10
		syscall
		.end main