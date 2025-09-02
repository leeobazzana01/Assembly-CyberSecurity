.data
	vetor: .word 45, 32, 20, 98, 12, 34, 55, 96, 13, 9
	header: .asciiz "Ordenando um Vetor de Inteiros com BubbleSort\n"
	msg_execucao: .asciiz "Execucao "
	newline: .asciiz "\n"
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, msg_inicio
	syscall

	la $s0, vetor
	li $s1, 0 #n trocas no bubblesort 
	li $t0, 0 #contador		
bubble_sort: 
	add $t1, $t0, 1 # $t1 = contador + 1
	
	#deslocamento a[n]
	sll $t2, $t0, 2
	add $t3, $t2, $s0
	
	#deslocamento a[n+1]
	sll $t2, $t1, 2
	add $t4, $t2, $s0
	
	#comparacao 
	lw $s2, 0($t3)
	lw $s3, 0($t4)
	
	#se a[n] > a[n+1], troco os valores
	bgt $s2, $s3, troca_valores
	
	#se não, adiciono 1 ao contador
	addi $t0, $t0, 1
	
	j bubblesort
	
	
troca_valores:
	addi $s1, $s1, 1 #mudanças + 1
	
	move $t5, $s2
	move $t6 $s3
	
	li $s2, $t6
	li $s3, $t5
	
	#imprimindo os valores do array
	li $t0, 0 #contador
	la $t1, vetor
imprimindo_valores:
	sll $t3, $t0, 2 #deslocar o contador 2 vezes p esquerda p multiplicar por 4
	add $t4, $t3, $t1 #adicionar o deslocamento ao vetor
	 
	lw $t2, 0($t4)
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	add $t0, $t0, 1 # $t0 += 1
	bne $t0, 11, imprimindo_valores
	
	j bubblesort
	
encerrando_execucao:
	li $v0, 10
	syscall
	

	