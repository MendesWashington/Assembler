/*
* Unifacs
* Washington M Santos
* Engenharia de Computação
* Microcontroladores e Aplicações
* Prática - 01 Led Blink
*/

/*Programação feita em Assembly*/
.ORG 0x000			
RJMP setup

setup:
	LDI r16, 0xFF /*Ecrevo o valor de 0xFF no registrador r16 que vai converer para binário*/
	OUT DDRB, r16 /*DDRB faz referência aos pinos digitais do  Atmega328p*/

loop:
	SBI PortB, 5 /*PortB,5 faz referência ao pino(porta) 13 do arduino, Set Bit IO coloca o nível logito auto na saída.*/
	RCALL delay  /*Tempo de espera para a próxima instrução.*/
	CBI PortB, 5 /*PortB,5 faz referência ao pino(porta) 13 do arduino, Clear Bit IO coloca o nível logito baixo na saída.*/
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