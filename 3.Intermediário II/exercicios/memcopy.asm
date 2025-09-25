.data
    origem: .asciiz "Qualquer texto a ser copiado"
.text
main:
    # imprime string origem
    la $a0, origem      
    li $v0, 4      
    syscall
    
    # imprime '/'
    li $a0, 47     
    li $v0, 11      
    syscall
    
    la $a0, origem      
    jal MEMCOPY  #faz a copia entre blocos

    # imprime o conteúdo da área destino
    move $a0, $v0  
    li $v0, 4      
    syscall

    li $v0, 10
    syscall # feito!

MEMCOPY:  
    #endereço base do vetor (a[0]) = $t0
    move $t0, $a0
    move $t5, $a0
    
    li $t1, 0 #contador de bytes
    
contagem_caracteres:
    #loop para contar qtos caracteres a string possui
    
    lb $t2, 0($t0) #carrega o a[0]
    
    addi $t1, $t1, 1 #$t1 += 1
    add $t0, $t0, 1 #adicionar 1 ao endereço de memória
    
    bne $t2, $zero, contagem_caracteres #se $t2 não for zero, volto ao loop

alocacao_dinamica:
    #alocação dinâmica do bloco
     
    li $v0, 9
    move $a0, $t1
    syscall
     
    #o endereço do bloco alocado está em $s0
    move $s0, $v0
     
    li $t3, 0 #deslocamento 
copia_bloco:
    
    #deslocamento + base vetor original
    add $t7, $t5, $t3  # calcula endereço origem sem modificar $t5
    
    #deslocamento no bloco de memória alocado 
    add $s1, $s0, $t3
    
    lb $t6, 0($t7)     # carrega byte do endereço calculado
    
    #armazenando o caractere do array na posição respectiva do bloco
    sb $t6, ($s1)
    
    addi $t3, $t3, 1
    
    bne $t3, $t1, copia_bloco
    
    #movendo o endereço do blloco alocado para o valor da função
    move $v0,$s0 

    jr   $ra     # termina o procedimento