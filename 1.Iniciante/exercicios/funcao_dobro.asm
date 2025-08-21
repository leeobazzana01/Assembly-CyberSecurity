#Crie uma função dobro que: Recebe argumento em $a0, Retorna o dobro em $v0, Chame com jal passando 7, Imprima o resultado.
.data
	cabecalho: .asciiz "Calculando o Dobro de 7 com uma função\n"
	resultado: .asciiz "Resultado: "
.text
.globl main
main:
	#imprime cabeçalho
	li $v0, 4
	la $a0, cabecalho
	syscall
	
	#chama a função dobro, passando como argumento o valor 7, e espera o resultado em $ra
	li $a0, 7
	jal dobro
	
	move $s0, $v0 #move o valor retornado pela função para $s0
	
	#imprime mensagem o resultado
	li $v0, 4
	la $a0, resultado 
	syscall
	
	#valor do resultado
	li $v0, 1
	move $a0, $s0 #move de $t1 para $a0
	syscall

encerra_execucao: 
	li $v0, 10
	syscall
dobro:
	li $t0, 2 #$t0 = 2
	mul $v0, $a0, $t0 #$v0 = 7 * 2 ->VALOR q a função retorna é a multiplicação do argumento pela constante
	jr $ra #volta para o registrador $ra 
	

