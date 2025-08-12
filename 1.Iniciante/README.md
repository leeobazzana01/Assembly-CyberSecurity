# 1. Nível Iniciante (Fundamentos MIPS)
## Registradores e Tipos de Dados
($zero, $t0-$t9, $s0-$s7, .word, .byte, .asciiz)

### Tipos de Dados
#### Caractere: '.byte'
#### String: '.ascii' ou '.asciiz'->mais seguro 
#### Inteiro: '.word'
#### Float: '.float
#### Double: '.double'


### Registradores de Propósito Geral
Existe um total e **32 registradores** de propósito geral em Assembly.
#### 0. $zero
Sempre **armazena zero** como valor, não dá pra sobrescrever.
#### 1. $at (assembler temporary)
**RESERVADO** para o Assembler, portanto não devemos usar. 
#### 2 e 3. $v0, $v1 (value)
Armazenam **VALORES DE RETORNO** de uma função.
#### 4 - 7. $a0, $a3 (argument)
Armazenam **ARGUMENTOS** a serem passados para uma função.
#### 8- 15. $t0, $t7 (temporary)
Armazenam **VALORES TEMPORÁRIOS**, que irão ser "excluídos" após a chamada de uma função.
#### 16-23. $s0, $s7 (saved)
Variáveis **SALVAS**, portanto serão **presenvadas entre chamadas** de função.
#### 24-25. $t8, $t9 (temporary)
Mais dois **valores temporários**.
#### 26-27. $k0, $k1 (kernel)
Reservados para o sistema operacional realizar tratamento de exceções.
#### 28. $gp (Global Pointer)
Ponteiro para **Área de Dados Globais**.
#### 29. $sp (Stack Pointer)
Ponteiro para o **TOPO DA PILHA**.
#### 30. $fp (Frame Pointer)
Ponteiro para o Frame de uma função.
#### 31. $ra (Return Adress)
Armazena o **Endereço de Retorno** de uma função.

### Registradores Especiais
#### PC (Program Counter)
Mostra a próxima instrução a ser executada 
#### HI e LO 
Usados para operações de **MULTIPLICAÇÃO** e **DIVISAO** pois armazenam valores de 64 bits. 
#### Status (SR)
Registra o status do processador.
#### Cause
Indica a causa de uma exceção/interrupção.
#### EPC (Exception Program Counter)
Armazena o endereço de uma **instrução que causou exceção**.

## Mnemônicos de carregamento de variáveis
São os mnemônicos usados para **ler um valor armazenado em um endereço** na memória e também para **armazenar** um valor binário em um endereço de memória. 

### lw
### li
### la 

## Operações Básicas
(add, sub, and, or, slt, addi, lui)
### Soma: add 
#### add $t2, $t1, $t0 
Para somar $t0 e $t1 em $t2.
#### addiu $t1, $t0, 1000 
Soma o 1000 ao valor inteiro armazenado em $t0 e armazena o resultado em $t1 SEM overflow.
O addiu faz o mesmo, porém com overflow. 

## Estruturas de Controle
### Condicionais
(beq, bne, slt + branches)

### Loops
(Usando beq/bne e registradores como contadores)

## Funções em MIPS
(jal, jr $ra, convenção de chamada)
### j: jump para saltar para uma label
Exemplo: 
	j fim
	fim:
    #encerra execução
    li $v0, 10
    syscall
	

## Syscalls para E/S
(li $v0 + syscall para print_int, read_int, etc)
