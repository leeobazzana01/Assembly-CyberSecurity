.data #declaração de variáveis e dados

	s: .word  #.word = o tipo da variável armazenada de acordo com o número de bits do processador, no caso 32 
	si: word 20
	v: .word 10
	t: .word 20


	.text
	.globl main

	main:
	
	li $v0, 5
	syscall
	sw $v0, s
        
        li $v0, 5
        syscall
	sw $v0, si
	
	li $v0, 5
	syscall
	sw $v0, v
	
	li $v0, 5
	syscall
	sw $v0, t
	
	lw $s1, s     #load word, carrego o que está escrito na palavra e travo para o registrador s1 
	lw $s2, si     
	lw $s3, v     
	lw $s4, t     

#operações
	mul $t0, $s3, $s4   #$registrador t0 contem v * t
	add $t1, $s2, $t0   #registrador $t1 contem si $t0 que armazena o resultado de v*t
	sw  $s0, s  
	
	la $a0, str1 	# endereco da string não terminada com NULL
	li $v0, 1 	# imprime um inteiro
	syscall
	li $v0, 1 	# imprime inteiro
	lw $a0, varf	# value for int to print
	syscall
	j feito		#j = jump

feito:
	li $v0, 10#chama o exit para fechar o programa
	syscall # feito!

