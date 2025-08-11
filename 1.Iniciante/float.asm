.data
	PI: .float 3.1416
	
.text
.globl main
main:
	li $v0, 2     #instrução 2 do syscall imprime float
	lcw1 $f12, PI #carregue o registrador $f12 do co-processador 1
	syscall
	
