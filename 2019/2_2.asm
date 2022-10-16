			.data
msg:		.asciiz "Inserisci un numero: "
res:		.asciiz "Il risultato è: "
err_mess: 	.asciiz "Introdurre valori compresi tra -127 e 128" # 1byte -> 2^7 numeri

			.text
			.globl main
			.ent main
main:		#FASE 1
			#Voglio verificare se un numero è su 8 bit
			#Verifico che gli ultimi 8 bit siano numeri
			#E i primi bit più significativi sono a 0
			#USO LA MASCHERA 0xFFFFFF00
			#Ovvero 1(24 volte) 0(8 volte). 0xf=1111
			li $t3, 0xFFFFFF00
			
			la $a0, msg
			li $v0, 4
			syscall
			li $v0, 5
			syscall
			and $t1, $v0, $t3
			bne $t1, 0, errore
			move $t0, $v0
			
			la $a0, msg
			li $v0, 4
			syscall
			li $v0, 5
			syscall
			and $t1, $v0, $t3
			bne $t1, 0, errore
			move $t1, $v0
			
			#FASE 2
			#Dato C su 32 bit devo azzerarne i 24 bit più significativi
			#Facendo and con 0(24 volte) 1(8 volte)
			not $t3, $t1 # not B
			and $t3, $t0, $t3 # A and (not B)
			not $t3, $t3 # not (A and (not B))
			xor $t0, $t0, $t1 # A xor B
			or $t0, $t0, $t3 # not (A and (not B)) or (A xor B)
			
			li $t1, 0x000000FF # azzeramento della parte più significativa
			and $t0, $t0, $t1 # del risultato prima della stampa
			move $a0, $t0
			li $v0, 1
			syscall

			j end
			
errore: 	la $a0, err_mess
			li $v0, 4
			syscall
			
end:		li $v0, 10
			syscall
			.end main