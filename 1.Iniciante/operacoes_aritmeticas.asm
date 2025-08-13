#Calcule (37 - 15) * 2 usando apenas:addi, sub, mul. Armazene o resultado em $t2 e imprima.
.data
	mensagem: .asciiz "Calculando (37 - 15) * 2\nResultado: "
.text
.globl main
main:
	#imprime msg
	li $v0, 4
	la $a0, mensagem
	syscall
	
	addi $t0, $t0, 37 #$t0 = 37
	addi $t1, $t1, -15 #$t1 = -15
	
	add $t3, $t0, $t1 #$t3 = $t0 + $t1
	mul $t2, $t3, 2 #$t2 = $t3 * 2
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 10
	syscall
	
	