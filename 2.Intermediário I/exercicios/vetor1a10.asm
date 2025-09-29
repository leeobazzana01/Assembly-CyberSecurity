.data
    vetor: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    header: .asciiz "Preenchendo um vetor com 1 ao 10\n"
    resultado: .asciiz "Resultado: "
    espaco: .asciiz " "
.text
.globl main
main:
    li $v0, 4
    la $a0, header
    syscall
    
    # contador 
    li $t0, 1 
    
    # carregando endereço do vetor
    la $s0, vetor  

preenche_vetor: 
    # adiciona valor ao vetor
    sw $t0, 0($s0)
    
    #avança para o próximo elemento 
    addi $s0, $s0, 4 
    
    # contador ++ 
    addi $t0, $t0, 1
    
    bne $t0, 11, preenche_vetor
    
imprimindo_vetor:
    la $s1, vetor
    li $t1, 0
    
    li $v0, 4
    la $a0, resultado
    syscall
    
loop_impressao:
    #carrega o valor do vetor para impressão
    lw $a0, 0($s1)
    li $v0, 1
    syscall
    
    # imprime espaço
    li $v0, 4
    la $a0, espaco
    syscall
    
    # avança p próximo elemento
    addi $s1, $s1, 4
    
    #incrementa contador
    addi $t1, $t1, 1
    
    bne $t1, 10, loop_impressao
    
encerrando_execucao:
    li $v0, 10
    syscall