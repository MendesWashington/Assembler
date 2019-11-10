/*
* Unifacs - 2019.2
* Washington M Santos
* Engenharia de Computação
* Microcontroladores e Aplicações
* Prática - Iterrupção + Blink duplo
* Professor Euclério
*/
.equ RD = PD7
.equ WR = PD6

.equ LED1 = PC0
.equ LED2 = PC1
.equ LED3 = PC2
.equ LED4 = PC3

.ORG 0x0000
RJMP setup
setup:
	LDI r16, 0xFF
	OUT DDRD, r16
	OUT DDRC, r16
	LDI r16, 0x00
	OUT PORTC, r16
	NOP

loop:
	/***********************************************************************/
	RCALL setSaida
	RCALL delay
	LDI r16, 0b00001110
	OUT PORTB, r16
	SBI PORTD, WR
	SBI PORTD, RD
	RCALL delay
	CBI PORTD, WR
	RCALL delay
	SBI PORTD, WR
	CBI PORTD, RD
	RCALL delay
	/*Limpo a saída do registrador*/
	LDI r16, 0X00
	OUT PORTB, r16
	RCALL delay
	RCALL setEntrada
	RCALL delay
	IN r17, PINB
	Linha1:
	RCALL ligar_led1
	RCALL ligar_led2
	RCALL ligar_led3
	RCALL ligar_led4
	RJMP loop
	RCALL delay
	/***********************************************************************/

	/***********************************************************************/
RJMP loop


ligar_led1:
	SBI PORTC, LED1
	SBIS PINB, PB0
	RJMP ligar_led1
	CBI PORTC, LED1
	RET
ligar_led2:
	SBI PORTC, LED2
	SBIS PINB, PB1
	BREQ ligar_led2
	CBI PORTC, LED2
	RET
ligar_led3:
	SBI PORTC, LED3
	SBIS PINB, PB2
	BREQ ligar_led3
	CBI PORTC, LED3
	RET
ligar_led4:
	SBI PORTC, LED4
	SBIS PINB, PB3
	BREQ ligar_led4
	CBI PORTC, LED4
	RET


setSaida:
	LDI r16, 0xFF
	OUT DDRB, r16
	RET

setEntrada:
	LDI r16, 0x00
	OUT DDRB, r16
	RET

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
