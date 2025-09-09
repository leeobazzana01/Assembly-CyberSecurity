#calcular f = (g + h) - (i + j) usando pilhas e procedimentos
.data
	header: .asciiz "Calculando f = (g+h) - (i+j) com PILHAS\nPreencha os valores de g, h, i e j respectivamente abaixo\n"
	input_numero: .asciiz "Numero: "
	newline: .asciiz "\n"
	resultado: .asciiz "Resultado: "
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall
	
	#g
	li $v0, 4
	la $a0, input_numero
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	#h
	li $v0, 4
	la $a0, input_numero
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	#i
	li $v0, 4
	la $a0, input_numero
	syscall
	
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	#j
	li $v0, 4
	la $a0, input_numero
	syscall
	
	li $v0, 5
	syscall
	
	move $t3, $v0


	#movendo os valores de g, h, i e j para argumentos
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	move $a3, $t3
	
	jal func
	move $t0, $v0
	
 	#resultado
	li $v0, 4
	la $a0, resultado
	syscall	
	
	li $v0, 1
	move $a0, $t0
	syscall
	
encerrando_execucao:
	li $v0, 10
	syscall
	
func:
	#alocando memória
	addi $sp, $sp, -12
	
	#empilhando
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	sw $s0, 0($sp)
	
	add $t0, $a0, $a1 #$t0 = g + h 
	add $t1, $a2, $a3 #$t1 = i + j
	sub $s0, $t0, $t1 #$s0 = (g+h) - (i+j)
	
	add $v0, $s0, $zero
	
	#desempilhando
	lw $s0, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	
	#free de memória
	addi $sp, $sp, 12
	jr $ra