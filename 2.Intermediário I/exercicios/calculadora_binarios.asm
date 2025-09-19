.data
	header: .asciiz "Calculadora de Binários (até 8 bits)\n"
	msg_numero: .asciiz "Inteiro: "
	msg_operacoes: .asciiz "Operações Disponíveis: \nSoma: (+)\nSubtração: (-)\nMultiplicação: (*)\nDivisão: (/)\n"
	newline: .asciiz "\n"
	vetor_n1: .space 32
	vetor_n2: .space 32
	
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall

	#operações
	li $v0, 4
	la $a0, msg_operacoes
	syscall
		
	#solicita n[1]
	li $v0, 4
	la $a0, msg_numero
	syscall	
	
	#lendo n1
	li $v0, 5 
	syscall
	
	move $a0, $v0

	jal converte_binario
	move $s0, $v0 #n1 está em $s0
	
		
encerra_execucao:
	li $v0, 10
	syscall
	
converte_binario:
	#contador de execuções 
	li $t0, 0 
	
	#contador total
	li $t1, 7
	
	#onde será colocado o bit do resto
	sub $t3, $t0, $t1
	
	#deslocamento
	la $s2, vetor_n1
	sll $
	
	  
	#divisor
	li $t2, 2
	
	div $a0, $t2 
	
	mfhi 
	mflo $a0 
	
	
	

	
	
	
	
