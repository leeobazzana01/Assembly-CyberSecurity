# Assembly
    O repositório contém alguns códigos de Asssembly em uma Arquitetura 64bits usados para o aprendizados de Conceitos Básicos, porém essenciais, da Ciência da Computação, como: Variáveis, Controle de fluxo, Manipulação de memória, Funções, Strings, Estruturas de Dados.


## MARS MIPS Assembly Simulator - Instalação no Linux

Este repositório contém códigos em Assembly MIPS, desenvolvidos para estudo e simulação no MARS (MIPS Assembler and Runtime Simulator).

### O que é o MARS?
MARS é um simulador para código Assembly MIPS desenvolvido em Java. Ele permite escrever, simular e depurar código Assembly de forma gráfica.

### Como instalar e executar o MARS no Linux

#### 1. Baixe o MARS (arquivo `.zip`)

- Site oficial: [http://courses.missouristate.edu/kenvollmar/mars/](http://courses.missouristate.edu/kenvollmar/mars/)

#### 2. Extraia o `.zip`

```bash
unzip Mars4_5_Aug2014.zip -d ~/mars
cd ~/mars/MARS-main
```
#### 3. Compile (caso ainda não esteja compilado)
Se não houver um arquivo Mars.class, compile com:

```bash
javac Mars.java
```

#### Execute o MARS

```bash
java Mars
```

### Criando um atalho no Terminal
#### 1. Abra o terminal e edite o arquivo de configuração:

```bash
nano ~/.bashrc
```
#### 2. Adicione a seguinte linha ao final do arquivo:

``` bash
alias mars='java -cp ~/mars/MARS-main Mars'
```
#### 3. Salve e recarregue:

```bash
source ~/.bashrc
```

## Teoria de Programação com Assembly
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
## Exercícios 

## Projetos
     