/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           lib_timer.h
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        atomic functions to be used by higher sw levels
** Correlated files:    lib_timer.c, funct_timer.c, IRQ_timer.c
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"

/******************************************************************************
** Function name:		enable_timer
**
** Descriptions:		Enable timer
**
** parameters:			timer number: 0, 1, 2, 3
** Returned value:		None
**
******************************************************************************/
void enable_timer( uint8_t timer_num )
{
	if ( timer_num == 0 )
  {
		LPC_TIM0->TCR = 1;
  }
  else if(timer_num == 1)
  {
		LPC_TIM1->TCR = 1;
  }
	else if(timer_num == 2)
  {
		LPC_TIM2->TCR = 1;
  }
	else if(timer_num == 3)
  {
		LPC_TIM3->TCR = 1;
  }
  return;
}

/******************************************************************************
** Function name:		disable_timer
**
** Descriptions:		Disable timer
**
** parameters:			timer number: 0, 1, 2, 3
** Returned value:		None
**
******************************************************************************/
void disable_timer( uint8_t timer_num )
{
  if ( timer_num == 0 )
  {
		LPC_TIM0->TCR = 0;
  }
  else if(timer_num == 1)
  {
		LPC_TIM1->TCR = 0;
  }
	else if(timer_num == 2)
  {
		LPC_TIM2->TCR = 0;
  }
	else if(timer_num == 3)
  {
		LPC_TIM3->TCR = 0;
  }
  return;
}

/******************************************************************************
** Function name:		reset_timer
**
** Descriptions:		Reset timer
**
** parameters:			timer number: 0, 1, 2, 3
** Returned value:		None
**
******************************************************************************/
void reset_timer( uint8_t timer_num )
{
  uint32_t regVal;

  if ( timer_num == 0 )
  {
		regVal = LPC_TIM0->TCR;
		regVal |= 0x02;
		LPC_TIM0->TCR = regVal;
  }
  else if (timer_num == 1)
  {
		regVal = LPC_TIM1->TCR;
		regVal |= 0x02;
		LPC_TIM1->TCR = regVal;
  }
	else if (timer_num == 2)
  {
		regVal = LPC_TIM2->TCR;
		regVal |= 0x02;
		LPC_TIM2->TCR = regVal;
  }
	else if (timer_num == 3)
  {
		regVal = LPC_TIM3->TCR;
		regVal |= 0x02;
		LPC_TIM3->TCR = regVal;
  }
  return;
}

uint32_t init_timer2(uint8_t MatchReg, uint8_t matchOptions, uint32_t TimerInterval){
	if(MatchReg == 0)
	{
		LPC_TIM2->MR0 = TimerInterval;
	}
	else if(MatchReg == 1)
	{
		LPC_TIM2->MR1 = TimerInterval;
	}	
	else if(MatchReg == 2)
	{
		LPC_TIM2->MR2 = TimerInterval;
	}		
	else if(MatchReg == 3)
	{
		LPC_TIM2->MR3 = TimerInterval;
	}			

	LPC_TIM2->MCR |= matchOptions << 3*MatchReg ;
	NVIC_EnableIRQ(TIMER2_IRQn);
	NVIC_SetPriority(TIMER2_IRQn, 0);
	return (1);
}
/******************************************************************************
**                            End Of File
******************************************************************************/
