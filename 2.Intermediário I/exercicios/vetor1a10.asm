#Declare um vetor de 10 inteiros inicializados com 0. Use um loop para preenchê-lo com valores de 1 a 10. 
#Armazene cada elemento usando sw.
.data
	vetor_zeros: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	header: .asciiz "Iterando e mudando os valores de um Array\n"
	msg_final: .asciiz "Valores Finais do Array\n"
	newline: .asciiz "\n"
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, msg_final
	syscall
	
	la $s0, vetor_zeros 	#carrega o endereço do vetor em $s0		
	addi $t0, $zero, 0  #contador = $t1
	 
substitui_elementos:

	blt $t0, 10, while
	
encerra_execucao:
	li $v0, 10
	syscall

while:  
	lw $t1, 0($s0) 		# a[n] = $t1
	li $t1, 0
	add $t1, $t1, $t0 	# t1 = contador + a[n]
	sw $t1, 0($s0) 
	
	li $v0, 1
	lw $a0, 0($s0)
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	add $t0, $t0, 1 #contador += 1
	
	sll $t2, $t0, 2   #deslocamento = contador * 4
	
	add $t3, $s0, $t2 #$t3 = início array + deslocamento  
	
	sw $s0, 0($t3) #muda o início do array para o deslocamento
	
	
	j substitui_elementos
