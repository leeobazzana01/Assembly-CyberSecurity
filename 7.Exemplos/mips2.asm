.data #declaração de variáveis e dados

str1: .ascii "Exemplo " #se eu printer essa string ele vai printar tudo até o barra zero da str3
str2: .ascii "de soma "
str3: .asciiz "e subtracao. Resultado: " # string terminada em 0
str4: .asciiz "Erro de divisao por zero!"
#diferença entre ascii e asciiz, o z é para colocar o /0 no final da string 

varg: .word 10 #.word = o tipo da variável armazenada de acordo com o número de bits do processador, no caso 32 
varh: .word 20
vari: .word 10
varj: .word 20
varf: .word 0

.text
.globl main

main:

#f = (g*h)/(i-j);
#g , h , i e j: regs. $s1, $s2 , $s3  e $s4 respect.; f: registrador $s0

# leitura das variáveis e carga nos registradores
        
        li $v0, 5 #substitui o que tinha em v0, que era 5, por o que estará em v0
        syscall
	sw $v0, varg
	
	li $v0, 5
	syscall
	sw $v0, varh
	
	li $v0, 5
	syscall
	sw $v0, vari

	
	li $v0, 5
	syscall
	sw $v0, varj
	
	lw $s1, varg     
	lw $s2, varh     
	lw $s3, vari     
	lw $s4, varj     

#somas e subtração
	mul $t0, $s1, $s2   #$t0 contem g * h  
	sub $t1, $s3, $s4   #$t1 contem i - j 

	beq $t1, $zero, erro
	div $s0, $t0, $t1   #$s0: resultado
	sw $s0, varf  	    # armazena resultado em f
	la $a0, str1 	# endereco da string não terminada com NULL
	li $v0, 4 	# imprime string
	syscall
	li $v0, 1 	# imprime inteiro
	lw $a0, varf	# value for int to print
	syscall
	j feito

erro:  
    	la $a0, str4 	# endereco da string não terminada com NULL
	li $v0, 4 	# imprime string
	syscall

feito:
	li $v0, 10
	syscall # feito!

