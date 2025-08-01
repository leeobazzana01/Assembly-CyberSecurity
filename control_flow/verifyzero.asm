.data
    msg: .asciiz "Type a integer: "
    equal_message: .asciiz "Equal Zero\n"
    greater_message: .asciiz "Greater than zero\n"
    less_message: .asciiz "Less than zero\n"

.text
.globl main

main:
    # Exibir mensagem de entrada
    li $v0, 4
    la $a0, msg
    syscall 

    # Ler um número inteiro do usuário
    li $v0, 5
    syscall
    move $t0, $v0  # Armazena o número em $t0

    # Verificar se o número é zero
    beq $t0, $zero, equal_label

    # Se não for zero, verificar se é positivo ou negativo
    bgtz $t0, greater_label

    # Se não for positivo, é negativo
    j less_label

equal_label:
    li $v0, 4
    la $a0, equal_message
    syscall
    j exit

greater_label:
    li $v0, 4
    la $a0, greater_message
    syscall
    j exit

less_label:
    li $v0, 4
    la $a0, less_message
    syscall

exit:
    li $v0, 10
    syscall