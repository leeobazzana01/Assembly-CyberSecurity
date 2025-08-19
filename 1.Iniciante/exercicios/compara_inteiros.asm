#Leia dois números A e B: Se A > B, imprima "MAIOR", Se A < B, imprima "MENOR", Se iguais, imprima "IGUAIS"

.data
	cabecalho: .asciiz "Comparando dois números\n"
	newline: .asciiz "\n"
	input: .asciiz "Numero: "
	b_maior: .asciiz "Segundo numero maior que primeiro!!!"
	a_maior: .asciiz "Primeiro numero maior que segundo!!!"
	iguais: .asciiz "Valores Iguais!!!"
.text
.globl main
main:
	#cabecalho
	li $v0, 4
	la $a0, cabecalho
	syscall
	
	#solicita a 
	li $v0, 4
	la $a0, input
	syscall
	
	#le a
	li $v0, 5
	syscall
	move $t0, $v0
	
	#solicita b 
	li $v0, 4
	la $a0, input
	syscall
	
	#le b
	li $v0, 5
	syscall
	move $t1, $v0

	beq $t0, $t1, iguais_et #se $t0 == $t1 salta p iguais 
	bgt $t0, $t1, primeiro_maior #se $t0 > $t1 salta p primeiro_maior
	blt $t0, $t1, segundo_maior #se $t0 < $t1 salta p segundo maior
	
primeiro_maior:
	li $v0, 4
	la $a0, a_maior
	syscall
	j fim
	
segundo_maior:
	li $t0, 4
	la $a0, b_maior
	syscall
	j fim
iguais_et:
	li $v0, 4
	la $a0, iguais
	syscall
	j fim
fim:
	#encerrando execução 
	li $v0, 10
	syscall