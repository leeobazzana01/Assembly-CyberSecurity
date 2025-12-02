#calcular a função: f = (x^y)/z -t
#onde x, z e t reais e y inteiro

 .data
    header:	.asciiz "Calculando a função f = (x^y)/z - t\n"
    msg_x:      .asciiz "valor de x (real): \n"
    msg_y:      .asciiz "valor de y (inteiro): \n"
    msg_z:      .asciiz "valor de z (real): \n"
    msg_t:      .asciiz "valor de t (real): \n"
    msg_erro:   .asciiz "Erro: o valor de z não pode ser zero!\n"
    msg_result: .asciiz "\nResultados\n"
    msg_val_x:  .asciiz "x: \n"
    msg_val_y:  .asciiz "y: \n"
    msg_val_z:  .asciiz "z: \n"
    msg_val_t:  .asciiz "t: \n"
    msg_final:  .asciiz "f = (x^y)/z - t = "
    newline:    .asciiz "\n"
    zero_float: .float 0.0
    one_float:  .float 1.0

.text
.globl main

main:
    #header
    li $v0, 4
    la $a0, header
    syscall
    
    #solicita valor de x(real)
    li $v0, 4
    la $a0, msg_x
    syscall
    
    #le x
    li $v0, 6
    syscall
    mov.s $f1, $f0           #$f1 = x

    #solicita y
    li $v0, 4
    la $a0, msg_y
    syscall
    
    #le y
    li $v0, 5
    syscall
    move $t0, $v0     #$t0 = y

    #solicita z
    li $v0, 4
    la $a0, msg_z
    syscall
    
    #le z
    li $v0, 6
    syscall
    mov.s $f2, $f0    #$f2 = z

    #solicita t
    li $v0, 4
    la $a0, msg_t
    syscall
    
    #le t
    li $v0, 6
    syscall
    mov.s $f3, $f0    #$f3 = t

    #verificando se t eh 0
    l.s $f4, zero_float
    c.eq.s $f2, $f4
    bc1t erro_z_zero

    #calculando x^y
    jal calcular_potencia     #resultado $f5

    #calcula potencia/z
    div.s $f5, $f5, $f2      #$f5 = (x^y)/z

    #calcula divisao - t
    sub.s $f6, $f5, $f3      #$f6 = resultado final

    #imprime resultados
    jal imprimir_resultados
    j encerra_execucao

erro_z_zero:
    li $v0, 4
    la $a0, msg_erro
    syscall
    j encerra_execucao

calcular_potencia:
    #inicializa resultado como 1
    l.s $f5, one_float
    
    #y = 0, retornar 1.0
    beq $t0, $zero, fim_potencia
    
    #se y > 0, calcular potência positiva
    bgt $t0, $zero, potencia_positiva
    
    #se y < 0, calcular potência negativa
    blt $t0, $zero, potencia_negativa

potencia_positiva:
    move $t1, $t0            #$t1= contador
    mov.s $f7, $f1           #$f7= base (x)
    
loop_positivo:
    mul.s $f5, $f5, $f7      #multiplica por acumulador de x
    subi $t1, $t1, 1         # Decrementar contador
    bgt $t1, $zero, loop_positivo
    j fim_potencia

potencia_negativa:
    #converte y pra positivo
    sub $t1, $zero, $t0      #$t1 = |y|
    mov.s $f7, $f1           #$f7 = base (x)
    
    #calcula x^|y|
    l.s $f8, one_float       #acumulador p o denominador
    
loop_negativo:
    mul.s $f8, $f8, $f7      #multiplica acumulador por x
    subi $t1, $t1, 1         #decrementa contador
    bgt $t1, $zero, loop_negativo
    
    #calcula 1/(x^|y|)
    l.s $f9, one_float
    div.s $f5, $f9, $f8      #$f5 = 1/(x^|y|)

fim_potencia:
    jr $ra

imprimir_resultados:
    #cabeçalho
    li $v0, 4
    la $a0, msg_result
    syscall

    #msg do valor d x 
    li $v0, 4
    la $a0, msg_val_x
    syscall
    
    #movendo p impressao
    li $v0, 2
    mov.s $f12, $f1
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall

    #msg do valor de y
    li $v0, 4
    la $a0, msg_val_y
    syscall
    
    #movendo p fazer a impressao
    li $v0, 1
    move $a0, $t0
    syscall
    
    #\n
    li $v0, 4
    la $a0, newline
    syscall

    #msg q imprime z
    li $v0, 4
    la $a0, msg_val_z
    syscall
    
    #movendo p mostrar msg
    li $v0, 2
    mov.s $f12, $f2
    syscall
    
    #\n
    li $v0, 4
    la $a0, newline
    syscall

    #mag de impressao d t
    li $v0, 4
    la $a0, msg_val_t
    syscall
    
    #move valor
    li $v0, 2
    mov.s $f12, $f3
    syscall
    
    #\n
    li $v0, 4
    la $a0, newline
    syscall

    #resultado final
    li $v0, 4
    la $a0, msg_final
    syscall
    
    li $v0, 2
    mov.s $f12, $f6
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    jr $ra

encerra_execucao:
    li $v0, 10
    syscall 