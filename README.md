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

# Conceitos de Programação com Assembly (DEVO APRENDER)
# 1. [Nivel Iniciante-Fundamentos](/home/leozin/ciencia_computacao/assembly/1.Iniciante)

# 2. [Nível Básico-Intermediário](/home/leozin/ciencia_computacao/assembly/2.Iniciante_Intermediário)

# 3. [Nível Intermediário](/home/leozin/ciencia_computacao/assembly/3.Intermediário)

# 4. [Nível Intermediário-Avançado](/home/leozin/ciencia_computacao/assembly/4.Intermediário_Avançado)

# 5. [Nível Avançado](/home/leozin/ciencia_computacao/assembly/5.Avançado/README.md)

# 6. Nível Expert
## MIPS no Hardware
(FPGA implementations, Verilog/VHDL)

## Compiladores para MIPS
(GCC cross-compilation, backends LLVM)

## Sistemas Operacionais
(Bootloaders MIPS, context switching)

## SIMD MIPS
(MMI, uso de registradores especiais)

markdown
# Integração MIPS-Alto Nível
## Chamadas entre C e MIPS
1. **From C to MIPS**:
   ```c
   extern void mips_func();
   int main() { mips_func(); }```
2. **From mips to C**:
	```.extern c_func
		jal c_func
	```
	
## Artigos Estudados
### "Tutorial on MIPS Programming using MARS": https://profile.iiita.ac.in/bibhas.ghoshal/COA_2021/tutorials/Tutorial_MIPS_Using_MARS.pdf
## Exercícios 

## Projetos
     