.data
	message: .asciiz "Hello World"
	character: .byte "l"
.text
	li $v0, 4
	la $a0, message
	syscall
