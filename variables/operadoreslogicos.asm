.data
    newline: .asciiz "\n"

.text
    .globl main

main:
    li $t1, 204   # em binário 0b10101010 $t1 = 0xAA
    li $t2, 170   # em binário 0b11001100 $t2 = 0xCC

    and $t0, $t1, $t2 
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    andi $t0, $t1, 0x0F
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    or $t0, $t1, $t2
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    ori $t0, $t1, 0xFF
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    xor $t0, $t1, $t2
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

  	

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall