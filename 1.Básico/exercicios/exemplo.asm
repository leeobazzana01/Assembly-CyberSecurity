.data
	header: .asciiz "Procurando um caractere em uma String!\n"
	newline: .asciiz "\n"
	msg_string: .asciiz "Digite uma String: "
	msg_caractere: .asciiz "Caractere que deseja encontrar: "
	total: .asciiz "Total caracteres: "
	
.text

.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	#lendo a string
	li $v0, 4
	la $a0, msg_string
	syscall
	
	la $v0, 8
	syscall 
	
	#movendo a string para $t0
	move $t0, $v0
	
	#lendo caractere
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, msg_caractere
	syscall
	
	la $v0, 12
	syscall 
	
	#movendo a string para $t0
	move $t1, $v0
	
	#chamando a função
	move $a0, $t0
	move $a1, $t1
	jal procurando_caractere
	
	#movendo valor de retorno
	move $t2, $v0
	
	
	li $v0, 4
	la $a0, total
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
encerrando_execucao:
	li $v0, 10
	syscall
	
procurando_caractere:
	addi $t0, $zero, 0 #contador
	addi $t1, $zero, 0 #quantidade de vezes q o caractere aparece
	
loop: 
	add 	
	 