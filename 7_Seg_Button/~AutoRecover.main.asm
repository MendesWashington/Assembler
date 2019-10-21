;
/*
* Unifacs
* Washington M Santos
* Engenharia de Computa��o
* Microcontroladores e Aplica��es
* Pr�tica - 03 7 Segmentos com push Botton
*/

.ORG 0X000
RJMP setup

setup:
	LDI r16, 0xFE   //Inicia o registrador com o valor 0b11111110 (1 sa�da, 0 entrada)
	OUT DDRB, r16	//Configura��o de toda PortB
	LDI r16, 0xFF	//Inicia o registrador com o valor 0b11111111
	OUT PortB, r16	//Ativa o pull-upp
	OUT DDRD, r16	//Configura o PortD como sa�da.
	LDI r16, 0x00	//Inicia o registrador com o valor 0b00000000
	OUT PortD, r16	//Desliga todas as sa�das.
	 

	 STS UCSR0B, R1

loop:
