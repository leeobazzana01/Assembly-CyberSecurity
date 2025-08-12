.data
	n1: .word 25
	n2: .word 2
	msg_soma: .asciiz "Valor da Soma: \n"
	msg_subt: .asciiz "\nValor da Subtração: "
	
.text
.globl main
main:
	lw $t0, n1 #lw = load word, carrega um valor word para um registrador 
	lw $t1, n2
	
	soma: add $s0, $t0, $t1 #$t2 = $t0 + $t1 
	subtracao: sub $s1, $t0, $t1 #$t3 = $t0 - $t1
	
	#imprimindo mensagem de soma
	li $v0, 4
	la $a0, msg_soma
	syscall 
	
	#imprimindo valor da soma
	li $v0, 1
	la $a0, soma
	syscall
	
	#imprimindo mensagem de subtração
	li $v0, 4
	la $a0, msg_subt
	syscall 
	
	#imprimindo valor da soma
	li $v0, 1
	la $a0, subtracao
	syscall
	
	
