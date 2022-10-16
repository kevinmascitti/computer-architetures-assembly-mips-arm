	.data
v1:	.double 1,0,2,0,2,1,2,2,3,0,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2
v2:	.double 1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2
v3:	.double 1,0,2,3,2,1,2,2,3,2,0,2,1,2,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,2
v4:	.double 1,0,2,3,2,1,2,2,3,2,0,2,1,2,2,1,2,2,3,2,1,3,2,3,2,1,2,2,3,2,1,2,2,3,2,1,2,2,3,1
v5: .space 320		    # 8 byte/double x 40 elementi
v6: .space 320
v7: .space 320

	.text
main:
	daddu r1, r0, r0	#indice             ; FDEMW 5
	daddui r2, r0, 40 	#totale elementi    ;  FDEMW 1
	daddu r10, r0, r0	#byte di colonna    ;   FDEMW 1

for:
	l.d f3, v1(r10)		#   FDEMW 1
	l.d f4, v2(r10)		#    FDEMW 1
	l.d f5, v3(r10)		#     FDEMW 1
	l.d f6, v4(r10)		#      FDEMW 1
    mul.d f7, f4, f5	#       FDmmmmmmmmMW 8
	add.d f9, f3, f7	#        FDsssssssaaaaMW 4
	mul.d f7, f9, f6	#         FsssssssDsssmmmmmmmmMW 8
	div.d f8, f7, f4	#                 FDssssssssssddddddddddddMW 12
    daddui r1, r1, 1    #                  FssssssssssDEMW 0
    s.d f9, v5(r10)     #                             FDEMW 0
    s.d f7, v6(r10)     #                              FDEMW 0
	s.d f8, v7(r10)		#                               FDEsssssssSMW 1
    daddui r10, r10, 8  #                                FDssssssssEMW 1
	bne r1, r2, for     #                                 FssssssssDEMW 1
                        #                                          F---- 1 (ultimo ciclo: FDEMW)
	halt                #                                           FDEMW 1
#   tot=5+1+1+1600+1=1608
