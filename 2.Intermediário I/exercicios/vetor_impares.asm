# Declare um vetor de 5 inteiros com valores {1, 3, 5, 7, 9}. 
# Carregue o terceiro elemento (índice 2) em $t0 usando offset fixo (ex: 8($s0)).

.data
	vetor: .word 1, 3, 5, 7, 9
	header: .asciiz "Acessando elementos do Vetor de Ímpares\n"
	indice: .asciiz "Digite o índice que deseja acessar: "
	valor: .asciiz "Valor: "
	erro: .asciiz "Índice Inválido! Só há índices entre 0 e 4 no Array!!!"
         
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, indice
	syscall 
	
	#lê o índice 
	li $v0, 5
	syscall
	
	#índice = $s0
	move $s0, $v0
	
	li $t0, 4
	
	#tratando as entradas: caso o usuário digite um índice maior ou menor q existe
	bltz $s0, msg_erro
	bgt $s0, $t0, msg_erro
	
	#endereço de a[0] = $t0
	la $t0, vetor 		
	
	#calculando deslocamento
	sll $t1, $s0, 2

	#deslocando
	add $t2, $t0, $t1
	
	#carregando o valor do índice
	lw $s1, 0($t2)
	
	#imprimindo o resultado
	li $v0, 4
	la $a0, valor
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall   	   
	
encerra_execucao:
	li $v0, 10
	syscall
	
msg_erro:
	li $v0, 4
	la $a0, erro
	syscall
	
	j encerra_execucao
