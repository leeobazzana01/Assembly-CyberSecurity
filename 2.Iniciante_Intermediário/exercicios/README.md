# Nível Básico
## Declaração e Acesso a Vetores
Declare um vetor de 5 inteiros com valores {1, 3, 5, 7, 9}. Carregue o terceiro elemento (índice 2) em $t0 usando offset fixo (ex: 8($s0)).
RESPOSTA: vetor_impares.asm

## Iteração Simples
Declare um vetor de 10 inteiros inicializados com 0. Use um loop para preenchê-lo com valores de 1 a 10. Armazene cada elemento usando sw.

## Acesso com Índice Variável
Declare um vetor de 8 palavras. Peça ao usuário um índice (0-7) e exiba o valor correspondente. Use sll para calcular o offset.
# Nível Intermediário
## Strings: Contagem de Caracteres
Declare uma string .asciiz "Hello!". Conte quantos caracteres ela tem (excluindo o \0), percorrendo-a byte a byte até encontrar o terminador nulo.
## Strings: Inversão
Leia uma string do usuário (máx. 100 chars) e inverta seus caracteres (sem usar um segundo vetor). Exiba o resultado.
## Structs: Acesso a Campos
Defina uma struct Pessoa com os campos: idade (word), altura (word) e inicial (byte). Armazene os valores 25, 180, 'A' e carregue a inicial em $t0.
## Busca Linear
Implemente a busca linear em um vetor de 10 inteiros. Retorne 1 em $v0 se o elemento digitado pelo usuário for encontrado, ou 0 caso contrário.
# Nível Avançado
## Bubble Sort
Ordene um vetor de 10 inteiros (lidos do usuário ou definidos em .data) usando o algoritmo Bubble Sort. Use dois loops aninhados e comparações com lw/sw.
## Strings: Conversão para Maiúsculas
Leia uma string do usuário e converta todos os caracteres minúsculos para maiúsculos. Ignore caracteres não alfabéticos. Dica: Subtraia 32 de bytes no intervalo 'a'-'z'.
## Structs com Vetores
Crie um vetor de structs Aluno (com campos nota (word) e id (word)). Leia os dados de 5 alunos, depois encontre e exiba a maior nota.
## Busca com Múltiplas Ocorrências
Em um vetor de 20 inteiros, conte quantas vezes um elemento fornecido pelo usuário aparece. Retorne o resultado em $v0.
## Inserção em Vetor Ordenado
Mantenha um vetor ordenado de 15 inteiros. Insira um novo elemento fornecido pelo usuário na posição correta, deslocando os elementos existentes.


## Dicas Gerais
Use la para carregar endereços de vetores/strings.

Para acesso a bytes, use lb/sb com offsets em bytes (não multiplique por 4).

Em structs, calcule offsets somando o tamanho dos campos anteriores (ex: idade em offset 0, altura em 4, inicial em 8).

Em algoritmos de ordenação/busca, use labels para loops e condicionais (beq, bne, slt).