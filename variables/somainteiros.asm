.data 
	header: .asciiz "Soma entre dois Números\n" 
	msg_input: .asciiz "Digite um Inteiro: \n"
	n1: .word
	n2: .word 
	soma: .word
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	

solicita_valor:
	li $v0, 4
	la $a0, msg_input
	syscall
	
	li $v0, 5
	la $a0, n1
	syscall