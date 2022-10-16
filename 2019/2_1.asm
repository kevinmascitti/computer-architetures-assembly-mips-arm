			.data
msg:		.asciiz "Inserisci un numero: "
msgpari:	.asciiz "Il numero inserito è pari."
msgdispari:	.asciiz "Il numero inserito è dispari."

			.text
			.globl main
			.ent main
main:		la $a0, msg
			li $v0, 4
			syscall
			li $v0, 5
			syscall
			move $t0, $v0
			
			andi $t0, $t0, 1
			beq $t0, $0, pari
			
			la $a0, msgdispari
			li $v0, 4
			syscall
			j end

pari:		la $a0, msgpari
			li $v0, 4
			syscall
			
end:		li $v0, 10
			syscall
			.end main