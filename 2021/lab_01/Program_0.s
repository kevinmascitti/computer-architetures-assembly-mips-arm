		.data
array: 	.word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
		.word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
		.word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
		.word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
		.word16 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f, 5, 0x01a1, 0x2f, 17, 0x2fe0, 1, 0x96a4, 0x2f, 3, 0x2f
num:	.byte 0x2f
result: .space 1
		.text
main:	
		lbu r1, num(r0)		#valore del numero da trovare
		daddui r2, r0, 0	#occorrenze trovate
		daddui r3, r0, 200	#numero tot iterazioni da fare
		daddui r4, r0, 0	#contatore delle iterazioni
for:	
		lbu r5, array(r4)
		bne r1, r5, noocc
occ:	
		daddui r2, r2, 1
noocc: 	
		daddui r4, r4, 1
		bne r3, r4, for
		
		sb r2, result(r0)
		halt