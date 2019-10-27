/*
* Unifacs - 2019.2
* Washington M Santos
* Engenharia de Computação
* Microcontroladores e Aplicações
* Prática - Iterrupção + Blink duplo
* Professor Euclério
*/
.org 0x0000
rjmp setup
.org 0x0004
rjmp EXT_INT1

setup:
/*===========================Configurações de Interrupção================================*/
	LDI r16, HIGH(RAMEND)
	OUT SPH, r16
	LDI r16, LOW(RAMEND)
	OUT SPL, r16
/*===========================Configurações de Interrupção================================*/
	SEI					
	LDI r16, 0b00000011
	OUT EIMSK, r16
	LDI r16, 0b00000000
	STS EICRA, r16
/*===========================Configurações dO LED================================*/
	LDI r16, 0xff
	OUT DDRB, r16
/*===========================Configurações d0 BOTÂO================================*/
	LDI r16, 0x00
	OUT DDRD, r16
	LDI r16, 0xff
	OUT PortD, r16
	NOP


loop:
	SBI PortB, PB5
	RCALL delay
	CBI PortB, PB5
	RCALL delay
RJMP loop

/*===========================Instrução de Interrupção================================*/
EXT_INT1:
	SBI PortB, PB0
	RCALL delay
	CBI PortB, PB0
	RCALL delay
	RETI

delay:
	LDI r16, 16
out_delay:
	LDI r24, low(3037)
	LDI r25, high(3037)
delay_loop:
	ADIW r24,1
	BRNE delay_loop
	DEC r16
	BRNE out_delay
	RET
