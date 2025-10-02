.data
	header: .asciiz "Convertendo um valor de Hexadecimal para Binário\n"
	msg_valor: .asciiz "Valor em Hexadecimal: "
	msg_binario: .asciiz "Valor em Binário: "
	valor_hexa: .asciiz "8000000f"
	valor_binario: .space 33  # espaço para 32 bits + terminador nulo
	novalinha: .asciiz "\n"
.text
.globl main
main:
	# header
	li $v0, 4
	la $a0, header
	syscall
	
	# mensagem do valor hex
	li $v0, 4
	la $a0, msg_valor
	syscall
	
	#valor hex
	li $v0, 4
	la $a0, valor_hexa
	syscall
	
	#\n
	li $v0, 4
	la $a0, novalinha
	syscall
	
	#chama função
	la $a0, valor_hexa
	jal converte_binario
	
	#imprime a msg do binário
	li $v0, 4
	la $a0, msg_binario
	syscall
	
	#imprime o resultado
	li $v0, 4
	la $a0, valor_binario
	syscall
	
	#\n
	li $v0, 4
	la $a0, novalinha
	syscall
 
encerra_execucao:
	li $v0, 10
	syscall
	
converte_binario:
	#salva argumento
	move $s0, $a0
	
	#indice do caractere hex
	li $t0, 0
	
	#carregando os endereços
	la $t1, valor_hexa
	la $t2, valor_binario
	
	#indice do vetor binario
	li $t3, 0
	
loop:
	#load caractere atual
	addu $t4, $t1, $t0
	lb $t5, 0($t4)
	
	#verifica \0
	beq $t5, $zero, final_conversao
	
	#dígito 0-9
	li $t6, '0'
	li $t7, '9'
	blt $t5, $t6, caractere_invalido
	bgt $t5, $t7, verificar_letra_maiuscula
	
	#converte p número
	sub $t8, $t5, '0'
	j converter_para_binario

verificar_letra_maiuscula:
	#letra A-F
	li $t6, 'A'
	li $t7, 'F'
	blt $t5, $t6, verificar_letra_minuscula
	bgt $t5, $t7, verificar_letra_minuscula

	#converte letra maiúscula
	sub $t8, $t5, 'A'
	addi $t8, $t8, 10
	j converter_para_binario

verificar_letra_minuscula:
	#letra a-f
	li $t6, 'a'
	li $t7, 'f'
	blt $t5, $t6, caractere_invalido
	bgt $t5, $t7, caractere_invalido
	
	#converte letra minuscula
	sub $t8, $t5, 'a'
	addi $t8, $t8, 10

converter_para_binario:
	#contador 4 bits
	li $t9, 3
	
loop_bits:
	#mascara p o bit atual
	li $s1, 1
	sllv $s1, $s1, $t9
	
	#testa o bit ativo
	and $s2, $t8, $s1
	beq $s2, $zero, bit_zero
	
	#bit = 1
	li $s3, '1'
	j armazenar_bit

bit_zero:
	#bit = 0
	li $s3, '0'

armazenar_bit:
	#armazena bit no vetor
	addu $s4, $t2, $t3
	sb $s3, 0($s4)
	
	#incrementa indice
	addi $t3, $t3, 1
	
	#decrementa contador 
	addi $t9, $t9, -1
	
	#verifica se ainda tem bit
	bge $t9, $zero, loop_bits
	
	#próx caractere hex
	addi $t0, $t0, 1
	j loop

final_conversao:
	#add \0 na string de binários
	addu $s4, $t2, $t3
	sb $zero, 0($s4)
	
	#retorna p main
	jr $ra

caractere_invalido:
	#retorna qnd caractere invalido
	jr $ra