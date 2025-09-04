.data  
    arquivo: .asciiz "//home//leozin//ciencia_computacao//assembly//2.Iniciante_Intermediário//exercicios//arquivo.txt"
    buffer: .space 1024
    newline: .asciiz "\n"
    erro_msg: .asciiz "Erro ao abrir arquivo!\n"
    msg_bytes: .asciiz "Número de Bytes: "

.text
# $s0: descritor do arquivo aberto
# $s1: endereço do buffer
# $s2: conta os bytes lidos

main:
    # abre arquivo para leitura
    li   $v0, 13       # syscall para abrir arquivo
    la   $a0, arquivo      
    li   $a1, 0        # modo leitura
    li   $a2, 0        # ignorado
    syscall
    move $s0, $v0      # salva descritor do arquivo
    
    # verifica abertura do arquivo
    bltz $s0, erro_abertura
    
    la   $s1, buffer   # endereço do buffer
    li   $s2, 0        # contador de bytes lidos = 0

leitura_loop:
    #lê 1 byte do arquivo
    li   $v0, 14       # syscall para ler arquivo
    move $a0, $s0      # descritor do arquivo
    addu $a1, $s1, $s2 # endereço atual no buffer
    li   $a2, 1        # lê apenas 1 byte
    syscall
    
    #verifica se o $v0 = 0(final do arquivo)
    lb   $t0, 0($a1)      # carrega o byte lido
    beqz $t0, fim_leitura # se byte = 0, termina
    
    #incrementa contador e verifica se buffer está cheio
    addi $s2, $s2, 1
    li   $t0, 1023
    bge  $s2, $t0, fim_leitura # se buffer cheio, termina
    
    j    leitura_loop     # continua lendo

fim_leitura:
    #fecha arquivo
    li   $v0, 16
    move $a0, $s0
    syscall
    
    #null terminator no final do buffer
    addu $t0, $s1, $s2
    sb   $zero, 0($t0)
    
    #imprime conteúdo do buffer
    li   $v0, 4
    la   $a0, buffer
    syscall
    
    #\n
    li   $v0, 4
    la   $a0, newline
    syscall
    
    #mostra n° de bytes lidos
    li   $v0, 4
    la   $a0, msg_bytes
    syscall
    
    li   $v0, 1
    move $a0, $s2
    syscall
    
    li   $v0, 4
    la   $a0, newline
    syscall
    

feito:
    li   $v0, 10
    syscall

erro_abertura:
    li   $v0, 4
    la   $a0, erro_msg
    syscall
    j    feito