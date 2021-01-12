RCC_BASE           EQU     0x40023800
AHB1ENR_OFFSET     EQU     0x1C
RCC_AHB1ENR        EQU     RCC_BASE + AHB1ENR_OFFSET
	
GPIOA_BASE		   EQU     0x40020000
GPIOA_MODER_OFFSET EQU	   0x00
GPIOA_MODER		   EQU     GPIOA_BASE + GPIOA_MODER_OFFSET

GPIOA_ODR_OFFSET   EQU     0x14
GPIOA_ODR		   EQU     GPIOA_BASE + GPIOA_ODR_OFFSET
	
GPIOA_EN           EQU     1<<0
MODER5_OUT		   EQU	   1<<10
LED_ON             EQU     1<<5
	
	
			AREA  |.text|,CODE,READONLY,ALIGN=2
			THUMB
			ENTRY
			EXPORT __main
				
__main
			BL GPIOA_Init
			
loop
			B loop
			
GPIOA_Init 
			
			; Enabling GPIOA 
			LDR R0,=RCC_AHB1ENR
			LDR R1,[R0]
			ORR R1,#GPIOA_EN
			STR R1,[R0]
			
			; Set PIN 5 of GPIOA to general output mode
			LDR R0,=GPIOA_MODER
			LDR R1,[R0]
			ORR R1,#MODER5_OUT
			STR R1,[R0]	

			; turn the LED on 
			LDR R0,=GPIOA_ODR
			LDR R1,[R0]
			ORR R1,#LED_ON
			STR R1,[R0]				
			
			BX LR
			
			ALIGN
			END