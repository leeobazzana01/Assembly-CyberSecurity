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
Explicados com mais detalhes abaixo. Usados para operações de **MULTIPLICAÇÃO** e **DIVISAO** pois armazenam valores de 64 bits. 
#### Status (SR)
Registra o status do processador.
#### Cause
Indica a causa de uma exceção/interrupção.
#### EPC (Exception Program Counter)
Armazena o endereço de uma **instrução que causou exceção**.

## Mnemônicos de para carregar e armazenar valores na memória
São os mnemônicos usados para **ler um valor armazenado em um endereço** na memória e também para **armazenar** um valor binário em um endereço de memória. 

### lw $destino, offset($base)
Carrega no registrador destino o valor armazenado em um registrador, a partir da base (registrador usado como parâmetro) e da posição que aquele número ocupa no registrador (offset). Exemplo:
#### lw $a0, 0($t1) 
Carrega para $a0 o valor armazenado em $t1 que ocupa o offset 0 (início).
#### lw $t0, 8($s1)  
Carrega em $t0 o valor da memória no endereço ($s1 + 8)
### sw $destino, offset($base)
Armazena em $destino o valor binário que está no registrador $base no offset citado. Exemplo:
#### sw $s0, 0($t0)
Armazenamos no registrador $s0 o valor que está em $t0 no offset 0(início).
### li $destino, label
**Carrega para um registrador** o valor binário armazenado em uma label. Além disso, pode ser usado para carregar um valor inteiro para um registrador, como por exemplo: 
**li $t1, 1**
### la $destino, label
Carrega para o registrador $destino o endereço de memória da label. Muito usado quando queremos imprimir um valor armazenado nessa label, passando como argumento ($a0) para a syscall o valor que está armazenado na label. 
### mfhi $destino
Muito usado em operações de Multiplicação e Divisão. Move os bits **mais signicantes** (hi = high) para o registrador de destino.
### mflo $destino
Move os bits **menos significantes** (lo = low) para o registrador desejado.


## Operações Básicas
(add, sub, and, or, slt, addi, lui)
### Soma: add 
#### add $t2, $t1, $t0 
Para somar $t0 e $t1 em $t2.
#### addiu $t1, $t0, 1000 
Soma o 1000 ao valor inteiro armazenado em $t0 e armazena o resultado em $t1 SEM overflow.
O addiu faz o mesmo, porém com overflow. 
### Subtração: sub
#### sub $t2, $t0, $t1
Armazena o resultado de **$t0 - $t1** em **$t2**

## Multiplicação 
São operações um pouco diferente das demais graças à **capacidade de armazenamento do registrador** com que estamos lidando. Quando multiplicamos dois valores de 32 bits, por exemplo, vamos obter um resultado enorme de 64 bits(pois 2³² * 2³² = 2⁶⁴). Por isso, a estratégia do Mips é usar dois registradores para armazenar esses valores:
#### HI (High)
Armazena os 32 bits mais significantes.
#### LO (low)
Armazena os 32 bits menos significantes.
#### Bits mais significantes X menos significantes
Para explicar esse conceito, vamos  usar um número binário de 1 byte:
1 0 0 0 0 0 0 1 -> (1x2⁷) + (0x2⁶) + (0x2⁵) + (0x2⁴) + (0x2³) + (0x2²) + (0x2¹) + (1x2⁰) -> 128 + 1 = 129 
O mais significante é o "maior bit", ou seja, aquele que está **mais à esquerda** pois tem corresponde a 2⁷ (128) em um número binário, tendo **maior peso** no número. O menos significante, também conhecido como "bit de paridade", é sempre o que está mais à direita pois corresponde à 1x2⁰, ou seja, pode armazenar apenas 0 e 1.

### mult $fatorA, $fatorB
Multplica os registradores A e B e armazena a parte mais significante em HI e a menos significante em LO.
Exemplo prático:
    li $t0, 5
    li $t1, 10
    mult $t0, $t1
    mflo $s0, $t0
    mfhi $s1, $t1

### mul $produto, $fatorA, $fatorB
Multiplica e armazena **APENAS O VALOR MENOS SIGNIFICATIVO** no registrador destinado a armazenar o produto.
Exemplo:
    li $t0, 5
    li $t1, 10
    mul $s0, $t0, $t1
**Recomendado** usar **mul** para produtos que irão ter, como resultado, valores menores que 2 bilhões (2³¹, pois 1 bit armazena o sinal).

### multu $fatorA, $fatorB
Multiply Unsigned, multiplicação sem sinal. Continua armazenando os resultados em HI e LO.

## Divisão
É semelhante à multiplicação, porém no registrador LO é armazenado o **quociente** e em HI o **resto**.
### div $numerador, $denominador
Divide os valores armazenados em cada registrador e armazena em: LO quociente HI resto.
Exemplo:
    li $t0, 10
    li $t1, 3
    div $t0, $t1
    mflo $s0 #armazena o quociente em $s0, que será 3
    mfhi $s1 #armazena o resto em $s1, que será 1

### divu $numerador, $denominador
Divisão sem sinal, onde armazenamos os valores do quociente em LO e do resto em HI.

## Fluxo: Condicionais e Loops
(beq, bne, slt + branches)
### beq $registradorA, $registradorB, label
Traduzindo, significa "ramifica se for igual a". Na prática, ele é um comando usado para alterar o fluxo de execução de um código quando o valor armazenado em um registrador é igual a um valor que queremos usar como parâmetro para o desvio. Se os valores não são iguais, ele continua executando a próxima instrução normalmente. 
Exemplo: 
    beq $t0, $t1, label
    Salta para a "label" se $t0 for igual a $t1.

### bne $registradorA, $registradorB, label
**Branch not equal** irá **comparar dois registradores** e saltar para uma label caso eles não sejam iguais.
Exemplo:
    li $t0, 5
    li $t1, 10
    bne $t0, $t1, label

### bgt $rs, $rt, label	
**Brench greater than**: Salta se **maior que**. 
### blt $rs, $rt, label	
**Brench less than**: Salta se **menor que**.
### bge $rs, $rt, label
**Brench greater equal**: Salta se for **maior ou igual**.
### ble $rs, $rt, label
**Brench less equal**: Salta se for **menor ou igual**.
### bgtz $rs, label
**Brench greater than zero** para saltar se for **maior** que zero.
### bltz $rs, label
**Brench less than zero** para saltar se for **menor** que zero
### Iteradores
Para usar um registrador como variável de controle é bem simples, só preciso,  
## Funções em MIPS
(jal, jr $ra, convenção de chamada).
Para entender melhor a dinâmica, precisamos revisar o conceito de funções. Funções são blocos de código que **ESPERAM ARGUMENTOS** e **RETORNAM VALORES** a partir daqueles argumentos. Em MIPS, para trabalhar dessa forma, precisamos definir uma **lable** para a **função** e **passar um valor** (com registradores de valor, como $v0 e $v1), o endereço desse do retorno será armazenado no registrador $ra. 
### jal lable
**Jump and link** salta para uma função e armazena o endereço de retorno em $ra.
### jr lable
**Jump Register** salta para o endereço contido em $ra.
### j label 
### Trabalhando com funções
Exemplo:
    li $a0, 5 #$a0 = 5
	jal dobro #passa $a0 como argumento para a lable 'dobro', e armazena o endereço desse fluxo em $ra
	 
	move $t0, $v0 #move o valor retornado pela função para $t0
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	dobro: 
		mul $v0, $a0, 2
		jr $ra 

jump para saltar para uma label
Exemplo: 
	j fim
	fim:
    #encerra execução
    li $v0, 10
    syscall

## Mnemônicos Úteis
Alguns mnemônicos muito úteis para utlizar no dia a dia do fluxo de código:
### move registradorA, registradorB
Move o valor armazenado em um registrador B para um registrador A. Exemplo:
Exemplo
    move $a0, $s0 
    Move o valor armazenado em $s0 para $a0 para imprimirmos, por exemplo.

## Syscalls para E/S
(li $v0 + syscall para print_int, read_int, etc)

## [Exercícios Iniciante](exercicios/exercicios.txt) 
