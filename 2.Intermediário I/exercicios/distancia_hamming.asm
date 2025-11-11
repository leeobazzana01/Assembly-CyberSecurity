.data
	
	#dados biológicos
	dna_mitocondrial: .asciiz "ATGATAATT"
	bases_nitrogenadas: .asciiz "ATCG"
	
	#string digitada pelo usuário
	sequencia: .space 10
	
	#mensagens
	header: .asciiz "CALCULO DA DISTANCIA DE HAMMING\n" 
	msg_entrada: .asciiz "Insira uma Sequência de DNA com 9 bases: "
	msg_invalida: .asciiz "\nBase Nitrogenada Inválida!\nEncerrando Execução!\n"
	msg_distancia: .asciiz "\nDistancia de Hamming: "
	msg_comprimento: .asciiz "\nComprimento Inválido da Base Nitrogenada!\nEncerrando execução!\n"
	
.text
.globl main
main:
	#header
	li $v0, 4
	la $a0, header
	syscall
	
	#msg entrada
	li $v0, 4
	la $a0, msg_entrada
	syscall
	
	#lê a string
	la $a0, sequencia
	li $a1, 10             #comprimento máximo da string, 9 caracteres + \0
	li $v0, 8
	syscall
	
	#move endereço da string pra $s0
	move $s0, $a0
	
	#verifica comprimento
	jal compara_comprimento

	#verifica validade dos caracteres
	jal caractere_invalido

	#calcula distancia de Hamming
	jal calcula_distancia
	
	#salva distancia retornada em $s1
	move $s1, $v0
	
	#imprime resultado
	li $v0, 4
	la $a0, msg_distancia
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
encerra_execucao: 
	li $v0, 10
	syscall

compara_comprimento:

    li $t0, 0           #contador caracteres
    move $t3, $s0       #move end pra $t3

    loop_comp:
    	lb $t1, 0($t3)      #carrega byte
    	beqz $t1, fim_comp  #se chegou em \0 vai pro fim
    	addi $t0, $t0, 1    #contador++
    	addi $t3, $t3, 1    #vai pro prox caractere
    	j loop_comp         

    fim_comp:
    	li $t2, 9           #comprimento esperado (9 caracteres)
    	beq $t0, $t2, ok_comp
    	li $v0, 4
    	la $a0, msg_comprimento
    	syscall
    	j encerra_execucao

    ok_comp:
    	jr $ra
    
caractere_invalido:
    move $t3, $s0           #copia da string digitada

    verifica_loop:
    	lb $t1, 0($t3)          #le caractere atual
    	beqz $t1, fim_verifica  #se \0, acabou a string
    
    #carregar lista de bases
    la $t4, bases_nitrogenadas
    
    proxima_base:
    	lb $t5, 0($t4)
    	beqz $t5, base_invalida     #invalida se nao esta na lista
    	beq $t1, $t5, base_valida   #caractere igual válida
    	addi $t4, $t4, 1
    	j proxima_base

    base_valida:
    	addi $t3, $t3, 1    #proximo caractere
    	j verifica_loop

    base_invalida:
    	li $v0, 4
    	la $a0, msg_invalida
    	syscall
    	j encerra_execucao

    #varificacao ok
    fim_verifica:
    	jr $ra


calcula_distancia:
    li $t0, 0           #contador d posicao
    li $t6, 0           #contador diferenca
    la $t1, dna_mitocondrial
    move $t2, $s0       #string digitada

    loop_hamming:
    	lb $t3, 0($t1)      #caractere do DNA original
    	lb $t4, 0($t2)      #caractere do DNA inserido
    	beqz $t3, fim_hamming   #chegou ao fim
    
    	bne $t3, $t4, soma_diff #se diferente, soma
    	j continua_hamming

    soma_diff:
    	addi $t6, $t6, 1    #soma diferença

    continua_hamming:
    	addi $t1, $t1, 1    #prox caractere DNA original
    	addi $t2, $t2, 1    #prox caractere digitado
    	j loop_hamming

    fim_hamming:
    move $v0, $t6       #retornar o total de diferenças
    jr $ra
