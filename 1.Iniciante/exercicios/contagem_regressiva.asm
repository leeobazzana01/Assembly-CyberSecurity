# Imprima números de 10 a 1 em ordem decrescente:Use $t0 como contador, Decremente com addi, Termine quando $t0 = 0
.data
	cabecalho: .asciiz "Contagem Regressiva!"
	newline: .asciiz "\n"
.text
.globl main
main:
	#cabeçalho
	li $v0, 4
	la $a0, cabecalho
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall
	
	#$t0 = $zero + 10
	add $t0, $zero, 10
	add $t2, $zero, 1
while: 
	bge $t0, $t2, imprime_contador #enquanto $t0 >= $t2, salta p imprime_contador

encerra_execucao:
	li $v0, 10
	syscall
imprime_contador:
	#imprime $t0
	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, newline
	syscall

	#$t0--
	addi $t0, $t0, -1
	
	#sleep 1000 milisegundos (1 segundo)
	li $t1, 1000
	
	li $v0, 32
	move $a0, $t1
	syscall
			
	j while	
