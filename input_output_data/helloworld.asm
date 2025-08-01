.data 
	hello_world: .asciiz "Hello world\n"
.text
	li $v0, 4 
	la $a0, hello_world
	syscall