# Declare um vetor de 5 inteiros com valores {1, 3, 5, 7, 9}. 
# Carregue o terceiro elemento (índice 2) em $t0 usando offset fixo (ex: 8($s0)).

.data
     vetor_impares: .word 1, 3, 5, 7, 9
     header: .asciiz "Acessando o terceiro elemento do Vetor\n"
     opcao_solucao: .asciiz "Selecione uma opção de solução: \n1.Simples \n2.Complexa\n"
     msg_valor: .asciiz "Ímpar na posição 3 do Vetor: "
     
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, opcao_solucao
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	#carregar o vetor de impares
	la $s0, vetor_impares
	
	#desviar o fluxo conforme a entrada do usuário
	beq $t1, 1, solucao_simples
	beq $t1, 2, solucao_complexa
	
solucao_simples:
	lw $t0, 8($s0) 
	
	li $v0, 4
	la $a0 msg_valor
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	 j encerrando_execucao
solucao_complexa: 
	
	#adicionar o índice ao $t2, no caso é 2 pois o primeiro elemento do veto eh zero 
	add $t2, $zero, 2
	
	#dois sll multiplica por 2 duas vezes, ent armazenamos em $t1 pra saber qnts deslocamentos precisamos
	sll $t1, $t2, 2 
	
	#deslocar o índice inicial e adicionar em uma variável
	add $t3, $s0, $t1 
	
	#carregar o valor do índice 2 para um registrador
	lw $t0, 0($t3) 
	
	li $v0, 4
	la $a0 msg_valor
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall

encerrando_execucao:
	li $v0, 10
	syscall 