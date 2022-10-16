		.data
DIM = 3
message_in: .asciiz "Inserire numeri: "
message_out: .asciiz "Media: " 

		.text
		.globl main
		.ent main
main:	
		and $t0, $0, $0
		and $t1, $0, $0
		la $a0, message_in
		li $v0, 4
		syscall
		
for:	
		li $v0, 5 # Read integer
		syscall # system call (risultato in $v0)
		add $t1, $t1, $v0 # incremento accumulatore
		addiu $t0, $t0, 1 # incremento contatore
		bne $t0, DIM, for
		
		la $a0, message_out
		li $v0, 4
		syscall
		
		div $t1, $t1, DIM
		li $v0, 1 # Print integer
		move $a0, $t1 # valore da stampare
		syscall # system call

		li $v0, 10
		syscall
		.end main