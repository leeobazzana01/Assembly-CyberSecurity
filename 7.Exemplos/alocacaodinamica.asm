.data
    origem: .asciiz "Qualquer texto a ser copiado"
    newline: .asciiz "\n"
    
.text
main:
  #string original
    la $a0, origem      
    li $v0, 4      
    syscall
     
  #imprime '/'
    li $a0, 47     
    li $v0, 11      
    syscall
    
   #chamando MEMCOPY p copiar 
    la $a0, origem      
    jal MEMCOPY

   #imprime oq foi colocado no destino
    move $a0, $v0  
    li $v0, 4      
    syscall

    li $v0, 10
    syscall


MEMCOPY:
   #registradores da pilha
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)      #endereço de origem
    sw $s0, 8($sp)      #uso temporário
    
   #calculando tamanho da string
    move $s0, $a0       #copia origem para $s0
    li $t0, 0           #contador tamanho
    
loop_comprimento:
    lb $t1, 0($s0)      
    beqz $t1, comprimento_final 
    addi $s0, $s0, 1    #incrementa ponteiro
    addi $t0, $t0, 1    #incrementa contador
    j loop_comprimento
    
comprimento_final:
    addi $t0, $t0, 1    #add 1 p o null terminator
    
   #alocação
    move $a0, $t0       #taman alocado
    li $v0, 9           #syscall da heap 
    syscall
    
    move $t1, $v0       #salva endereço $t1
    lw $s0, 4($sp)      #restaura end origem
    
    loop_copia:
    lb $t2, 0($s0)      #carrega
    sb $t2, 0($t1)      #armazena
    beqz $t2, copia_end  #se o terminador for null termina
    addi $s0, $s0, 1    #incrementa pont origem
    addi $t1, $t1, 1    #incrementa ponteiro destino
    j loop_copia
    
copia_end:
    move $v0, $v0       #end aloc em $v0
    
    #restaura o registrador na pilha
    lw $ra, 0($sp)
    lw $s0, 8($sp)
    addi $sp, $sp, 12
    
    jr $ra              #retorna