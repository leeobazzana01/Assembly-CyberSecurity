# Assembly 
Com foco no aprendizado de Assembly no Microprocessador Mips de 32 bits, o repositório aborda desde os conceitos básicos e fundamentais como lógica de programação, Manipulação de Dados na Memória, Alocação Dinâmica, Algoritmos fundamentais, até a Engenharia Reversa e desmontagem de Binários, Vulnerabilidades de Memória, entre outros tópicos essenciais. 
O Objetivo do repositório e dar uma boa base aos leitores e um bom entendimento com base em projetos e códigos desenvolvidos.  


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

## Roadmap de Programação com Assembly 
### [1. Registradores e fluxo.](1.Básico/README.md)

### [2. Memória e pilha.](2.Intermediário%20I/README.md)

### [3. Funções e chamadas.](3.Intermediário%20II/README.md)

### [4. Loops e condições.](4.Avançado%20I/README.md)

### [5. Segurança e exploits.](5.Avançado%20II/README.md)

### [6. Reversão e malware.](6.Expert/README.md)

	
## Artigos Estudados
### "Tutorial on MIPS Programming using MARS": https://profile.iiita.ac.in/bibhas.ghoshal/COA_2021/tutorials/Tutorial_MIPS_Using_MARS.pdf
## Exercícios 

## Projetos
     