/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_RIT.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    RIT.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "RIT.h"
#include "../led/led.h"

uint8_t old_value=0;
uint8_t current_value=1;

void IncrementSeries(void){
	int tmp;
	if(current_value<233){
		tmp=old_value;
		old_value=current_value;
		current_value+=tmp;
		LED_Out(current_value);
	}
	return;
}

void DecrementSeries(void){
	int tmp;
	if(current_value>1){
		tmp=old_value;
		old_value=current_value-tmp;
		current_value=tmp;
		LED_Out(current_value);
	}
	return;
}


/******************************************************************************
** Function name:		RIT_IRQHandler
**
** Descriptions:		REPETITIVE INTERRUPT TIMER handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void RIT_IRQHandler (void)
{			
	static int down=0;	
	down++;
	if((LPC_GPIO2->FIOPIN & (1<<11)) == 0){
		reset_RIT();
		switch(down){
			case 1:
				IncrementSeries();
				break;
			default:
				break;
		}
	}
	else if((LPC_GPIO2->FIOPIN & (1<<12)) == 0){
		reset_RIT();
		switch(down){
			case 1:
				DecrementSeries();
				break;
			default:
				break;
		}
	}
	else {	/* button released */
		down=0;			
		disable_RIT();
		reset_RIT();
		NVIC_EnableIRQ(EINT1_IRQn);							 /* enable Button interrupts			*/
		NVIC_EnableIRQ(EINT2_IRQn);
		LPC_PINCON->PINSEL4    |= (1 << 22);     /* External interrupt 0 pin selection */
		LPC_PINCON->PINSEL4    |= (1 << 24);     /* External interrupt 1 pin selection */
	}
	
  LPC_RIT->RICTRL |= 0x1;	/* clear interrupt flag */
	
  return;
}

void force_reset(void){
	old_value=0;
	current_value=1;
	LED_Out(1);
}

/******************************************************************************
**                            End Of File
******************************************************************************/
