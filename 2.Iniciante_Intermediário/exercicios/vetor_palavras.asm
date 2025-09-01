# Declare um vetor de 8 palavras. 
# Peça ao usuário um índice (0-7) e exiba o valor correspondente. Use sll para calcular o offset.
.data
	vetor_palavras: .word 0, 10, 20, 30, 40, 50, 60, 70
	header: .asciiz "Imprime o inteiro de um vetor de 8 números\n"
	solicita_indice: .asciiz "Índice: "
	newline: .asciiz "\n"
	msg_intervalo: .asciiz "O Índice deve estar entre 0 e 7!!!"
	msg_valor: .asciiz "Valor Armazenado: "
	
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, solicita_indice
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	
	bgt $a0, 7, fora_intervalo
	blt $a0, 0, fora_intervalo
	jal retorna_indice
	move $s2, $v0
	
	li $v0, 4
	la $a0, msg_valor
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
encerrando_execucao:
	li $v0, 10
	syscall
	
fora_intervalo:
	li $v0, 4
	la $a0, msg_intervalo
	syscall
	
	j encerrando_execucao
	
retorna_indice:
	la $t0, vetor_palavras #carrega o end do vetor

	#deslocamento
	move $t1, $a0 #$t1 = indice
	sll $t2, $t1, 2 #multiplico por 4 o deslocamento que preciso fazer no índice $t1 e adiciono em $t2
	add $t3, $t2, $t0 #somo o deslocamento ao endereço base e armazeno em $s1
	
	lw $s1, 0($t3)
	move $v0, $s1
	jr $ra