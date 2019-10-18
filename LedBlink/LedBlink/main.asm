/*
* Unifacs
* Washington M Santos
* Engenharia de Computa��o
* Microcontroladores e Aplica��es
* Pr�tica - 01 Led Blink
*/

/*Programa��o feita em Assembly*/
.ORG 0x000			
RJMP setup

setup:
	LDI r16, 0xFF /*Ecrevo o valor de 0xFF no registrador r16 que vai converer para bin�rio*/
	OUT DDRB, r16 /*DDRB faz refer�ncia aos pinos digitais do  Atmega328p*/

loop:
	SBI PortB, 5 /*PortB,5 faz refer�ncia ao pino(porta) 13 do arduino, Set Bit IO coloca o n�vel logito auto na sa�da.*/
	RCALL delay  /*Tempo de espera para a pr�xima instru��o.*/
	CBI PortB, 5 /*PortB,5 faz refer�ncia ao pino(porta) 13 do arduino, Clear Bit IO coloca o n�vel logito baixo na sa�da.*/
	RCALL delay
	RJMP loop

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