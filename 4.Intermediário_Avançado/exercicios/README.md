# Exercícios

## Pilhas
### 1. (Fácil) Verificador de Parênteses Balanceados

Problema: Escreva um programa em Assembly que leia uma string de entrada e verifique se os parênteses ( ) nela estão balanceados. O programa deve usar uma pilha para rastrear a abertura de parênteses e determinar se para cada ( existe um ) correspondente na ordem correta.

### 2. (Médio) Avaliador de Expressões Pós-fixadas (RPN)

Problema: Implemente um programa em Assembly que avalie uma expressão aritmética fornecida na notação pós-fixada (Notação Polonesa Reversa - RPN). A expressão de entrada será uma string com operandos (dígitos de 0 a 9) e operadores (+, -, *, /), separados por espaços. Use uma pilha para armazenar os operandos e calcular o resultado final.

### 3. (Difícil) Máquina Virtual Baseada em Pilha para Bytecode Simples

Problema: Projete e implemente o núcleo de uma máquina virtual em Assembly que execute um bytecode simples baseado em pilha. O bytecode será uma sequência de bytes onde cada byte representa uma instrução (ex: PUSH <valor>, ADD, SUB, MUL, DIV, HALT). A máquina deve ter um ponteiro de instrução (IP) que percorre o código e uma pilha de dados para realizar todas as operações. O programa termina ao encontrar a instrução HALT.

### 4. (Fácil) Resolva a equação f = (g + h) - (i + j)
Resposta: pilha_equação.asm