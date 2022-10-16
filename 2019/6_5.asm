		.data
stringa: .asciiz "introdurre "
		.text
		.globl main
		.ent main
main:	
		li $v0, 4 # print string
		la $a0, stringa
		syscall
		li $v0, 11 # print char
		li $a0, 'n'
		syscall
		li $a0, ':'
		syscall
		li $v0, 5 # read integer
		syscall
		move $t0, $v0
		li $v0, 4 # print string
		la $a0, stringa
		syscall
		li $v0, 11 # print char
		li $a0, 'k'
		syscall
		li $a0, ':'
		syscall
		li $v0, 5 # read integer
		syscall
		
		move $a0, $t0
		move $a1, $v0
		jal combina
		move $t0, $v0
		li $v0, 11 # print char
		li $a0, 'C'
		syscall
		li $a0, '='
		syscall
		move $a0, $t0
		li $v0, 1
		syscall
		li $v0, 10
		syscall
		.end main
		
		
		.ent combina
combina: 
		subu $t1, $a0, $a1 # n-k
		addu $t1, $t1, 1 # n-k+1
		move $v0, $a0
ciclo1: 
		beq $a0, $t1, fine1
		subu $a0, $a0, 1
		mul $v0, $v0, $a0
		j ciclo1
fine1: 
		divu $v0, $v0, $a1
ciclo2: 
		bltu $a1, 2, fine2 # evito divisione per 1
		sub $a1, $a1, 1
		divu $v0, $v0, $a1
		j ciclo2
fine2: 
		jr $ra
		.end combina