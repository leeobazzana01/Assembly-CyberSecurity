#Número Primo. Objetivo: Ler um número e verificar se é primo.
#Se for primo, imprimir "PRIMO".Caso contrário, "NAO PRIMO".
#Técnicas: Loop com div, mfhi, beq.

.data
	header: .asciiz "Verificando se um Número é Primo\n"
	numero: .asciiz "Digite um Número: \n"
	primo: .asciiz "É primo!!!\n"
	nao_primo: .asciiz "Não é primo!!!\n"
.text
.globl main
main:
	li $v0, 4
	la $a0, header #cabeçalho
	syscall

	li $v0, 4
	la $a0, numero #solicita número
	syscall	
	
	li $v0, 5 # $v0 = n
	syscall
	
	li $v0, 10 #feito
	syscall