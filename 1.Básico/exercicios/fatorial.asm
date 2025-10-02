#Escreva uma função chamada fatorial que recebe um número inteiro não negativo n (passado via registrador $a0) e calcula o seu fatorial (n!) usando um loop. A função deve retornar o resultado no registrador $v0. 
#O programa principal deve chamar essa função com um valor específico (ex: 5) e armazenar o resultado na memória. Use apenas multiplicações que podem ser tratadas com mul (considere que o resultado será < 2³¹).
.data
	header: .asciiz "Calculando o Fatorial de um Número Positivo\n"
	input:	.asciiz "Numero: "
	valor_numero: .word 0
	resultado: .asciiz "Resultado: "
	valor_resultado: .word 0
	msg_negativo: .asciiz "Entrada Inválida! Número Negativo!"
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall
	
	#input
	li $v0, 4
	la $a0, input
	syscall
	
	#lê o número
	li $v0, 5
	syscall
	
	#armazena na memória
	sw $v0, valor_numero
	
	#carrega o valor como argumento
	li $a0, valor_numero 
	
	#salta p função
	jal fatorial
	
	
encerra_execucao:
	li $v0, 10
	syscall
	
	
fatorial:
	#movendo valor p $s0
	move $a0, $s0

	#verificando sinal
	bltz $s0, numero_negativo

calcula_fatorial:
	
	

numero_negativo:
	li $v0, 4
	la $a0, msg_negativos
	syscall
	
	j encerra_execucao

	