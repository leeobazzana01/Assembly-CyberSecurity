# 2. Nível Básico-Intermediário
## Arrays/Vetores
(lw/sw com offset, alinhamento word)
### Alinhamento word
Consiste em **armazenar** variáveis tipo **word** sempre em endereços **múltiplos de 4**. Essa prática **melhora a eficiência e desempenho do hardware**.  
### Declarando um vetor de Inteiros
Vetores/arrays são uma **sequência de elementos** do mesmo tipo. Eles estão sempre **em sequência** na memória. Por exemplo, se temos um vetor de inteiros, **cada inteiro ocupa um total de 4 bytes**. Partindo da posição 0 (alinhamento word), nós teremos o **próximo elemento sempre em um múltiplo de 4**.  
**Exemplos de declaração**:
```
    .data
	    vetor_inteiros: .word 10, 20, 30, 40, 50
```
Acima, declaramos um **vetor de inteiros** com **valores conhecidos**.
```
    .data
        vetor_desconhecido: .space 400
```
Nesse caso, separamos um total de 400 bytes, um **vetor de 100 inteiros** com **valores desconhecidos**, que provavelmente serão **atribuídos ao longo da execução**.
### Acessando elementos
#### Com offset
```assembly
    .data
	    vetor_inteiros: .word 10, 20, 30, 40, 50
    
    .text
    .globl main
    main:
        lw $t0, 0(vetor_inteiros) #carrega em $t0 o valor da base (início, elemento de posição 0) do vetor  

        lw $t1, 8(vetor_inteiros) #carrega o terceiro elemento, na posição 8
```
#### Com índice
```assembly
    .data
	    vetor_inteiros: .word 10, 20, 30, 40, 50

    .text
        la $s0, vetor_inteiros #guarda em $s0 o endereço base
        addi $t0, $zero, 2     #queremos o índice 2, então armazenamos em um registrador

        sll $t1, $t0, 2       #deslocamos o índice 2 duas vezes, fazendo uma multiplicação por 4, resultado ent no endereço correto do índice($t1)
        add $t1, $t1, $s0     #endereço = endereço base + deslocamento

        #agora, carregamos o elemento
        lw $t2, 0($t1)        # $t2 = vetor_inteiros[2] 
```
No código acima, declaramos um **vetor de inteiros**. Carregamos o **endereço base** em um registrador. Queremos acessar o **índice 2 do vetor**, então adicionamos 2 a um registrador, fazemos um **sll** para multiplicar 2 por 4 duas vezes. Depois, **deslocamos o endereço base** com o resultado do sll e armazenamos em um registrador. **Podemos imprimir esse valor a esse índice, ou atribuir ao índice um valor**, entre outras possibilidades 

## Strings
(la para endereços, manipulação byte-a-byte)

## Structs
(Layout na memória, acesso a campos via offset)

## Algoritmos Simples
### Busca Linear
(loop com lw + beq)

### Bubble Sort
(aninhamento de loops com comparações)
Bubble Sort é um Algoritmo de Ordenação que trabalha da seguinte forma: dado um vetor de inteiros, por exemplo, ele compara o índice atual sempre com o próximo para verificar. Se o índice atual for menor, há troca de valores. Por exemplo:

Vetor V = 20, 10, 15

I - Primeira execução (20 > 10, troca)
V = 10, 20, 15
II - Segunda execução (20 > 15, troca)
V = 10, 15, 20
III - Percorre o vetor novamente, se não houver nenhuma troca, encerra o BubbleSort.

Não é o Algoritmo de ordenação mais eficiente pois 