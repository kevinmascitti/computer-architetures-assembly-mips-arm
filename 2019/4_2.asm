		.data
opa: 	.word 2043
opb:	.word 5
res: 	.space 4
msg:	.asciiz "Insersci un numero tra 0 e 3 (inclusi):	"
JumpTable:
		.word somma, sottrazione, moltiplicazione, divisione

		.text
		.globl main
		.ent main
		
main:	la $s0, opa
		la $s1, opb

		la $t0, JumpTable
		li $v0, 4
		la $a0, msg
		syscall
		li $v0, 5
		syscall
		blt $v0, 0, end
		bgt $v0, 3, end
		
		move $t1, $v0
		sll $t1, $t1, 2
		lw $t0, JumpTable($t1)
		jr $t0
		
somma:	
		add $t2, $s0, $s1
		j ok
sottrazione:	
		sub $t2, $s0, $s1
		j ok
moltiplicazione:	
		mul $t2, $s0, $s1
		j ok
divisione:	
		div $t2, $s0, $s1
		
ok:		sw $t2, res
		li $v0, 1
		la $a0, res
		syscall

end:	li $v0, 10
		syscall
		.end main