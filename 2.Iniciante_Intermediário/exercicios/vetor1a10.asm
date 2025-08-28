# Declare um vetor de 10 inteiros inicializados com 0. Use um loop para preenchê-lo com valores de 1 a 10. 
#Armazene cada elemento usando sw.
.data
	vetor_zeros: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	header: .asciiz "Iterando e mudando os valores de um Array\n"
	msg_inicio: .asciiz "Valores Iniciais do Array\n"
	msg_final: .asciiz "Valores Finais do Array\n"
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	li $a0, msg_inicio
	syscall
	
	li $t0, 10
	#carrega o endereço do vetor em $t1
	la $t1, vetor_zeros	
imprime_elementos: 

	
	
		

	
encerra_execucao:
	li $v0, 10
	syscall