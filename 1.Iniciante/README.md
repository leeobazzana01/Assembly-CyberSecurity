# 1. Nível Iniciante (Fundamentos MIPS)
## Registradores e Tipos de Dados
($zero, $t0-$t9, $s0-$s7, .word, .byte, .asciiz)
### Input/Output de Dados
    Um programa nada mais é, na maioria das vezes, que um Algoritmo executando Entrada, Processamento e Saída de Informações.
    Em Assembly, ao contrário de outras Linguagens de Programação Interpretadas com tipagem Dinâmica, para usar uma varíavel temos que: Declarar a variável, o seu tipo e manipulá-la nos Registradores da Memória (endereços que armazenam os Dados).

#### Seu primeiro Código: "Hello World!"
```
.data                               #cabeçalho do código, onde estão os dados (.data) 
	message: .asciiz "Hello World"  #variável de nome 'message' do tipo asciiz com as strings "Hello World!"
.text                               #texto do código, onde está o corpo do código, funções, loops, etc
	li $v0, 4                       # 'li' = load imediate, $v0 define qual operação será executada (4= imprimir string) na chamada da função/syscall
	la $a0, message                 #'la' = load adress, carrega o endereço $a0, registrador usado para passar argumentos para syscalls, e atribui a ele a LABEL "message"
	syscall                         #chama o sistema para imprimir a variável message
```
#### Imprimindo um Caractere
```
.text 
	li $v0, 11 #carrega (load imediate)  o valor  11 (instrução para printar um caractere) ao registrador $v0, é responsável por passar um argumento à função no syscall
	la $a0, 'a' #carrega p o registrador $a0 o endereço de memória de 'a'. Não usamos label porque a syscall 11 espera um valor ASCII 
	syscall  
```
	No código acima, imprimimos um caractere de forma direta. Note que a instrução 11 espera um valor ASCII, por isso não usamos uma label com o caractere.

```
.data
	character: .asciiz "a"

.text
	li $v0, 11
	lb $a0, character #load byte carrega o valor binário da label para o registrador $a0, tornando possível a execução
	syscall
```
	Acima, temos um exemplo da impressão de um caractere usando uma label. É muito importante lembrar que só foi possível pois convertemos o valor armazenado pela label (que seria normalmente um endereço de memória) para o valor binário. Isso foi o que possibilitou a impressão. 

```
.data
	character: .asciiz "a"

.text
	li $v0, 11
	la $a0, character #Apesar do código rodar normalmente, não haverá a impressão de caractere. 
	syscall
```
	Código acima apresentará um erro, com erro

#### Imprimindo um valor inteiro
```
.data
	idade: .word 23 #variável inteira é do tipo 'word' em assembly
.text
	li $v0, 1 #carrega (load imediate) para o registrador $a0 o valor 1, intrução para imprimirmos um inteiro
	la $a0, idade # carrega (load adress) para o registrador $a0 o endereço da lable idade
	syscall 
```
	O código acima possui um erro. A instrução '1' espera um valor inteiro como argumento, como passamos o endereço (load adress) da lable, ele tentará imprimir o valor inteiro desse endereço. 

```
.data
    idade: .word 23   #declara uma variável inteira (32 bits) com valor 23

.text
    li $v0, 1         #syscall 1 (imprimir inteiro)
    lw $a0, idade     #carrega o VALOR (load word) armazenado em 'idade' em $a0
    syscall
```
	Código correto, sem erros, feito acima

## Operações Básicas
(add, sub, and, or, slt, addi, lui)

## Estruturas de Controle
### Condicionais
(beq, bne, slt + branches)

### Loops
(Usando beq/bne e registradores como contadores)

## Funções em MIPS
(jal, jr $ra, convenção de chamada)

## Syscalls para E/S
(li $v0 + syscall para print_int, read_int, etc)
