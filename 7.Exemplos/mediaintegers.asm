.data 
	media_msg: .asciiz "Media of Integers\n"
	n1_msg:    .asciiz "Type a integer: \n"
	n2_msg:    .asciiz "Type another integer: \n"
	result:    .asciiz "Result: "
	divisor:   .word 2
.text	
	li $v0, 4
	la $a0, media_msg
	syscall
	
	li $v0, 4
	la $a0, n1_msg
	syscall 
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, n2_msg
	syscall 
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	add $t2, $t1, $t0
	move $s0, $t2
	
	lw $s1, divisor
	div $s0, $s1
	mflo $s2
	mfhi $s3 
	
	li $v0, 4
	la $a0, result 
	syscall 
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 10
	syscall