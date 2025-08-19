.data 
	header: .asciiz "Adding two integers\n"
	msg_entrada: .asciiz "Type a Integer: \n" 
	msg_resultado: .asciiz "Result: \n"
	n1: .word 0 
	n2: .word 0
.text
.globl main
main:
	#LENDO E ARMAZENANDO AS VARIÁVEIS
	#imprime o cabeçalho do programa
	li $v0, 4 #instrução 4 imprime string
	la $a0, header
	syscall
	
	#solicita inteiro
	li $v0, 4
	la $a0, msg_entrada
	syscall
	
	#lê o inteiro com a insttução 5
	li $v0, 5
	syscall 
	sw $v0, n1 #store word pra armazenar o valor lido em $v0 no endereço de n1
	
	#solicita inteiro
	li $v0, 4
	la $a0, msg_entrada
	syscall
	
	#lê inteiro com a instrução 5 do syscall
	li $v0, 5
	syscall 
	sw $v0, n2 #store word pra armazenar o valor lido em $v0 no endereço de n2
	
	#MOVENDO O VALOR DAS VARIÁVEIS PARA REGISTRADORES E SOMANDO
	
	la $t0, n1 #carrega o endereço de n1 em $t0
	lw $s0, 0($t0) #armazeno o valor inteiro do endereço $t0 no registrador $s0
	
	la $t1, n2 #carrega o endereço de n2 em $t1
	lw $s1, 0($t1) #armazena o valor do endereço $t1 no registrador $s1
	
	add $s2, $s0, $s1 #$s2 = $s0 + $s1 
	
	#IMPRIMINDO O RESULTADO
	li $v0, 4
	la $a0, msg_resultado
	syscall
	
	li $v0, 1
	move $a0, $s2 #movendo o valor de $s2 para $a0
	syscall #imprimindo
	
	#ENCERRANDO EXECUÇÃO 
	li $v0, 10
	syscall