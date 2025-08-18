#Objetivo: Ler um número N e imprimir todos os números de 1 até N.Técnicas: Loop com addi, ble/bgt.
.data
	header: .asciiz "Contagem de 0 a N\n"
	input:  .asciiz "Digite um Inteiro: \n"
	newline: .asciiz "\n"
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall
	
	#input
	li $v0, 4
	la $a0, input
	syscall
	
	#lê input
	li $v0, 5
	syscall
	
	#armazena valor em $a0
	move $a0, $v0
	#salt p função
	jal contagem_inteiros
	
	li $v0, 10
	syscall
	
contagem_inteiros:
	li $t0, 1 #contador
	move $t1, $a0 #numero
	
	#verifica sinal
	bgtz $t1, positivo #se $a0 > 0, salta p positivo
	bltz $t1, negativo #se $a0 > 0, salta p negativo
	beq $t1, 0, zero
	
zero:
	move $v0, $a0 #se o argumento for zero, retorna zero como valor da contagem
	jr $ra

positivo:
	#\n
	li $v0, 1 
	la $a0, newline
	syscall
	
	#imprime contador
	li $v0, 1 
	move $a0, $t1
	syscall
	
	blt $t0, $t1, while_positivo #se contador < numero, salta p iteração
	
	#qnd contador  == numero, retorna p main
	jr $ra
while_positivo:
	addi $t0, $t0, 1 #enquanto contador < numero, contador++
	j positivo

negativo:
	#\n
	li $v0, 1 
	la $a0, newline
	syscall
	
	#imprime contador (inicialmente vale 1)
	li $v0, 1 
	move $a0, $t1
	syscall
	
	bgt $t1, $t0, while_negativo #se contador > numero, salta p iteração
	
	#qnd contador  == numero, retorna p main
	jr $ra
while_negativo:
	addi $t0, $t0, -1 #enquanto contador > numero, contador--
	j negativo


