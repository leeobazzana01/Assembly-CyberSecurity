# Leia um número do usuário em $t0. Calcule: Quociente da div por 3 ($t2) Resto da divisão ($t3)
# Imprima ambos usando div e mfhi/mflo.
#modificação: fazer o algoritmo da divisão inteira

.data
	cabecalho: .asciiz "Algoritmo de Divisão Inteira\n"
	newline: .asciiz "\n"
	n1: .asciiz "Numerador: "
	n2: .asciiz "Denominador: "
	quociente: .asciiz "Quociente: "
	resto: .asciiz "Resto: "
	erro_divisao: "Não existe Divisão por Zero!!"
.text
.globl main
main:
	#cabeçalho
	li $v0, 4
	la $a0, cabecalho
	syscall
	
	#solicita numerador
	li $v0, 4
	la $a0, n1
	syscall
	
	#le numerador
	li $v0, 5
	syscall
	move $t0, $v0
	
	#solicita denominador
	li $v0, 4
	la $a0, n2
	syscall
	
	#le denominador
	li $v0, 5
	syscall
	move $t1, $v0
	beq $t1, $zero, divisao_invalida

	#calculando divisao
	div $t0, $t1
	mflo $t2 #armazena quociente em $t2
	mfhi $t3 #armazena o resto em $t3
	
	#imprimindo quociente
	li $v0, 4
	la $a0, quociente
	syscall
	
	li $v0, 1
	move $a0, $t2 #valor do quociente em lo
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall
	
	#imprimindo o resto
	li $v0, 4
	la $a0, resto 
	syscall
	
	li $v0, 1
	move $a0, $t3 #valor do resto em hi
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall
			
encerrando_execucao
	li $v0, 10
	syscall
		
divisao_invalida
	li $v0, 4
	la $a0, erro_divisao
	syscall
	j encerrando_execucao

