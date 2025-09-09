.data
	vetor: .word 45, 32, 20, 98, 12, 34, 55, 96, 13, 9
	header: .asciiz "Ordenando um Vetor de Inteiros com BubbleSort\n"
	msg_execucao: .asciiz "Execucao "
	msg_inicio: .asciiz "Vetor Inicial: "
	newline: .asciiz "\n"
	tab: .asciiz "\t"
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
	li $t0, 0 #contador

imprime_vetor:	
	sll $t1, $t0, 2 #deslocamento = contador * 4
	add $t2, $t1, $s0
	
	#carregando
	lw $s1, 0($t2)
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	#\t 
	li $v0, 4
	la $a0, tab
	syscall
	 
	addi $t0, $t0, 1 #contador ++
	bne $t0, 11, imprime_vetor #enquanto contador < 11, imprime o próx elemento
	 
	#\n 
	li $v0, 4
	la $a0, newline
	syscall
	
	move $a0, $s0
	li $a1, 0 #contador
	addi $a2, $a1, 1
	jal bubblesort
	
encerrando_execucao:
	li $v0, 10
	syscall
	

bubblesort:
	#$a0 = vetor
	#$a1 = contador (0)
	#$a2 = contador + 1
	li $s1, 0 #mudanças no array
	
	#a[n]
	sll $t3, $a1, 2 #deslocamento
	add $t4, $a0, $t3
	
	#a[n+1]
	sll $t5, $a2, 2 #deslocamento
	add $t6, $a0, $t5
	
troca_posicao:
	#se a[n] > a[n + 1] trocamos
	bgt $t4, $t6, altera_array

atualiza_bubblesort:
	addi $
	
	
	
altera_array: 
	move $t8, $t4
	move $t9, $t6
	
	li $t
	
	
	
	
