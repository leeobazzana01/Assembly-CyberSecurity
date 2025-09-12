# Intermediário I
## Arquivos
Para trabalhar com arquivos, precisamos executar algumas etapas de manipulação de arquivos, que são:
    1. Abrir **Syscall 13**
    2. Ler **Syscall 14**
    3. Escrever **Syscall 15**
    4. Fechar  **Syscall 16**
Além disso, teremos que declarar um **buffer** na seção de dados do código. Esse buffer será um **espaço reservado na memória** que irá **armazenar a string contida no arquivo. 

### Abertura de Arquivos
O **Syscall 13** exige alguns argumentos:
    **$a0**: **Endereço** do arquivo
    **$a1**: **Modo de abertura** (**Leitura = 0, Escrita = 1, 9 = append**)
    **$a2**: **Permissões** (ignorado para arquivos conhecidos)



## Organização da Memória
(stack, heap, data, text)

## Pilha
(uso de $sp, $fp, $ra)
## Pilhas em MIPS
($sp manipulation, push/pop convention)
Pilhas são Algoritmos que trabalham com a lógica de implementação LIFO (Last In first Out). Isso significa que o **primeiro elemento empilhado** sempre será o último a sair da  pilha, e isso funciona para a lógica inversa, o **último elemento da pilha** sempre será o **primeiro** a ser **removido (desempilhado).**
Um exemplo prático para entender a lógica:
Uma cozinha tem que lavar vários pratos sujos pela casa. Primeiro, a cozinheira **empilha** todos os pratos sujos. O primeiro prato empilhado será o último a ser lavado. Em seguida, a ordem de lavagem será justamente o mesmo algoritmo da pilha: desempilhar (remover o último elemento adicionado) e depois lavá-lo.

**Execução em memória:** 
**Registradores usados: $sp e $fp**.
A pilha na memória cresce para baixo. Então, nós somamos um valor negativo ao **$sp** para ele liberar espaço na memória para a pilha. Em seguida, iremos empilhar os valores na memória de forma a fazer a operação desejada, e depois desempilhar. Exemplo:

```asm
func:
#alocando memória
addi $sp, $sp, -12
	
#empilhando
sw $t1, 8($sp)
sw $t0, 4($sp)
sw $s0, 0($sp)
	
add $t0, $a0, $a1 #$t0 = g + h 
add $t1, $a2, $a3 #$t1 = i + j
sub $s0, $t0, $t1 #$s0 = (g+h) - (i+j)
	
add $v0, $s0, $zero
	
#desempilhando
lw $s0, 0($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
	
#free de memória
addi $sp, $sp, 12
```

## Syscalls em MIPS
(E/S, alocação)

## Arrays e Strings
(offsets, alinhamento word)
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
No código acima, declaramos um **vetor de inteiros**. Carregamos o **endereço base** em um registrador. Queremos acessar o **índice 2 do vetor**, então adicionamos 2 a um registrador, fazemos um **sll** para multiplicar 2 por 4 duas vezes. Depois, **deslocamos o endereço base** com o resultado do sll e armazenamos em um registrador. **Podemos imprimir esse valor a esse índice, ou atribuir ao índice um valor**, entre outras possibilidades.

## Structs Simples em Memória
(layout, padding, acesso por offsets)