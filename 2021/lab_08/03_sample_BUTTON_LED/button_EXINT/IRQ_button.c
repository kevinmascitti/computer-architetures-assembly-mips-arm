#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"

uint8_t old1=0;
uint8_t old2=0;
uint8_t current=0;

void EINT0_IRQHandler (void)	  
{
	old1=0;			/* termine precedente al termine corrente */
	old2=0;			/* termine precedente al termine old1 */
	current=1;
	LED_Out(current);
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}

void EINT1_IRQHandler (void)	  
{
	if(current<233){
		int tmp = current;
		current+=old1;
		old2=old1;
		old1=tmp;
	}
  LED_Out(current);
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	if(current>1){
		int tmp = old1;
		current=old1;
		old1=old2;
		old2=tmp-old2;
	}
	LED_Out(current);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}
