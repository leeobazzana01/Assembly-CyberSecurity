# Intermediário

## Execeções ASSEMBLY

Existem alguns registradores que tratam essas exceções com um **VETOR**.
O **vetor** contém uma **tabela com os erros padrão**, que por sua vez possui um endereço.
Esse endereço contém todos os "tipos" de bugs, exemplo:

1- Instrução não encontrada
2- Endereço não encontrado

No simulador **mars**, podemos encontrar as exceções em **EXCEPTIONS**.

Os registraodores que trabalham com essas exceções são:

1. status - **Coprocessor 0 do registrador $12**, setado no bit 1.
2. causa - **Coprocessor 0 do registrador $13**, setado nos bits 2 a 6 com os **TIPOS DE EXCEÇÃO**.
3. endereço - **Coprocessor 0 no registrador $14**, com o **ENDEREÇO DA INSTRUÇÃO COM EXCEÇÃO**.

Na prática, funciona da seguinte forma: 
1- Registrador 12 aponta erro **exceção**.
2- Registrador 13 contém **qual a exceção**.
3- Mostra o endereço da instrução com erro.

Quando o erro acontece, o endereço padrão **0x80000180** contém o que ocorreu de erro.
Ele fica na **região de kernel**.

Código demonstrando os exemplos:
Pasta de exercícios, código **excecoes_padrao.asm**.	 

## Manipulação de Ponto Flutuante

Os processadores possuem registradores específicos para armazenar dados no formato de ponto flutuante.

No mips, há um **banco de registradores exclusivo** para números float, que são manipulados por um **Coprocessador específico**.

Esses registradores usam, ao invés de 32 bits, um total de 64 bits. Para isso, o **mips combina dois regristradores 'normais'**.

Os registradores são: **$f0 até $f32**.

**Instruções** são terminadas em '.s' no final. As principais(mais simnples) são:

**1. add.s**
**2. sub.s**
**3. mul.s**
**4. div.s**
**5. abs.** para módulo
**6. neg.s** para not

Geralmente todas as operações que são feitas no mips normalmente, são as mesmas, mas terminadas em **.s**.

##Ponteiros em MIPS
(la vs lw, endereçamento indireto)

## Alocação de Memória
(.data vs .text, syscall 9 para heap)

## Listas Encadeadas
(nós com word para dado + word para próximo)

## Recursão
(Uso da pilha para $ra e argumentos)

## Algoritmos Intermediári  os
### Insertion Sort
(manipulação de ponteiros na memória)

### Merge Sort
(recursão + manipulação complexa de arrays)
