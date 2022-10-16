		.data
NUM_ELEM = 20
DIM = 4 * NUM_ELEM
array:	.space NUM_ELEM

		.text
		.globl main
		.ent main
		
main:	and $t0, $0, $0 # contatore
		
		li $t3, 1
		sw $t3, array($t0)
		
		addi $t0, $t0, 4
		li $t3, 1
		sw $t3, array($t0)
		
		
		addi $t0, $t0, 4
loop:	bge $t0, DIM, done
		and $t2, $0, $0 # somma dela costruzione della somma
		and $t3, $0, $0 # registro dove metto la somma totale
		addi $t0, $t0, -4
		lw $t2, array($t0)
		add $t3, $t3, $t2
		
		addi $t0, $t0, -4
		lw $t2, array($t0)
		add $t3, $t3, $t2
		
		addi $t0, $t0, 8
		sw $t3, array($t0)
		addi $t0, $t0, 4
		j loop

done:	li $v0, 10
		syscall
		.end main