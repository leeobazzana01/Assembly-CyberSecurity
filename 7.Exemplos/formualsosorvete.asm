.data
str1: .asciiz "resultado: "  # string para exibir antes do resultado
str2: .asciiz "erro: tempo nao pode ser negativo!"  # mensagem de erro

so: .word 0  # posicao inicial
v: .word 0   # velocidade
 t: .word 0   # tempo
s: .word 0   # resultado final

.text
.globl main
.ent main
main:
    # leitura das variaveis
    li $v0, 5    # solicita entrada do usuario
    syscall      # le um inteiro
    sw $v0, so  # armazena em so
    
    li $v0, 5
    syscall
    sw $v0, v  # armazena em v
    
    li $v0, 5
    syscall
    sw $v0, t  # armazena em t
    
    # carregando variaveis nos registradores
    lw $s1, so  # carrega so em $s1
    lw $s2, v   # carrega v em $s2
    lw $s3, t   # carrega t em $s3
    
    # verificacao de erro: tempo nao pode ser negativo
    blt $s3, $zero, erro
    
    # calculo s = so + vt
    mul $t0, $s2, $s3   # v * t em $t0
    add $s0, $s1, $t0   # s = so + vt armazenado em $s0
    sw $s0, s           # salva o resultado em s
    
    # imprime "resultado: "
    la $a0, str1  # carrega endereco da string
    li $v0, 4    # syscall para imprimir string
    syscall
    
    # imprime o resultado
    li $v0, 1    # syscall para imprimir inteiro
    lw $a0, s    # carrega o valor de s
    syscall
    j feito
    
erro:
    la $a0, str2  # mensagem de erro
    li $v0, 4    # syscall para imprimir string
    syscall
    
feito:
    li $v0, 10  # encerra o programa
    syscall
.end main
