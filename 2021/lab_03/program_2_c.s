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
	daddu r1, r0, r0	#indice                 5
	daddui r2, r0, 40 	#totale elementi        1
	daddu r10, r0, r0	#byte di colonna        1

for:
    l.d f3, v1(r10)     #       FDEMW 1
    l.d f4, v2(r10)     #        FDEMW 1
    l.d f5, v3(r10)     #         FDEMW 1
    l.d f6, v4(r10)     #          FDEMW 1
    mul.d f7, f4, f5    #           FDmmmmmmmmMW 8
    daddui r11, r10, 8  #            FDEMW 0
        l.d f1, v1(r11)     #         FDEMW 0
        l.d f2, v2(r11)     #          FDEMW 0
        l.d f10, v3(r11)     #          FDEMW 0
        l.d f11, v4(r11)     #           FDEMW 0
        mul.d f12, f2, f10    #           FDsssmmmmmmmmMW 8
        daddui r12, r11, 8  #              FsssDEMW 0
            l.d f15, v1(r12)     #          FssDEMW 0
            l.d f16, v2(r12)     #           FsDEMW 0
            l.d f17, v3(r12)     #             FDEMW 0
            l.d f18, v4(r12)     #              FDEMW 0
            mul.d f19, f16, f17    #             FDsssssmmmmmmmmMW 8
            daddui r13, r12, 8  #                 FsssssDEMW 0
                l.d f22, v1(r13)     #                  FDEMW 0
                l.d f23, v2(r13)     #                   FDEMW 0
                l.d f24, v3(r13)     #                    FDEMW 0
                l.d f25, v4(r13)     #                     FDEMW 0
                mul.d f26, f23, f24    #                    FDsssmmmmmmmmMW 8
    add.d f9, f3, f7    #                                    FsssDaaaaMW 0
    daddui r1, r1, 1    #                                        FDEMW 0
        add.d f14, f1, f12    #                                  FDsssaaaaMW 1
        daddui r1, r1, 1    #                                     FsssDEMW 0
            add.d f21, f15, f19    #                              FsssDsssaaaaMW 4
            daddui r1, r1, 1    #                                     FsssDEMW 0
                add.d f28, f22, f26    #                                  FDssaaaaMW 4
                daddui r1, r1, 1    #                                      FssDEMW 0
    mul.d f7, f9, f6    #                                                     FDmmmmmmmmMW 6
        mul.d f12, f14, f11    #                                               FDsssssssmmmmmmmmMW 8
            mul.d f19, f21, f18    #                                            FsssssssDsssssssmmmmmmmmMW 8
                mul.d f26, f28, f25    #                                                FDssssssssssssssmmmmmmmmMW 8
    div.d f8, f7, f4    #                                                                FssssssssssssssDddddddddddddMW 5
    s.d f9, v5(r10)     #                                                                               FDEMW 0
    s.d f7, v6(r10)     #                                                                                FDEMW 0
        div.d f13, f12, f2    #                                                                           FDsssssssssddddddddddddMW 12
        s.d f14, v5(r11)     #                                                                             FsssssssssDEMW 0
        s.d f12, v6(r11)     #                                                                                       FDEMW 0
            div.d f20, f19, f16    #                                                                                  FDsssssssssddddddddddddMW 12
            s.d f21, v5(r12)     #                                                                                     FsssssssssDEMW 0
            s.d f19, v6(r12)     #                                                                                               FDEMW 0
                div.d f27, f26, f23    #                                                                                          FDsssssssssddddddddddddMW12
                s.d f28, v5(r13)     #                                                                                             FsssssssssDEMW 0
                s.d f26, v6(r13)     #                                                                                                       FDEMW 0
    s.d f8, v7(r10)     #                                                                                                                     FDEMW 0
        s.d f13, v7(r11)     #                                                                                                                 FDEMW 0
            s.d f20, v7(r12)     #                                                                                                              FDEMW 0
               s.d f27, v7(r13)     #                                                                                                           FDEsssssSMW 2
             
	bne r1, r2, for     #                                                                                                                        FDssssssEMW1
    daddui r10, r13, 8  #                                                                                                                        FssssssDEMW1

	halt                #                               1
# 5+1+1+(4+32+1+4+4+6+8+8+8+5+12+12+12+2+1+1)*10+1=1208
