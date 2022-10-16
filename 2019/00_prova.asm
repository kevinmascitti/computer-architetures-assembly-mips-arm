	.data
	#dichiarazione dei dati
op1: .byte 3
op2: .byte 2
res: .space 1 #perché è solo una variabile
	
	.text
	#codice
	.globl main
	.ent main
main:	# res = op1 + op2
	#SBAGLIATO add res, op1, op2
	lb $t1, op1
	lb $t2, op2
	add $t1, $t1, $t2
	sb $t1, res
	
	li $v0, 10
	syscall
	.end main
	
	#Su QtSpim 8 cifre esadecimali sono 4 byte
	#indirizzo successivo inizia 4 posizioni dopo
	#prima del main qtspim esegue istruzioni sue
	#load upper integer lui 4097 in dec = 0x10010000 in hex
	#copia nella parte superiore del registro quindi 1001 0000: indirizzo a cui è salvato la variabile op1
	#registro $9 = $t1
	#