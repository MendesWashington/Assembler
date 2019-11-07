/*
*
*
*
*
*
*
*/

.equ RD7 = PD4
.equ WR6 = PD3
.equ LED = PD5


.ORG 0x0000
RJMP setup

setup:
	LDI r16, 0xFF
	OUT DDRD, r16
	LDI r16, 0b00011000
NOP

loop:
	CALL setSaida

	Habilita_Linha1:
		LDI r16, 0b00001110
		OUT PORTB, r16
		SBI PORTD, WR6
		CALL setEntrada
		Ler_Linha1:
			CBI PORTD, RD7
			IN r17, PORTB
			SBIC PINB,PB3 | PB2| PB1| PB0
			RJMP Ler_Linha1
			CALL ligar_led
	
	CALL delay
	
	Habilita_Linha2:
		LDI r16, 0b00001101
		OUT PORTB, r16
		SBI PORTD, WR6
		CALL setEntrada
		Ler_Linha2:
			CBI PORTD, RD7
			IN r17, PORTB
			SBIC PINB,PB3 | PB2| PB1| PB0
			RJMP Ler_Linha2
			CALL ligar_led
	
	CALL delay

	Habilita_Linha3:
		LDI r16, 0b00001011
		OUT PORTB, r16
		SBI PORTD, WR6
		CALL setEntrada
		Ler_Linha3:
			CBI PORTD, RD7
			IN r17, PORTB
			SBIC PINB,PB3 | PB2| PB1| PB0
			RJMP Ler_Linha1
			CALL ligar_led

	RCALL delay

	Habilita_Linha4:
		LDI r16, 0b00000111
		OUT PORTB, r16
		SBI PORTD, WR6
		CALL setEntrada
		Ler_Linha4:
			CBI PORTD, RD7
			IN r17, PORTB
			SBIC PINB,PB3 | PB2| PB1| PB0
			RJMP Ler_Linha4
			CALL ligar_led
	CALL delay
RJMP loop

ligar_led:
	SBI PORTD, LED
	SBIS PINB,PB3
	RJMP ligar_led
	CBI PORTD, LED
	JMP ligar_led

/*Configura os pinos da PORTB como entrada*/
setEntrada:
	LDI r16, 0x00
	OUT DDRB, r16
	RJMP Ler_Linha1

/*Configura os pinos da PORTB como saída*/
setSaida:
	LDI r16, 0xFF
	OUT DDRB, r16
RJMP Habilita_Linha1

delay:
	LDI r16, 8 /*Escreve o valor 8 em Hexa no registrador r16*/

out_delay:
	LDI r24, low(3037)
	LDI r25, high(3037)

delay_loop:
	ADIW r24,1
	BRNE delay_loop
	DEC r16           /*Decrementa 1 do valor que o registrador r16 tem*/
	BRNE out_delay
	RET