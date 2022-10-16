	.data
i:	.double 1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2
w:	.double 1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2,1.1,2.1,0.3,1.4,3.2
b:	.double 0xab
mask: .word16 0x7ff
y:	.space 8

	.text
main:
	dadd r1, r0, r0 		#indice
	daddui r2, r0, 30 		#K
	daddui r10, r0, 0		#byte di colonna
	l.d f6, b(r0)
for:
	l.d f3, i(r10)
	l.d f4, i(r10)
	mul.d f5, f3, f4
	add.d f6, f6, f5
	daddui r1, r1, 1
	daddui r10, r10, 8
	bne r1, r2, for
	
	mfc1 r6, f6
	lh r7, mask(r0)
	dsll r7, r7, 26
	dsll r7, r7, 26
	
	and r6, r7, r6
	bne r6, r7, end
	add.d f6, f0, f0		#zero se esponente ha tutti 1
	
end:	
	s.d f6, y(r0)
	halt
	
	
