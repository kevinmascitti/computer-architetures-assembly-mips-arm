ciclo1: li $v0, 12 # legge 1 char
		syscall # system call (risultato in $v0)
		sb $v0, ($t0)
		add $t1, $t1, 1
		add $t0, $t0, 1
		bne $t1, 5, ciclo1 # itera 5 volte
		la $t0, wVet
		li $t1, 0 # contatore
		lb $t2, ($t0) # in $t2 memorizzo MIN iniziale
ciclo2: lb $t3, ($t0)
		bgt $t3, $t2, salta # salta se NON deve aggiornare MIN
							# BRANCH IF GREATER THAN
		lb $t2, ($t0) # aggiorna MIN
salta:	add $t1, $t1, 1
		add $t0, $t0, 1
		bne $t1, 5, ciclo2
		la $a0, message_out
		li $v0, 4
		syscall
		li $v0, 11 # stampa 1 char
		move $a0, $t2
		syscall
		li $v0, 10
		syscall
		.end main