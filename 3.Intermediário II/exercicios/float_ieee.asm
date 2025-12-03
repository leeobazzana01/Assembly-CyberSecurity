.data
	header: .asciiz "GERANDO O PADRÃO IEEE DE NÚMEROS FLOAT\n"
	msg_entrada:     .asciiz "Insirer um número float (no formato .): "
	s_msg:      .asciiz "\nS (sinal): "
	e_msg:      .asciiz "\nE (expoente, 8 bits): "
	f_msg:      .asciiz "\nF (mantissa, 23 bits): "
	newline:    .asciiz "\n"

.text
.globl main

main:
    #header
    li $v0, 4
    la $a0, header
    syscall
    
    
    #solictar entrada de um numero float
    li $v0, 4
    la $a0, msg_entrada
    syscall
    
    #lendo valor float
    li $v0, 6
    syscall                 #valor lido vai p $f0
    
    #converte float p inteiro (bit pattern)
    mfc1 $t0, $f0          #$t0 c os 32 bits do float
    
    #deslocamento p obter o bit de sinal
    srl $t1, $t0, 31       #$t1 é 0 ou 1
    
    #extraindo expoentes
    sll $t2, $t0, 1        #elimina o bit de sinal
    srl $t2, $t2, 24       # $t2 = E (8 bits, deslocado para LSB)
    
    #extrai mantissa f
    sll $t3, $t0, 9
    srl $t3, $t3, 9        #$t3 = F (23 bits, deslocado para LSB)
    
    #mostra msg do valor de s
    li $v0, 4
    la $a0, s_msg
    syscall
    
    #imprime o valor
    li $v0, 1
    move $a0, $t1
    syscall
    
    #imprime E em binario
    li $v0, 4
    la $a0, e_msg
    syscall
    
    move $a0, $t2          #expoente
    li $a1, 8              #8 bits p imprimir
    jal imprime_binario
    
    #mostra msg de impressao do f
    li $v0, 4
    la $a0, f_msg
    syscall
    
    move $a0, $t3          #valor da mantissa
    li $a1, 23             #23 bits p imprimir
    jal imprime_binario
    
    #\n
    li $v0, 4
    la $a0, newline
    syscall
    
encerra_execucao:

    li $v0, 10
    syscall

#imprime numero em binario
#$a0 = valor $a1 = n d bits p imprimir
imprime_binario:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    
    move $s0, $a0          #valor
    move $s1, $a1          #contador de bits
    
    #mascara p extrair bit mais significativo
    li $t4, 1
    addi $t5, $s1, -1
    sllv $t4, $t4, $t5     #$t4 = mascara inicial
    
print_loop:
    beqz $s1, fim_print    #contador = 0, termina
    
    #extrai bit atual
    and $t6, $s0, $t4
    srlv $t6, $t6, $t5     #deslocar p lsb
    
    #imprime bit 0 ou 1
    li $v0, 1
    move $a0, $t6
    syscall
    
    #atualiza mascara
    srl $t4, $t4, 1        #move mascara p prox
    addi $t5, $t5, -1      #ajusta desloc
    addi $s1, $s1, -1      #decrementando o contador
    
    j print_loop

fim_print:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra
