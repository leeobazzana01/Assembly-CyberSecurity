#Desenvolver um Algoritmo para realizar a operação: f = (g*h)/(i-j) + k
#Utilizar instruções aritméticas (como add), e de acesso à memória (lw e sw) para manipulação de variáveis em memória. 
.data
	header: .asciiz "Calculando a operação: (g+h) - (i+j)\n"
	g_input: .asciiz "Valor de g: "
	h_input: .asciiz "Valor de h: "
	i_input: .asciiz "Valor de i: "
	j_input: .asciiz "Valor de j: "
	k_input: .asciiz "Valor de K: "
	newline: .asciiz "\n"
	erro_zero: .asciiz "Erro! Não existe Divisão por Zero!"
	resultado: .asciiz "f = "
	
	varg: .word 0
	varh: .word 0
	vari: .word 0
	varj: .word 0
	vark: .word 0
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall

leitura_g_h:
	#solicita g
	li $v0, 4
	la $a0, g_input
	syscall
	
	#$s0 = g
	li $v0, 5
	syscall
	sw $v0, varg

	#solicita h
	li $v0, 4
	la $a0, h_input
	syscall
	
	#$s1 = h
	li $v0, 5
	syscall
	sw $v0, varh

leitura_i_j:
	#solicita i
	li $v0, 4
	la $a0, i_input
	syscall
	
	#$s2 = i
	li $v0, 5
	syscall
	sw $v0, vari

	#solicita j
	li $v0, 4
	la $a0, j_input
	syscall
	
	#$s3 = j
	li $v0, 5
	syscall
	sw $v0, varj	
	
leitura_k:
	#solicita k
	li $v0, 4
	la $a0, k_input
	syscall
	
	#$s4 = k
	li $v0, 5
	syscall
	sw $v0, vark
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall
	
	#OPERAÇÕES ARITMÉTICAS
	lw $t0, varg # g = $t0
	lw $t1, varh # h = $t1
	
	beq $t0, $zero, numerador_zero
	beq $t1, $zero, numerador_zero
	
multiplicacao_numerador:
	mul $t5, $t0, $t1   # g*h = $t5

subtracao_divisor:
	lw $t2, vari # i = $t2
	lw $t3, varj # j = $t3
	sub $t6, $t2, $t3  #i-j = $t6
	
	beq $t6, $zero, erro_divisao_zero
	
divisao_numerador_denominador:
	div $t7, $t5, $t6  #$t7 = $t5/$t6

soma_k_divisao:
	lw $t4, vark # k = $t4
	add $s0, $t7, $t4  #$ t8 = $t7 + k

imprime_f:
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall 
	
encerra_execucao:
	li $v0, 10
	syscall
	
numerador_zero:
	li $t7, 0
	j soma_k_divisao
	
erro_divisao_zero:
	li $v0, 4
	la $a0, erro_zero
	syscall 
	j encerra_execucao