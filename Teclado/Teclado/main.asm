/*
* Unifacs - 2019.2
* Washington M Santos
* Engenharia de Computação
* Microcontroladores e Aplicações
* Prática - Iterrupção + Blink duplo
* Professor Euclério
*/

.equ RD7 = PD4
.equ WR6 = PD3
.equ LED1 = PD5


.ORG 0x0000
RJMP setup

setup:
	LDI r16, 0xFF
	OUT DDRD, r16
	LDI r16, 0b00011000

NOP

loop:
	
	/*Set saída*/
	LDI r16, 0xFF
	OUT DDRB, r16
	/***********/

	/*Mando para o teclado a linha que deve ser lida*/
	LDI r16, 0b00001110
	OUT PORTB, r16
	/************************************************/

	SBI PORTD, WR6

	/*Set entrada*/
	LDI r16, 0x00
	OUT DDRB, r16
	/***********/
	CBI PORTD, RD7
RJMP loop

ligar_led:
	CBI PORTD, LED1
	RCALL delay
	JMP loop

/*Configura os pinos da PORTB como entrada*/
setEntrada:
	LDI r16, 0x00
	OUT DDRB, r16

/*Configura os pinos da PORTB como saída*/
setSaida:
	LDI r16, 0xFF
	OUT DDRB, r16

delay:
	LDI r16, 2 /*Escreve o valor 8 em Hexa no registrador r16*/

out_delay:
	LDI r24, low(3037)
	LDI r25, high(3037)

delay_loop:
	ADIW r24,1
	BRNE delay_loop
	DEC r16           /*Decrementa 1 do valor que o registrador r16 tem*/
	BRNE out_delay
	RET
