.data
	header: .asciiz "Calculadora de Binários (até 8 bits)\n"
	msg_numero: .asciiz "Inteiro: "
	msg_operacoes: .asciiz "Operações Disponíveis: \nSoma: (+)\nSubtração: (-)\nMultiplicação: (*)\nDivisão: (/)\n"
	newline: .asciiz "\n"
	vetor_n1: .space 32
	
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
		
	#header
	li $v0, 4
	la $a0, msg_numero
	syscall	
	
	#lendo n1
	li $v0, 5 
	syscall
	
	move $a0, $v0

	jal converte_binario
	
encerra_execucao:
	li $v0, 10
	syscall
	
converte_binario:
	#carregando o contador de loops
	li $t1, 0
	#quantiadade de loops
	li $t2, 7
	
	#a[0] do vetor está em s0
	la $t0, vetor_n1
	lw $s0, 0($t0)

	#numero inteiro está em $t3
	move $t3, $a0
		
	bne $t1, $t2, divisoes_sucessivas
	
	move $v0, 
	jr $ra


divisoes_sucessivas:
	li $t4, 2
	
	div $t3, $t4
	
	mflo $t3
	mf
	
	beq $t1, $t2, converte_binario 	
	
	
	
	
