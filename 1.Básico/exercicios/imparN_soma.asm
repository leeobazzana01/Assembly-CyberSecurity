#Escreva um programa que calcula a soma dos primeiros N números ímpares (1, 3, 5, ...). 
#O valor de N deve ser lido da memória e o resultado armazenado em outra variável. 
#Use um loop para realizar o cálculo.

.data
	header: .asciiz "Calculando a Soma de N Ímpares\n"
	msg_impar: .asciiz "Número ímpar: "
	impar: .word 0
	newline: .asciiz "\n"
	msg_resultado: .asciiz "Resultado: "
	soma: .word 0
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, msg_impar
	syscall

	li $v0, 5
	syscall
	
	#armazena na memória
	sw $v0, impar
	
	#carrega o valor lido passando como argumento
	la $t0, impar
	lw $a0, 0($t0)
	
	#contador de ímpares
	li $a1, 1
	
	jal soma_impares
	
	move $t2, $v0
	
	li $v0, 10
	la $a0, msg_resultado
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
encerra_execucao: 
	li $v0, 10
	syscall
	
soma_impares:
	#movendo o argumento p uma variável temporária
	move $t1, $a0
	
	#carrega "soma"
	la $t2, soma
	lw $t2, 0($t2)
	
	#somando "soma" ao contador
	add $t2, $t2, $a1
	
	#armazenando na memória
	sw $t2, soma
	
	#incrementando contador
	addi $a1, $a1, 2
	
	#se o contador <= ao ímpar, executa o loop novamente
	ble $a1, $t1, soma_impares
	
	#se o contador não for menor
	move $v0, $a1
	jr $ra
	  

	
	