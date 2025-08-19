#Ler um número. Imprimir "POSITIVO", "NEGATIVO" ou "ZERO"
.data
	cabecalho: .asciiz "Positivo, Negativo ou Zero\n"
	input: .asciiz "Valor: "
	positivo: .asciiz "Positivo!!!"
	negativo: .asciiz "Negativo!!!"
	zero: .asciiz "Zero!!!"
.text
.globl main
main:
	#cabecalho
	li $v0, 4
	la $a0, cabecalho
	syscall
	
	#input 
	li $v0, 4
	la $a0, input
	syscall
	
	#le inteiro
	li $v0, 5
	syscall
	move $t1, $v0
	
	bgtz $t1, positivo_et #branch if $t1 < $zer0
	bltz $t1, negativo_et #branch if $t1 < $zer0
	bqz $t1, zero_et #branch if $t1 equal zero

zero_et:
	li $v0, 4
	la $a0, zero
	syscall	
	j fim
negativo_et:
	li $v0, 4
	la $a0, negativo
	syscall
	j fim
positivo_et:
	li $v0, 4
	la $a0, positivo
	syscall

fim:
	#encerra execução
	li $v0, 10
	syscall