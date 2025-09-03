# Intermediário-Avançado
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

## Filas
(implementação circular em memória)

## Tabelas Hash
(funções hash + tratamento de colisões)

## Árvores Binárias
(nós com left/right pointers)

## Algoritmos Complexos
### Quick Sort
(partition recursivo)

### Busca Binária
(implementação iterativa/recursiva)