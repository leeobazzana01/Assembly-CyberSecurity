#Declare uma string .asciiz "Hello!". Conte quantos caracteres ela tem (excluindo o \0), percorrendo-a byte a byte até encontrar o terminador nulo.
.data
	string: .asciiz "Hello!"
	header: .asciiz "Contando Caracteres de uma String!\n"
	msg_string: .asciiz "String: "
	newline: .asciiz "\n"
	total_caracteres: .asciiz "Total Caracteres: "
	
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, msg_string
	syscall
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	la $a0, string
	jal conta_caracteres
	
	move $t3, $v0
	
	li $v0, 4
	la $a0, total_caracteres
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
encerra_execucao:
	li $v0, 10
	syscall

conta_caracteres:
    move $t0, $a0        # $t0 = endereço da string
    li $t1, 0            # $t1 = contador = 0
    
loop:
    add $t2, $t0, $t1    # $t2 = endereço do caractere atual
    lb $t3, 0($t2)       # $t3 = caractere atual (usa registrador temporário)
    
    beqz $t3, fim_loop   # Se caractere == null, termina
    
    addi $t1, $t1, 1     # Incrementa contador
    j loop

fim_loop:
    move $v0, $t1        # Retorna o comprimento da string
    jr $ra
	
