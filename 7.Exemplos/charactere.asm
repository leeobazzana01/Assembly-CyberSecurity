.data
	character: .asciiz "a"

.text
	li $v0, 11
	la $a0, character #load byte carrega o valor binário da label para o registrador $a0, tornando possível a execução
	syscall
