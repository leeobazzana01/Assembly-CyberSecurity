# Transformar o código de C para assembly
# int A[100];
# g = h + A[8];
#g em $s1, h em $s2, posição 0 de A em $s3

.data
	vetor_inteiros: .word 10, 20, 30, 40, 50
	
	
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	#declarando um vetor de 100 inteiros, todos começando em 0 e aumentando 2 unidades por posição 
	li $t0, 100
	li $t1, 0
	li $t2, 2
while:
	lw 
		
	
	
encerrando_execucao:
	li $a0, 10
	syscall