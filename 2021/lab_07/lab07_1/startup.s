;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF
					
				AREA ROM, DATA, READONLY
Sector_prices 	DCD 0x01, 25, 0x02, 40, 0x03, 55, 0x04, 65, 0x05, 80, 0x06, 110
Sector_quantity DCD 0x02, 250, 0x05, 250, 0x03, 550, 0x01, 150, 0x04, 100, 0x06, 200
Num_sectors		DCB 6
Tickets 		DCD 0x05, 2, 0x03, 10, 0x01, 120
Ticket_requests DCD 3
				AREA RAM, DATA, READWRITE
updated_quantity SPACE 4*12
total_tickets	 SPACE 4

                AREA    |.text|, CODE, READONLY
; Reset Handler
Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]                                            
                LDR     R0, =Reset_Handler
				
				; your code here
				LDR r0, =Sector_prices
				LDR r2, =Tickets
				LDR r3, =total_tickets
				LDR r4, =Num_sectors		; tot i
				ldr r10, [r4]
				mov r11, #4
				mul r4, r10, r11
				LDR r5, =Ticket_requests	; tot j
				ldr r10, [r5]
				mul r5, r10, r11
				MOV r6, #0	;i su tickets
				LDR r10, =updated_quantity
				
				mov r8, r2		; TICKET
forTickets		
				LDR r1, =Sector_quantity
				MOV r7, #0		;j su sector_quantity, sector_prices e updated_quantity
				mov r9, r1		; QUANTITY
forSectorQuantity
				cmp r8, r9		; r8 e r9 sono gli id del settore corrente nei vettori
				bne nextSectorQuantity
				add r6, r6, #4			; INDICE SU TICKET
				add r7, r7, #4			; INDICE SU QUANTITY
				str r8, [r10]			; SECTOR ID SALVATO IN UPDATED QUANTITY
				ldr r8, [r1, r7]		; QUANTITY indirizzo della cella di memoria successiva all'id del settore
				ldr r9, [r2, r6]		; NUM REQUESTED SU TICKET
				sub r6, r6, #4
				cmp r8, r9
				blt notAvailable
				sub r8, r8, r9
				str r8, [r10, #4]!		; MEMORIZZO QUANTITY AGGIORNATO
				add r10, r10, #4
				
				; FIN QUI OK e posso liberare sector_quantity, j e sector_quantity[j] che poi riinizializzo: r1, r7, r8
				sub r6, r6, #4		; sottraggo per prendere l'id del settore
				ldr r1, [r2, r6]	; carico il sector id richiesto
				add r6, r6, #4		; sommo per tornare alla quantity richiesta
				mov r7, #0			; k su sector_prices
forSectorPrices
				ldr r8, [r0, r7]	; carico il sector id k-esimo del vettore prices per trovare quello uguale a quello richiesto
				cmp r1, r8
				bne nextSectorPrice
				; posso liberare sector_prices[k] e tickets[i-4] perché contengono l'id del settore già confrontato: r1, r8
				add r6, r6, #4
				ldr r1, [r2, r6]	; numero di biglietti richiesti
				sub r6, r6, #4		; tolgo 4 di nuovo perché l'aggiornamento della posizione nel vettore è fatto da nextTicket facendo +8
				add r7, r7,#4
				ldr r8, [r0, r7]	; price del settore
				sub r7, r7, #4		; tolgo 4 di nuovo perché l'aggiornamento della posizione nel vettore è fatto da nextSectorPrices facendo +8
				cmp r1, #10	
				mul r8, r8, r1		; price*num biglietti richiesti
				lsrgt r8, r8, #1	; se è maggiore di 10 faccio lo sconto (divido per due)
				add r3, r3, r8		; aggiorno total_tickets che salverò nella RAM solo dopo aver analizzato tutti i ticket richiesti
				
nextSectorPrice
				add r7, r7, #8
				cmp r7, r4
				bne forSectorPrices
				beq nextTicket		; non succede ma se succede next ticket
				
notAvailable
				mov r11, #0x01
				str r1, [r10, #4]!	; SALVO LA QUANTITY ORIGINALE PERCHE NON CI SONO POSTI
				add r10, r10, #4
				b nextTicket
				
nextSectorQuantity
				add r7, r7, #8
				ldr r9, [r1, r7]	; in r1 c'è la sector quantity
				cmp r7, r4
				bne forSectorQuantity
				beq nextTicket		; se non trovo il settore desiderato non faccio nulla e vado al prossimo ticket
				
nextTicket
				add r6, r6, #8		; aggiungo 8 per andare al prossimo settore richiesto, considerando che ho tolto 4 dopo aver preso la quantity richiesta
				ldr r8, [r2, r6]
				mov r7, #0
				cmp r6, r5
				bne forTickets
				
				ldr r0, =total_tickets
				str r3, [r0]
				
                BX      R0
                ENDP



; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit                

                END
