.text
main:
    li $t0, 0
    teqi $t0, 0        #exceção 13 (trap) pois $t0 contém 0
    
    break               #exceção 9 (breakpoint)
    
    li $t1, 10
    div $t1, $t1, $t0 #dividindo 10 por zero p gerar exceção, armazenando em $t1
    sw $t1, 0($t0)     #exceção 5 (address error Store)
    
    li $v0, 10
    syscall

.ktext 0x80000180
    move $k0, $v0
    move $k1, $a0
    
    mfc0 $t0, $13        #move o registrador da causa pra $t0
    srl $t0, $t0, 2      #verificando bits 2-6 para identificar a causa
    andi $t0, $t0, 0x1F  #máscara p isolar 5 bits
    
    #verificando os códigos de exceção
    beq $t0, 5, excecao_store
    beq $t0, 9, excecao_break
    beq $t0, 13, excecao_trap
   
    la $a0, msg_desconhecido
    j print_msg

excecao_store:
    la $a0, msg_store
    j print_msg

excecao_break:
    la $a0, msg_break
    j print_msg

excecao_trap:
    la $a0, msg_trap

print_msg:
    li $v0, 4
    syscall
    
    move $v0, $k0
    move $a0, $k1
    mfc0 $k0, $14
    addi $k0, $k0, 4
    mtc0 $k0, $14
    eret

.kdata
msg_store:    .asciiz "\nExceção 5: Erro endereço (Store)"
msg_break:    .asciiz "\nExceção 9: Breakpoint"
msg_trap:     .asciiz "\nExceção 13: Trap"
msg_desconhecido:  .asciiz "\nExceção desconhecida"