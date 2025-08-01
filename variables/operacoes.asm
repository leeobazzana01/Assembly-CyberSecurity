.data
	initial_message: .asciiz "f = (g*h)/(i-j) + k\n\n"
	variable: .asciiz "Type a integer: \n"
	error_message: .asciiz "Aint no division for zero"
	result: .
.text
	li $v0, 4
	la $a0, initial_message
	syscall	
	
	li $v0, 4
	la $a0, variable
	syscall
	
	li $v0, 5
	syscall 
	move $s0, $v0
	
	li $v0, 4
	la $a0, variable
	syscall
	
	li $v0, 5
	syscall 
	move $s1, $v0
	
	li $v0, 4
	la $a0, variable
	syscall
	
	li $v0, 5
	syscall 
	move $s2, $v0
	
	li $v0, 4
	la $a0, variable
	syscall
	
	li $v0, 5
	syscall 
	move $s3, $v0
	
	li $v0, 4
	la $a0, variable
	syscall
	
	li $v0, 5
	syscall 
	move $s4, $v0
	
	mul $t0, $s0, $s1 # $t0 = (g*h)
	sub $t1, $s2, $s3 # $t1 = (i-j)
	beq $t1, $zero, error
	
	div $t2, $t0, $t1 # $t2 = $t0/$t1
	add $t3, $t2, $s4 # $t3 = $t2 + k
	
	li $v0, 1
	lw $t3
	
	
	error:
		li $v0, 4
		la $a0, error_message
		syscall 
		j done
		 
	done: 
		li $v0, 10
		syscall 
		
	    