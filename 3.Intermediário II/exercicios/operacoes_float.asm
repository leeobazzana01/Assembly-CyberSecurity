.data
	header: .asciiz "OPERAÇÕES ENTRE DOIS FLOAT\n"
	msg_var1: .asciiz "Variável 1: "
	msg_var2: .asciiz "Variável 2: "
	msg_soma: .asciiz "\nSoma: "
	msg_sub: .asciiz "\nSubtração: "
	msg_mult: .asciiz "\nMultiplicação: "
	msg_div: .asciiz "\nDivisão: "
	
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall

	#le var1
	li $v0, 4
	la $a0, msg_var1
	syscall
	li $v0, 6
	syscall
	mov.s $f1, $f0

	#le var2
	li $v0, 4
	la $a0, msg_var2
	syscall
	li $v0, 6
	syscall
	mov.s $f2, $f0

	#operacoes
	li $v0, 4
	la $a0, msg_soma
	syscall
	add.s $f12, $f1, $f2
	li $v0, 2
	syscall

	li $v0, 4
	la $a0, msg_sub
	syscall
	sub.s $f12, $f1, $f2
	li $v0, 2
	syscall

	li $v0, 4
	la $a0, msg_mult
	syscall
	mul.s $f12, $f1, $f2
	li $v0, 2
	syscall

	li $v0, 4
	la $a0, msg_div
	syscall
	div.s $f12, $f1, $f2
	li $v0, 2
	syscall

encerra_execucao:
	li $v0, 10
	syscall