.data  
    arquivo: .asciiz "//home//leozin//ciencia_computacao//assembly//2.Intermediário I//exercicios//arquivo.txt"
    arquivo_destino: .asciiz "//home//leozin//ciencia_computacao//assembly//2.Intermediário I//exercicios//arquivo_copia.txt"
    buffer: .space 1
    newline: .asciiz "\n"
    erro_msg: .asciiz "Erro ao abrir arquivo!\n"
    msg_bytes: .asciiz "Número de Bytes: "

.text
# $s0: descritor do arquivo aberto
# $s1: endereço do buffer
# $s2: conta os bytes lidos
# $s6: descritor do arquivo de destino

main:
    # abre arquivo para leitura
    li   $v0, 13       # syscall para abrir arquivo
    la   $a0, arquivo      
    li   $a1, 0        # modo leitura
    li   $a2, 0        
    syscall
    move $s0, $v0     
    
    # Abre arquivo ESCRITA
    li   $v0, 13       # syscall p abrir
    la   $a0, arquivo_destino  
    li   $a1, 1        # abertura p escrita (flags são 0: read, 1: write)
    li   $a2, 0       
    syscall            # abre arquivo (descritor do arquivo retornado em $v0)
    move $s6, $v0       
    
    # verifica abertura do arquivo
    bltz $s0, erro_abertura
    
    la   $a1, buffer   # endereço do buffer
    li   $s2, 0        # contador de bytes lidos = 0

leitura_loop:
    #lê 1 byte do arquivo
    li   $v0, 14       # syscall para ler arquivo
    move $a0, $s0      # descritor do arquivo
    li   $a2, 1        # lê apenas 1 byte
    syscall
    
    #verifica se o $v0 = 0(final do arquivo)
    lb   $t0, 0($a1)      # carrega o byte lido
    beqz $t0, fim_leitura # se byte = 0, termina
    
    # Escreve no arquivo aberto
    li   $v0, 15       # syscall p abrir
    move $a0, $s6      # descritor 
    li   $a2, 1        # número caracteres
    syscall            # escreve! 
    
    #incrementa contador e verifica se buffer está cheio
    addi $s2, $s2, 1
    li   $t0, 1023
    bge  $s2, $t0, fim_leitura # se buffer cheio, termina
    
    j    leitura_loop     # continua lendo

fim_leitura:
    #fecha arquivo de leitura
    li   $v0, 16
    move $a0, $s0
    syscall
    
    #Fecha o arquivo ESCRITA
    li   $v0, 16       # chamada de sistema para fechar o arquivo
    move $a0, $s6      # descritor do arquivo a ser fechado
    syscall            # fecha arquivo!
    
    #null terminator no final do buffer
    #addu $t0, $s1, $s2
    #sb   $zero, 0($t0)
    
    #imprime conteúdo do buffer
    #li   $v0, 4
    #la   $a0, buffer
    #syscall
    
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
