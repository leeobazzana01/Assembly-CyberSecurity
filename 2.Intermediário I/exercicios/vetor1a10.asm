.data
	vetor_inteiros: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	header: .asciiz "Preenchendo um vetor com 10 inteiros\n"
	resultado: .asciiz "Resultado: "
	tab: .asciiz "\t"
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $a0, 1
	la $a1, vetor_inteiros
	
	jal preenche_vetor
	
	#msg de resultado 
	li $v0, 4
	la $a0, vetor_inteiros
	syscall
	
	
	#imprimindo o vetor
	li $t0, 0
	la $t1, vetor_inteiros
	
imprime_vetor:

	#deslocando 2x pra multiplicar por 4
	sll $t2, $t0, 2	
	
	#somando o deslocamento ao endereço base
	add $t3, $t1, $t2
	 	
	#imprimindo o valor: deve carregar a palavra do endereço
	li $v0, 1
	lw $a0, 0($t3)        # carrega o valor do vetor
	syscall
	
	#imprimindo tab
	li $v0, 4
	la $a0, tab
	syscall
	
	#atualizando contador 
	addi $t0, $t0, 1
	
	#condição de parada 
	blt $t0, 10, imprime_vetor
	
encerrrando_execucao: 
	li $v0, 10
	syscall

preenche_vetor:
	 #valor inteiro a ser armazenado 
	 move $s0, $a0
	 
	 #endereço do array
	 move $s1, $a1
	 
	 #contador de iterações
	 li $t0, 0
	 
loop:
	#devo deslocar 2 vezes para multiplicar por 4
	sll $t1, $t0, 2
	
	#somar o deslocamento ao endereço do array: add $t2, $s1, $t1
	add $t2, $s1, $t1
	
	#armazenar valor
	sw $s0, 0($t2)
	
	#atualizando contador e o valor inteiro
	addi $s0, $s0, 1
	addi $t0, $t0, 1
	
	bne $t0, 10, loop

	move $v0, $s1
	
	jr $ra