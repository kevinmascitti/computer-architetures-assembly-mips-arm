		.data
a:	 .byte 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -2 #sum = 3
b:	 .byte 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -5, 5, 2, 1, -2, -1, -7 #sum = -2
c:	 .space 30
treshold_low:	.byte 1
treshold_high:	.byte 1
max:			.byte 1
min:			.byte 1

		.text
main:	
		daddu r1, r0, r0	# contatore
		daddui r2, r0, 30	# totale iterazioni
		dadd r10, r0, r0	# num magggiori della soglia
		dadd r11, r0, r0	# num minori della soglia
		dadd r7, r0, r0		# min
		dadd r8, r0, r0		# max
		dadd r12, r0, r0
		daddui r6, r0, 0	# soglia

somma:	
		lb r3, a(r1)
		lb r4, b(r1)
		dadd r5, r3, r4
		sb r5, c(r1)
		
		slt r12, r5, r7
		bnez r12, aggiornaMin
		slt r12, r8, r5
		bnez r12, aggiornaMax
		j then
aggiornaMin:
		dadd r7, r5, r0
		j then
aggiornaMax:
		dadd r8, r5, r0
		
		dadd r12, r0, r0
then:	slt r12, r5, r6
		bnez r12, low
		daddui r11, r11, 1	# +1 ai sup della soglia
		j next
low:	daddui r10, r10, 1	# +1 ai min della soglia

next:	daddui r1, r1, 1
		bne r1, r2, somma
		sb r10, treshold_low(r0)
		sb r11, treshold_high(r0)
		sb r7, min(r0)
		sb r8, max(r0)
		halt