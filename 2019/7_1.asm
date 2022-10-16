		.data
		.text
		.globl main
		.ent main
main: 	
		subu $sp, 4
		sw $ra, ($sp)
		
		#inizializzazioni
		li $t0, 4
		li $t1, 2
		li $t2, -5
		li $t3, 3
		li $s0, 8
		li $s1, 4
		li $s2, 27
		li $s3, 9
		li $s4, 64
		li $s5, 16
		
		# passaggio dei primi 4 parametri in $a
		add $a0, $t0, $t1
		add $a0, $a0, $t2
		add $a0, $a0, $t3
		
		mul $t4, $t0, $s0
		mul $t5, $t1, $s1
		mul $t6, $t2, 2
		add $a1, $t4, $t5
		add $a1, $a1, $t6
		add $a1, $a1, $t3
		
		mul $t4, $t0, $s2
		mul $t5, $t1, $s3
		mul $t6, $t2, 3
		add $a2, $t4, $t5
		add $a2, $a2, $t6
		add $a2, $a2, $t3
		
		mul $t4, $t0, $s4
		mul $t5, $t1, $s5
		mul $t6, $t2, 4
		add $a3, $t4, $t5
		add $a3, $a3, $t6
		add $a3, $a3, $t3
		
		# salvataggio dei registri $t - push in stack (parte superiore)
		subu $sp, 16
		sw $t0, ($sp)
		sw $t1, 4($sp)
		sw $t2, 8($sp)
		sw $t3, 12($sp)
		
		# passaggio del quinto parametro - push in stack (parte inferiore)
		subu $sp, 4
		li $t0, 10
		sw $t0, ($sp)
		
		jal polinomio
		
		lw $t0, 4($sp)
		lw $t1, 8($sp)
		lw $t2, 12($sp)
		lw $t3, 16($sp)
		addiu $sp, 20
		lw $ra, ($sp)
		addiu $sp, 4
		jr $ra
		.end main
		
		
		.ent polinomio
polinomio: 
		subu $fp, $sp, 4 	# usare $fp permette di avere un riferimento
							# costante ai parametri ricevuti dal main
		subu $sp, 12
		sw $s0, ($sp)		# salvataggio registri $s
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sub $t0, $a1, $a0
		sub $t1, $a2, $a1
		sub $t2, $a3, $a2
		sub $s0, $t1, $t0
		sub $s1, $t2, $t1
		sub $s2, $s1, $s0
		move $v0, $a3
		lw $t3, 4($fp) 		# prelievo dati da stack
		sub $t3, 4
ciclo: 
		ble $t3, 0, fine
		add $s1, $s1, $s2
		add $t2, $t2, $s1
		add $v0, $v0, $t2
		sub $t3, $t3, 1
		j ciclo
fine: 
		lw $s0, ($sp) 		# ripristino registri $s
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		addiu $sp, 12
		jr $ra
		.end polinomio
