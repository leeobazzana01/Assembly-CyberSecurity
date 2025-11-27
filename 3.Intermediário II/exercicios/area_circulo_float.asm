#manipulacao de variaveis em ponto flutuante

.data
	header: .asciiz "CALCULANDO ÁREA DE UM CIRCULO\n"
	raio: .asciiz "Valor do Raio: "
	pi: .float 3.1416
	resultado: .asciiz "Resultado: "

.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	li $v0, 4
	la $a0, raio
	syscall
	
	#le o valor float
	li $v0, 6
	syscall
	
	#o valor ja fica em $f0
	#mov.s $f0, $v0  <- erro principal
	
	#carrega o valor de pi
	la $t0, pi # carrega o endereco
	lwc1 $f1, 0($t0) # carrega o valor do pi
	
	#area = pi * r²
	#calcula r²
	mul.s $f2, $f0, $f0  # r * r
	
	#multiplica por pi
	mul.s $f3, $f1, $f2  # pi * r²
	
	#txt resultado
	li $v0, 4
	la $a0, resultado
	syscall

	#prepara o float para imprimir
	mov.s $f12, $f3
	
	li $v0, 2  # imprime float
	syscall

	#quebra linha
	li $v0, 11
	li $a0, 10
	syscall

encerra_execucao:
	li $v0, 10
	syscall
