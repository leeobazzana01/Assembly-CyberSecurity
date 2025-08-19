.data
	n1: .word 25
	n2: .word 2
	msg_soma: .asciiz "Valor da Soma: \n"
	msg_subt: .asciiz "\nValor da Subtração: "
	
.text
.globl main
main:
	la $t0, n1 #carrego o endereço de n1 para $t0 
	lw $s0, 0($t0) #carrego o valor inteiro do endereço $t0 para a posição 0 e registrador $s0
	la $t1, n2 #carrego o endereço de n2 para $t1
	lw $s1, 0($t1) #carrego o valor inteiro do endereço $t1 para a posição 4 e registrador $s1
	
	add $s2, $s0, $s1 #$s2 = $s0 + $s1 
	sub $s3, $s0, $s1 #$s3 = $s0 - $s1
	
	#imprimindo mensagem de soma
	li $v0, 4
	la $a0, msg_soma
	syscall 
	
	#imprimindo valor da soma
	li $v0, 1
	move $a0, $s2  
	syscall
	
	#imprimindo mensagem de subtração
	li $v0, 4
	la $a0, msg_subt 
	syscall 
	
	#imprimindo valor da subtracao
	li $v0, 1
	move $a0, $s3 #carrego para o argumento $a0 o valor armazenado em $s3
	syscall
	
	#encerrando execução 
	li $v0, 10
	syscall


