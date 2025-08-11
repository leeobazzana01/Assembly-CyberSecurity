.data 
	header: .asciiz "Soma entre dois Números\n" 
	n1: .word 23
	n2: .word 2
.text
.globl main
main:
	li $v0, 4
	la $a0, header
	syscall
	
	lw $t0, n1
	lw $t1, n2
	
	add $t2, $t0, $t1 
	
	li $v0, 1
	move $a0, $t2
	syscall	
	
	