		.data
gg:		.byte 1
hh:		.byte 2
mm:		.byte 5
risultato:	.space 4

		.text
		.globl main
		.ent main
main:	
		lbu $t1, gg
		mulou $t0, $t1, 24
		lbu $t1, hh
		addu $t0, $t0, $t1
		mulou $t0, $t1, 60
		lbu $t1, mm
		addu $t0, $t0, $t1
		sw $t0, risultato		

		li $v0, 10
		syscall
		.end main