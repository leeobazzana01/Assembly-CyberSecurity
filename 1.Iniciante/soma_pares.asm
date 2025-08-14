
.data
	cabecalho: .asciiz "Soma de pares de 2 a 20"
	newline: .asciiz "\n"
	msg_contador: .asciiz "Contador: "
	msg_soma: .asciiz "Soma: "
.text
.globl main
main:
	#imprime cabeçalho
	li $v0, 4
	la $a0, cabecalho
	syscall

	#\n
	li $v0, 4
	la $a0, newline
	syscall
	
	addi $t0, $t0, 22 #$t0 = 22 variável de controle, para somarmos de 2 a 20
	addi $t1, $t1, 0  #$t1 armazena valor da soma
	addi $t2,  $t2, 2 #$t2 armazena contador  
while:
	bne $t0, $t2, soma #se $t0 != $t2, vai p label soma
		
encerrra_execucao:
	li $v0, 10
	syscall
soma:
	#imprime valor do contador
	li $v0, 4
	la $a0, msg_contador
	syscall

	#imprime $t2 = contador	
	li $v0, 1
	move $a0, $t2
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall

	#imprime valor da soma
	li $v0, 4
	la $a0, msg_soma
	syscall

	#imprime $t1 = soma	
	li $v0, 1
	move $a0, $t1
	syscall
	
	#\n
	li $v0, 4
	la $a0, newline
	syscall	  
	 
	add $t1, $t1, $t2 #$t1 = #t1 + $t2 ->soma = contador + soma
	addi $t2, $t2, 2 #$t2 = $t2 + 2
	j while
		