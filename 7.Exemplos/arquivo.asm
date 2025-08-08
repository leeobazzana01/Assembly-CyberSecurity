# Este programa lê um arquivo até os 1024 primeiros bytes (caracteres)
# O arquivo deve estar na pasta de instalação do Mars caso não seja
# indicado o caminho completo

.data  
arquivo: .asciiz "/home/leozin/Área\ de\ trabalho/Códigos/assembly/file.txt"
buffer: .space 1024
caractere: .byte '-'

.text
# $s0: descritor do arquivo aberto
# $s1: endereço do bloco de dados do arquivo lido
# abre arquivo para leitura
	li   $v0, 13       # chamada de sistema para abrir arquivo
	la   $a0, arquivo      
	li   $a1, 0        # abrir para leitura
	li   $a2, 0
	syscall            # abre arquivo! (descritor do arquivo retornado em $v0)
	move $s0, $v0      # salva o descritor de arquivo 

# lê do arquivo
	li   $v0, 14       # chamada de sistema para ler arquivo
	move $a0, $s0      # descritor do arquivo 
	la   $a1, buffer   # endereço do buffer para receber a leitura
	move $s1, $a1      # salva ponteiro para buffer em $s1
	li   $a2, 1024     # número máximo de caracteres a serem lidos
	syscall            # executa leitura do arquivo!

# Fecha o arquivo 
	li   $v0, 16       # chamada de sistema para fechar arquivo
	move $a0, $s0      # descritor do arquivo a ser fechado
	syscall            # fecha arquivo!

# imprime conteúdo do buffer
    li $t3, 5                # contador p imprimir hifen a cada 5 caract
    add  $t0, $zero, $zero   # i = 0
    add  $t1, $s1, $t0       # inicia $t1 com ponteiro $s1
L1: 
    lb   $s3, 0($t1)          # carrega um byte do buffer em $s3
    beq  $s3, $zero, out       # se for fim de string (EOF), sai do loop
    beq  $t0, $t3, hiffen      # se i == 5, imprime hífen
    jal  imprime_caracter_em_s3  # imprime o caracter em $s3
    addi $t0, $t0, 1            # i = i + 1
    addi $t1, $t1, 1            # incrementa o ponteiro para o próximo caractere
    j    L1                     # volta ao início do loop

hiffen:
    li $v0, 4                
    la $a0, caractere          # carrega o endereço 
    syscall                    # imprime o hífen
    addi $t0, $zero, 0         #i = 0
    j L1                       #continuando o loop

out:
feito: 
    li $v0, 10                # termina o programa
    syscall                    # finaliza execução

imprime_caracter_em_s3:
    li $v0, 11                # chamada de sistema para imprimir caractere
    move $a0, $s3             # move o valor de $s3 para $a0
    syscall                   # imprime o caracter
    jr $ra                    # retorna da função
