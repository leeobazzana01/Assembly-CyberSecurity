# atividade 2- classificar um valor de endereço IPV4
.data
	header: .asciiz "Determinando um Endereço IPV4\n"
	msg_input: .asciiz "Digite um valor entre 0-255: "
	msg_invalido: .asciiz "Valor fora do intervalo!\n"
	msg_classeA: .asciiz "Endereço de classe A\n"
	msg_classeB: .asciiz "Endereço de classe B\n"
	msg_classeC: .asciiz "Endereço de classe C\n"
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall
	
	#input
	li $v0, 4
	la $a0, msg_input
	syscall	
	
	#lê o número
	li $v0, 5
	syscall
	
	#move o valor lido p $s0
	move $s0, $v0
	
	#carrega 255 em $t0
	li $t0, 255
	
	#conferindo se faz parte do intervalo 0-255 
	bltz $s0, fora_intervalo
	bgt $s0, $t0, fora_intervalo
	
	#classe A (primeiro bit = 0)
	#mascara p isolar o bit mais significativo
	andi $t1, $s0, 0x80		
	beq $t1, $zero, classe_A	#resultado = 0, é classe A
	
	#verifica se é classe B (dois primeiros bits = 10)
	andi $t1, $s0, 0xC0		
	li $t2, 0x80			#padraoesperado: 10000000
	beq $t1, $t2, classe_B		#resultado = padrão, é classe B
	
	#classe C (três primeiros bits = 110)
	andi $t1, $s0, 0xE0		#mascara: 11100000 em binário
	li $t2, 0xC0			#padrão esperado: 11000000
	beq $t1, $t2, classe_C		#resultado = padrão, é classe C
	
classe_A:
	#mag classe A
	li $v0, 4
	la $a0, msg_classeA
	syscall
	j encerra_execucao

classe_B:
	#msg classe B
	li $v0, 4
	la $a0, msg_classeB
	syscall
	j encerra_execucao

classe_C:
	#msg classe C
	li $v0, 4
	la $a0, msg_classeC
	syscall
	j encerra_execucao
	
encerra_execucao: 
	li $v0, 10
	syscall
	
fora_intervalo:
	li $v0, 4
	la $a0, msg_invalido
	syscall
	
	j encerra_execucao