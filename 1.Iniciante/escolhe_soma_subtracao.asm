.data
    msg_operacao: .asciiz ">> Choose an option:\n>> 1. Sum\n>> 2. Subtraction\n"
    msg_entrada: .asciiz "\n>> Type an Integer: "
    msg_resultado: .asciiz "\n>> Result: "
    msg_invalido: .asciiz "\n>> Invalid Operation!"
    operation: .word 0
.text 
.globl main
main:
    #menu de operações
    li $v0, 4
    la $a0, msg_operacao
    syscall
    
    #lendo a operação
    li $v0, 5
    syscall
    move $s0, $v0 #move o valor lido de $v0 para $s0
    
    # verificando se alguma operação diferente das válidas foi inserida
    li $t1, 1
    li $t2, 2
    blt $s0, $t1, invalido # se opcao <1
    bgt $s0, $t2, invalido # se opcao >2
    
    #lê n1
    li $v0, 4
    la $a0, msg_entrada
    syscall
    li $v0, 5
    syscall
    move $s1, $v0          #move valor lido de $v0 para $s1
    
    #lê n2
    li $v0, 4
    la $a0, msg_entrada
    syscall
    li $v0, 5
    syscall
    move $s2, $v0          #move valor lido em $v0 para $s2
    
    #executando opções da calculadora
    beq $s0, $t1, soma     #opção = 1, vai para soma
    beq $s0, $t2, subt     #opção = 2, vai para subt
    
soma:
    add $s3, $s1, $s2      #$s3 = $s1 + $s2
    j mostrar_resultado     #vai para label que exibe o resultado
    
subt:
    sub $s3, $s1, $s2      #$s3 = $s1 - $s2
    
mostrar_resultado:
    #mensagem do resultado
    li $v0, 4
    la $a0, msg_resultado
    syscall
    
    #imprime o valor
    li $v0, 1
    move $a0, $s3
    syscall
    
    #salta para o fim
    j fim
    
invalido:
    #opção inválida
    li $v0, 4
    la $a0, msg_invalido
    syscall
    
fim:
    #encerra execução
    li $v0, 10
    syscall