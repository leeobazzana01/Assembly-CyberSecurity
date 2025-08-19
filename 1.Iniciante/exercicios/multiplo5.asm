#Leia um número e verifique se é múltiplo de 5:Use div e verifique se resto = 0, Imprima "SIM" ou "NAO"
.data
	header: .asciiz "Múltiplo de 5\n"
	input: .asciiz "Número: \n"
	confirma: .asciiz "É Múltiplo!!"
	nega: .asciiz "Não é Múltiplo!!"
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall
	
	#solicita número
	li $v0, 4
	la $a0, input
	syscall
	
	#lê número
	li $v0, 5
	syscall
	
	move $a0, $v0
	j multiplo_5
	 

encerra_execucao:
	#feito!
	li $v0, 10
	syscall
	
multiplo_5:
	li $t0, 5
	div $t1, $a0, $t0
	mfhi $t2 #move o resto p $t2
	
	beq $t2, 0, multiplo
	beq $t2, 1, nao_multiplo 
multiplo:
	li $v0, 4
	la $a0, confirma
	syscall
	j encerra_execucao
	
nao_multiplo:
	li $v0, 4
	la $a0, nega
	syscall
	j encerra_execucao
