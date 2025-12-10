#declarando os dados do projeto
.data
	#USAR O CAMINHO ABSOLUTO CASO CONTRÁRIO DA ERRO
    nome_arquivo:   .asciiz "/home/leonardo/ciencia_computacao/assembly/4.Avançado I/exercicios/arquivo_fcs.txt" #nome arquivo
    
    #declarando os buffers p armazenar
    
    #B1 com 256 bytes lidos do arquivo
    bufferB1:   .space 256
    
    #B2 c 256 bytes de paridade 
    bufferB2:   .space 256

    #mensagens pro usuario
    header: .asciiz "ERROS FRAME CHECK SEQUENCE (FCS)\n\n"
    msg_erro:    .asciiz "Erro ao abrir o arquivo\nVerifique o nome correto e se ele existe.\n"
    msg_fcs:    .asciiz "\n\nValor Final do FCS (XOR de B1): "
    msg_par:    .asciiz "Conteudo de B2 (Paridades):\n"
    espaco:      .asciiz " "
    newline:    .asciiz "\n"

.text
.globl main

main:

	#imprimindo o cabeçalho
	li $v0, 4
	la $a0, header
	syscall
    
    #abre arquivo c syscall 13
    li   $v0, 13          #diretiva pra abrir
    la   $a0,  nome_arquivo   #nome do arqv
    li   $a1, 0           #$a0 é 0 pois ele só deve abrir
    li   $a2, 0           #abre no modo apenas leitura
    syscall

    #confere erro se $v0 < 0 chama erro
    blt  $v0, $zero, erro_arquivo
    
    #se nao tiver zero
    move $s6, $v0         #salva o descritor do arquivo em $s6 

    #lendo arquivo c a chamada 14
    li   $v0, 14          
    move $a0, $s6         #descritor (endereço) do arquivo
    la   $a1, bufferB1    #buffer destino B1
    li   $a2, 256         #qtdade bytes 
    syscall

    #fecha arquivo c syscall 16
    li   $v0, 16          
    move $a0, $s6         #descritor (end) do arquivo a ser fechado
    syscall

    #processamento p cqlculo de FCS e paridade
    
    #inicializa registradores
    la   $s0, bufferB1    #$s0 aponta p começo de B1
    la   $s1, bufferB2    #$s1 p começo de B2
    
    li   $s2, 0           #$s2 sera o contador do loop
    li   $s3, 0           #$s3 acumulalador fcs

#loop do processo q calcula a paridade
loop_processo:
    beq  $s2, 256, encerra_processo  #contador == 256 termina o loop

    #lendo byte b1
    addu $t0, $s0, $s2    #end = base B1 + contador
    lbu  $t1, 0($t0)      #carrega byte em $t1 

    #calcula fcs c um xor, retorna 1 se os bits forem diferentes e 0 se forem iguais
    xor  $s3, $s3, $t1    #fcs = fcs xoe byte atual

    #calculando paridade par do byte
    # Algoritmo: XOR de todos os bits do byte resulta na paridade
    # Se resultado for 1 (ímpar 1s), paridade é 1. Se 0, paridade é 0.
    
    move $t2, $t1         #move byte p $t2
    li   $t3, 0           #$t3 eh o bit de paridade final
    li   $t4, 8           #contador d 8 bits

#loop c 8 execuções p calcular bits de paridade
calcula_paridade:
    andi $t5, $t2, 1      #extraindo o bit menos significativo
    xor  $t3, $t3, $t5    #xor c paridade acumulada
    srl  $t2, $t2, 1      #shift p direita p ir pro pox bit
    subi $t4, $t4, 1      #contador--
    bnez $t4, calcula_paridade #continua loop até resultar em 8 bits

    #guarda paridade em B2
    addu $t6, $s1, $s2    #end = base b2+contador
    sb   $t3, 0($t6)      #store p salvar o bit (0 ou 1)

    #prox iteracao do processo
    addi $s2, $s2, 1      #contador processo++
    j    loop_processo

encerra_processo:
    #imprime b2
    li   $v0, 4
    la   $a0, msg_par
    syscall

    li   $s2, 0           #volta contador p zero p imprimir

loop_imprime:
	#p encerrar dps de 255 iterações
    beq  $s2, 256, imprime_fcs
    
    #carrega b2
    addu $t0, $s1, $s2
    lbu  $a0, 0($t0)      #argumento p imprimir o int
    
    #imprime int 0 ou 1
    li   $v0, 1
    syscall

    #imprime espaco p facilitar leitura
    li   $v0, 4
    la   $a0, espaco
    syscall

    addi $s2, $s2, 1
    j    loop_imprime

#imprime o fcs final
imprime_fcs:
    li   $v0, 4
    la   $a0, msg_fcs
    syscall

    move $a0, $s3         #move valor p $a0
    li   $v0, 1           #imprime valor inteiro
    syscall

    j    encerra_execucao

erro_arquivo:
    li   $v0, 4
    la   $a0, msg_erro
    syscall

encerra_execucao:
    li   $v0, 10          #chamada 10 de sistema p encerrar
    syscall