.data
	name_message: .asciiz "Name: "
	age_message: .asciiz "Age: "
.text
	li $v0, 4
	la $a0, name_message
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, name_message
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0  
	
	