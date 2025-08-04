.data
	age: .word 23
	
.text 
	li $v0, 1 #$v0 carrega a instrução que será executada pelo sistema, no caso instrução 1 (imprimir um inteiro)
	lw $a0, age #load adress para o registrador $a0 o endereço da label 'age'
	syscall 
	