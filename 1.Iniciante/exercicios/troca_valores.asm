#Carregue 100 em $s0. Use $zero para mover o valor de $s0 para $s1
.data
	newline: .asciiz "\n" 
	mensagem: .asciiz "Trocando Valores de um registrador para o outro\n"
	msg_inicial: .asciiz "Valor inicial de $s0: "
	msg_final: .asciiz "Valor final de $s0: "
	msg_s1: .asciiz "Valor de $s1: "
.text
.globl main
main:
	#armazena 100 em s0
	li $s0, 100
	
	#cabeçalho
	li $v0, 4
	la $a0, mensagem
	syscall
	
	#msg valor inicial $s0
	li $v0, 4
	la $a0, msg_inicial
	syscall
	
	#$s0
	li $v0, 1
	move $a0, $s0
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall
	
	add $s1, $zero, $s0 #$s1 = $zero + $s0
	sub $s0, $zero, $zero #$s0 = $zero - $zero #isso irá fazer com que $s0 seja igual a zero
	
	#msg valor $s1
	li $v0, 4
	la $a0, msg_s1
	syscall
	
	#$s1
	li $v0, 1
	move $a0, $s1
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall	  
	
	#msg valor final $s0
	li $v0, 4
	la $a0, msg_final
	syscall
	
	#$s0
	li $v0, 1
	move $a0, $s0
	syscall
	
	#encerrando execução 
	li $v0, 10
	syscall

  
	
	  
	
	
	
	