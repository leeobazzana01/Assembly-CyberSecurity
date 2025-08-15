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

## Exercícios 
### Exercícios Gerais
1. Manipulação de Registradores
Troca de Valores
    Carregue 15 em $t0 e 25 em $t1. Troque os valores entre $t0 e $t1 sem usar registradores adicionais (dica: use operações aritméticas).
**DUVIDA**

Uso do $zero
    Carregue 100 em $s0. Use $zero para:
    Mover o valor de $s0 para $s1
    RESPOSTA: troca_valores.asm

2. Operações Aritméticas
Cálculo com Constantes
    Calcule (37 - 15) * 2 usando apenas:

    addi para constantes

    sub para subtração

    mul para multiplicação
    Armazene o resultado em $t2 e imprima.
    
    RESPOSTA: operacoes_aritmeticas.asm

Divisão com Resto
    Leia um número do usuário em $t0. Calcule:

    Quociente da divisão por 3 (armazene em $t1)

    Resto da divisão (armazene em $t2)
    Imprima ambos usando div e mfhi/mflo.

    RESPOSTA: divisao_resto.asm

3. Condicionais Básicas
    Positivo/Negativo
    Leia um número do usuário:

    Se for positivo, imprima "POSITIVO"

    Se negativo, imprima "NEGATIVO"

    Se zero, imprima "ZERO"
    Use slt e beq/bne.
    RESPOSTA: positivo_negativo.asm

Comparação Dupla
    Leia dois números A e B:

    Se A > B, imprima "MAIOR"

    Se A < B, imprima "MENOR"

    Se iguais, imprima "IGUAIS"
    Use apenas slt + branches.
    RESPOSTA: compara_inteiros.asm

4. Loops Simples
Contagem Regressiva
    Imprima números de 10 a 1 em ordem decrescente:

    Use $t0 como contador

    Decremente com addi

    Termine quando $t0 = 0
    RESPOSTA: contagem_regressiva.asm

Soma de Pares
    Some os números pares de 2 a 20:

    Use $t0 como acumulador

    Incremente de 2 em 2 com addi

    Use ble para controlar o loop
    RESULTADO: soma_pares.asm

5. Funções Simples
    Dobro de um Número
    Crie uma função dobro que:

    Recebe argumento em $a0

    Retorna o dobro em $v0

    Chame com jal passando 7
    Imprima o resultado.
    RESULTADO: funcao_dobro.asm

Verificação de Paridade
    Implemente uma função par que:

    Recebe número em $a0

    Retorna 1 em $v0 se par, 0 se ímpar

    Use andi $t0, $a0, 1 (bit menos significativo)
    Teste com números 9 e 12.
    RESULTADO: funcao_par_impar.asm

6. Desafios Práticos
Múltiplo de 5
    Leia um número e verifique se é múltiplo de 5:

    Use div e verifique se resto = 0

    Imprima "SIM" ou "NAO"
    RESPOSTA: multiplo5.asm

Potência de 2
    Leia um número n (1 ≤ n ≤ 10):

    Calcule 2^n usando loop com multiplicações

    Armazene resultado em $s0

    Exemplo: n=5 → 32
    RESULTADO: potencia2.asm

### Exercícios de Loops e Condicionais
1. Verificação de Número Positivo/Negativo
    Objetivo: Ler um número do usuário e imprimir:

    "POSITIVO" se for maior que 0.

    "NEGATIVO" se for menor que 0.

    "ZERO" se for igual a 0.
    RESPOSTA: positivo_negativo.asm

2. Comparação de Dois Números
    Objetivo: Ler dois números e imprimir:

    "A > B" se o primeiro for maior.

    "A < B" se o segundo for maior.

    "A == B" se forem iguais.

    Técnicas: slt, beq, bne.
    RESPOSTA: compara_inteiros.asm

3. Contagem de 1 a N
    Objetivo: Ler um número N e imprimir todos os números de 1 até N.

    Técnicas: Loop com addi, ble/bgt.
    RESPOSTA: zero_a_n.asm

4. Soma dos Números de 1 a N
    Objetivo: Calcular a soma dos números de 1 até N e imprimir o resultado.

    Técnicas: Loop com add, addi, ble.

Nível Intermediário (Loops Aninhados e Condicionais Complexas)
    5. Verificação de Número Primo
    Objetivo: Ler um número e verificar se é primo.

    Se for primo, imprimir "PRIMO".

    Caso contrário, "NAO PRIMO".

    Técnicas: Loop com div, mfhi, beq.

6. Fatorial de um Número
    Objetivo: Calcular o fatorial de um número N (ex: 5! = 120).

    Técnicas: Loop com mul, addi, bgt.

7. Sequência de Fibonacci
    Objetivo: Gerar os primeiros N termos da sequência de Fibonacci.

    Exemplo: N=5 → 0, 1, 1, 2, 3.

    Técnicas: Loop com add, move, ble.

8. Tabuada de Multiplicação
    Objetivo: Imprimir a tabuada de um número (ex: 5 x 1 = 5, 5 x 2 = 10, ..., 5 x 10 = 50).

    Técnicas: Loop com mul, addi, ble.

Nível Avançado (Estruturas de Controle Complexas e Otimização)
9. Máximo Divisor Comum (MDC)
Objetivo: Calcular o MDC de dois números usando o algoritmo de Euclides.

Exemplo: MDC(56, 32) = 8.

Técnicas: Loop com div, mfhi, bne.

10. Conversão de Base (Decimal para Binário)
Objetivo: Converter um número decimal em binário e imprimir os bits.

Exemplo: 10 → 1010.

Técnicas: Loop com div, mfhi, beq, manipulação de bits.

11. Bubble Sort Simples
Objetivo: Ordenar um array de inteiros usando Bubble Sort.

Exemplo: [5, 3, 8, 1] → [1, 3, 5, 8].

Técnicas: Loops aninhados, lw, sw, slt, bne.

12. Busca Binária (Binary Search)
Objetivo: Implementar busca binária em um array ordenado.

Retornar a posição do elemento ou -1 se não encontrado.

Técnicas: Loops com div, slt, beq, bne.

Desafios Extras (Para Testar Domínio)
13. Validador de Palíndromo Numérico
Objetivo: Verificar se um número é palíndromo (ex: 121 é, 123 não é).

Técnicas: Manipulação de dígitos com div, loops.

14. Gerador de Números Primos (Crivo de Eratóstenes)
Objetivo: Imprimir todos os números primos até N.

Técnicas: Loops aninhados, arrays, div, mfhi.

15. Simulador de Jogo "Adivinhe o Número"
Objetivo: Gerar um número aleatório (usando syscall) e permitir que o usuário adivinhe.

Dizer se o palpite é maior, menor ou correto.

Técnicas: Loop, beq, bgt, blt.
### Exercícios de Funções
1. Função Soma Simples
Objetivo: Criar uma função soma que recebe dois números em $a0 e $a1 e retorna a soma em $v0.

Exemplo:

mips
jal soma    # Chama a função com $a0=3, $a1=5
# Deve retornar $v0 = 8
2. Função Máximo entre Dois Números
Objetivo: Implementar uma função max que retorna o maior entre dois números (passados em $a0 e $a1).

Dica: Use slt e branches condicionais.

3. Função Fatorial (Iterativo)
Objetivo: Criar uma função fatorial que calcula o fatorial de $a0 (não recursivo).

Exemplo:

mips
addi $a0, $zero, 5   # 5! = 120
jal fatorial
# $v0 deve conter 120
4. Função Verifica Paridade
Objetivo: Função eh_par que retorna 1 se $a0 é par, 0 se ímpar.

Dica: Use andi $v0, $a0, 1.

Nível Intermediário (Funções com Manipulação de Memória)
5. Função Troca Valores
Objetivo: Função troca que recebe dois endereços de memória (em $a0 e $a1) e troca seus valores.

Exemplo:

mips
la $a0, num1    # Suponha num1 = 10
la $a1, num2    # Suponha num2 = 20
jal troca       # Agora num1 = 20, num2 = 10
6. Função Calcula Média
Objetivo: Função media que recebe um array de inteiros (endereço em $a0, tamanho em $a1) e retorna a média em $v0.

Dica: Use um loop para somar elementos e div para calcular a média.

7. Função String Length (strlen)
Objetivo: Implementar strlen que retorna o comprimento de uma string (terminada em \0).

Exemplo:

mips
la $a0, mensagem   # "Hello" → 5
jal strlen
# $v0 = 5
8. Função Potência (Exponenciação)
Objetivo: Função potencia que calcula $a0 ^ $a1 (ex: 2^3 = 8).

Dica: Use um loop com mul.

Nível Avançado (Funções Recursivas e Convenções)
9. Função Fatorial Recursivo
Objetivo: Refazer o fatorial, agora com recursão.

Código Base:

mips
fat_recursivo:
    # Caso base: se $a0 <= 1, retorne 1
    # Senão: return $a0 * fat_recursivo($a0 - 1)
10. Função Fibonacci Recursivo
Objetivo: Implementar Fibonacci recursivo (fib(n) = fib(n-1) + fib(n-2)).

Exemplo:

mips
addi $a0, $zero, 5   # fib(5) = 5
jal fib
# $v0 = 5
11. Função Ackermann (Desafio Recursivo)
Objetivo: Implementar a função de Ackermann (usada para testar recursão):

text
A(m, n) = 
    n + 1               se m = 0
    A(m-1, 1)           se m > 0 e n = 0
    A(m-1, A(m, n-1))   caso contrário
Teste: A(2, 3) = 9.

12. Função QuickSort (Recursivo)
Objetivo: Implementar o algoritmo QuickSort para ordenar um array.

Dica: Use $a0 = endereço do array, $a1 = índice inicial, $a2 = índice final.

Desafios Extras (Aplicações Reais)
13. Função Converter para Hexadecimal
Objetivo: Função para_hex que converte um número em $a0 para uma string hexadecimal (ex: 255 → "FF").

Dica: Use divisões por 16 e mapeie restos para caracteres (0-9, A-F).

**14. Função Calculadora (Operações +, -, , /)*
Objetivo: Função calculadora que recebe dois números e um operador (como caractere em $a2), retornando o resultado.

Exemplo:

mips
addi $a0, $zero, 10
addi $a1, $zero, 5
addi $a2, $zero, '*'   # 10 * 5 = 50
jal calculadora
# $v0 = 50
15. Função Busca em Matriz
Objetivo: Função busca_matriz que busca um valor em uma matriz 3x3 (armazenada como array linear).

Retorno: Posição (linha, coluna) ou -1 se não encontrado.
### Exercícios de Pilhas
1. Implementação Básica de Pilha
Objetivo: Criar uma pilha estática (array) e implementar:

push($a0): Insere um valor no topo (usa $sp).

pop(): Remove e retorna o valor do topo (em $v0).

Exemplo:

mips
push(10) → push(20) → pop() → Retorna 20
2. Verificação de Pilha Vazia
Objetivo: Função is_empty que retorna 1 se a pilha estiver vazia, 0 caso contrário.

Dica: Compare $sp com o endereço base da pilha.

3. Inversão de uma String
Objetivo: Usar uma pilha para inverter uma string (ex: "ABC" → "CBA").

Passos:

Empilhar cada caractere.

Desempilhar e reconstruir a string.

Nível Intermediário (Aplicações Clássicas)
4. Verificador de Parênteses Balanceados
Objetivo: Dada uma string com (, ), [, ], {, }, verificar se os delimitadores estão balanceados.

Exemplo:

Válido: "( [ { } ] )"

Inválido: "( [ ) ]"

Dica: Use a pilha para rastrear abertura de delimitadores.

5. Conversão Infixa para Pós-fixa (Notação Polonesa)
Objetivo: Converter expressões aritméticas infixas (ex: A + B * C) para pós-fixa (A B C * +).

Algoritmo: Algoritmo de Shunting-yard.

Desafio: Lidar com precedência de operadores (* > +).

6. Avaliação de Expressões Pós-fixas
Objetivo: Calcular o resultado de uma expressão pós-fixa (ex: 3 4 + 5 * → 35).

Passos:

Empilhar operandos.

Ao encontrar operador, desempilhar dois valores, aplicar operação e empilhar resultado.

Nível Avançado (Implementações Complexas e Otimizações)
7. Pilha com Alocação Dinâmica
Objetivo: Implementar uma pilha que cresce dinamicamente (usando sbrk ou alocação manual).

Desafio: Redimensionar a pilha quando estiver cheia.

8. Pilha Mínima (Min Stack)
Objetivo: Pilha que suporta push, pop e get_min (retorna o menor elemento em O(1)).

Exemplo:

mips
push(5), push(3), get_min() → Retorna 3
pop(), get_min() → Retorna 5
9. Simulação de Recursão usando Pilha
Objetivo: Implementar o fatorial iterativo usando uma pilha para simular chamadas recursivas.

Passos:

Empilhar n.

Enquanto pilha não vazia, desempilhar, calcular e empilhar n-1.

Desafios Extras (Aplicações Práticas)
10. Torre de Hanói
Objetivo: Resolver o problema das Torres de Hanói usando pilhas para representar os pinos.

Regras:

Mover um disco por vez.

Não colocar disco maior sobre menor.

Saída: Imprimir cada movimento (ex: "Mover disco 1 de A para C").

11. Undo/Redo (Editor de Texto)
Objetivo: Simular um sistema de undo/redo com duas pilhas:

Undo Stack: Armazena ações realizadas.

Redo Stack: Armazena ações desfeitas.

Operações:

inserir_char(c): Empilha em undo_stack.

undo(): Move topo de undo_stack para redo_stack.

redo(): Move topo de redo_stack de volta para undo_stack.

12. Pilha de Chamadas (Call Stack)
Objetivo: Simular a call stack do MIPS para uma função recursiva (ex: Fibonacci).

Implementação:

Empilhar $ra, $a0, e outros registradores antes de cada chamada.

Desempilhar para restaurar o contexto.

