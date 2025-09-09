.data 
	inicial: .byte 'l'
	mensagem: .asciiz "Ola mundo!\n"
.text
.globl main
main:

	li $v0, 4
	la $a0, mensagem
	syscall
	
	li $v1, 4
	la $a1, inicial
	syscall
	
	li $v0, 10 #instrução 10 do syscall encerra execução
	syscall