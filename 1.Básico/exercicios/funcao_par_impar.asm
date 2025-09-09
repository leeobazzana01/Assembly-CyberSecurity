 #Implemente uma função par que: Recebe número em $a0, Retorna 1 em $v0 se par, 0 se ímpar
#Use andi $t0, $a0, 1 (bit menos significativo). Teste com números 9 e 12
.data
	cabecalho: .asciiz "Função Par(0) e Ímpar(1)"
	input: .asciiz "Digite um número inteiro: "
	newline: .asciiz "\n"
	msg_resultado: .asciiz "Resultado: "
.text
.globl main
main:
	#imprime cabeçalho
	li $v0, 4
	la $a0, cabecalho
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall
	
	#solicita entrada
	li $v0, 4
	la $a0, input
	syscall
	
	#lê entrada
	li $v0, 5
	syscall
	
	#move valor lido para $a0 e chama a função
	move $a0, $v0
	jal paridade

	#move o valor retornado de $v0 para $t0
	move $t0, $v0
	
	#imprime msg de resultado
	li $v0, 4
	la $a0, msg_resultado
	syscall

	li $v0, 1
	move $a0, $t0
	syscall
	
encerrando_execucao:
	li $v0, 10
	syscall
	
paridade:
	addi $t0, $zero, 2
	div $a0, $t0
	mfhi $t1    #move o resto do registrador HI para $t1
	beq $t1, 0, par
	beq $t1, 1, impar
	
par:
	li $v0, 0
	jr $ra
impar:
	li $v0, 1
	jr $ra
