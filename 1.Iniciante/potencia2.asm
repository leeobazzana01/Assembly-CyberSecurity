#Leia um número n (1 ≤ n ≤ 10):Calcule 2^n usando loop c multiplicações, Armazene resultado em $s0
.data
	header: .asciiz "Potência de 2\n"
	input: .asciiz "Expoente: \n"
	resultado: .asciiz "Resultado = "
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
	
	#n = $a0
	li $v0, 5
	syscall
	
	#chama a função, passando $a0 como argumento
	move $a0, $v0
	jal calcula_potencia
	
	#movendo valor retornado para um registrador temporário
	move $t1, $v0
	
	#msg_resultado
	li $v0, 4
	la $a0, resultado
	syscall
	
	#imprimindo valor
	li $v0, 1
	move $a0, $t1
	syscall 

	li $v0, 10
	syscall
	
calcula_potencia:
	beq $a0, 0, expoente_zero
	li $t0, 2 #$t0 = 2
while:
	mul $t0, $t0, 2 #$t0 = 2*2
	sub $a0, $a0, 1  # n = n-1
	
	bne $a0, 1, while # se n != 0, multiplica 2*2 novamente 
	move $v0, $t0
	jr $ra
	
expoente_zero:
	li $v0, 1
	jr $ra 