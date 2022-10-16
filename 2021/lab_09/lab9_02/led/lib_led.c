/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           timer.h
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        Atomic led init functions
** Correlated files:    lib_timer.c, funct_timer.c, IRQ_timer.c
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/

#include "lpc17xx.h"
#include "led.h"
#include "../timer/timer.h"
/*----------------------------------------------------------------------------
  Function that initializes LEDs and switch them off
 *----------------------------------------------------------------------------*/

volatile unsigned char led_value;

void LED_init(void) {

  LPC_PINCON->PINSEL4 &= 0xFFFF0000;	//PIN mode GPIO (00b value per P2.0 to P2.7)
	LPC_GPIO2->FIODIR   |= 0x000000FF;  //P2.0...P2.7 Output (LEDs on PORT2 defined as Output)
  /* LPC_GPIO2->FIOSET    = 0x000000FF;	//all LEDs on */
	LPC_GPIO2->FIOCLR    = 0x000000FF;  //all LEDs off
	
	led_value = 0;
}

void LED_deinit(void) {

  LPC_GPIO2->FIODIR &= 0xFFFFFF00;  //P2.0...P2.7 Output LEDs on PORT2 defined as Output
}

/*----------------------------------------------------------------------------
  Modifica i parametri per variare la luinosità dei led
 *----------------------------------------------------------------------------*/
void TuneBrightness(unsigned int percentage){
	int regM0=0;
	int regM1=0;
	if(percentage==25){
		regM0=0x2710;	/*count=0.4ms*25Mhz=10000 -> 0x2710*/
		regM1=0x9C40;	/*count=1.6ms*25Mhz=40000 -> 0x9C40*/
	}
	else if(percentage==50){
		regM0=0x4E20;	/*count=0.8ms*25Mhz=20000 -> 0x4E20*/
		regM1=0x9C40;	/*count=1.6ms*25Mhz=40000 -> 0x9C40*/
	}
	else if(percentage==75){
		regM0=0x7530;	/*count=1.2ms*25Mhz=30000 -> 0x7530*/
		regM1=0x9C40;	/*count=1.6ms*25Mhz=40000 -> 0x9C40*/
	}
	else if(percentage==100){
		regM0=0x9C40;	/*count=1.6ms*25Mhz=40000 -> 0x9C40*/
		regM1=0x9C40;	/*count=1.6ms*25Mhz=40000 -> 0x9C40*/
	}
	disable_timer(2);
	LED_On(0);	//serve per il confronto
	LED_On(1);
	init_timer2(0, 1, regM0); /*only interrupt*/	
	init_timer2(1, 3, regM1);	/*interrupt + reset*/
	enable_timer(2);
}
