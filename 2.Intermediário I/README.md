# Intermediário I
## Arquivos

### Syscalls para Manipulação de Arquivos

**Syscall	    Descrição   	Argumentos**
13	          Abrir arquivo	    $a0 = endereço do nome do arquivo
                                $a1 = modo (0 leitura, 1 escrita, 9 append)
                                $a2 = permissões (geralmente 0)

14	           Ler arquivo  	$a0 = descritor do arquivo (não o endereço!)
                                $a1 = endereço do buffer
                                $a2 = número de bytes a ler

15	           Escrever        	$a0 = descritor do arquivo
                                $a1 = endereço do buffer de escrita
                                $a2 = número de bytes a escrever

16	         Fechar arquivo	    $a0 = descritor do arquivo

Além das syscall acima, é muito importante também **ENCAMINHAR O PATH CORRETO** do arquivo, usando sempre **//** onde tiver uma barra. Exemplo:
.data
    arquivo: .asciiz "//home//leozin//ciencia_computacao//assembly//2.Intermediário I//exercicios//arquivo.txt" #endereço do arquivo


## Organização da Memória
(stack, heap, data, text)
Em assembly, temos alguns segmentos que **estruturam o código do nosso programa.** Exemplo:
**.text**: código do nosso programa.
**.data**: seção onde declaramos as variáveis do programa.
**heap**: Área de memória **alocada dinamicamente**. Cresce para cima (para endereços maiores). Persiste até ser liberada.
**stack**: região da memória que armazena funções, variáveis, entre outros, usando o princípio do **Algoritmo de Pilha** (empilhar e desempilhar). **Cresce para baixo, para endereços menores**. Usa o princípio LIFO (**last in, first out**)

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

```assembly
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
Uma  **struct** é uma **estrutura de dados** bastante simples, onde podemos criar um formato de dado que armazena vários tipos de dados diferentes que são as características desse dado. Por exemplo, a **struct pessoa em C**:
```C
struct Pessoa{
    int idade;
    int altura;
    char codigo;
};
```

Em Assembly, o que iremos fazer é **reservar espaço na memória para a struct** e depois **calcular os offsets e paddings**. Como exemplo, basta adotar o código abaixo: 
```Assembly

.data
    pessoa: .space 12 #reservando 12 bytes para a struct pessoa 
    header: .asciiz "Preenchendo os dados da struct\n"
.text
.globl main
main:
    li $v0, 4
    la $a0, header
    syscall

    la $t0, pessoa

    #atribuindo valores para os campos da struct
    li $t1, 23
    lw $t1, 0($t0)

    li $t2, 170
    l2 $t2, 4($t0)

    li $t3, 'A'
    sb $t3, 8($t0)

    #ler valores dos campos
    lw $t2, 0($t0)      # $t2 = pessoa.idade
    lw $t3, 4($t0)      # $t3 = pessoa.altura
    lb $t4, 8($t0)      # $t4 = pessoa.codigo

encerra_execucao:
    li $v0, 10
    syscall
```