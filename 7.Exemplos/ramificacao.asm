.data
newline: .asciiz "\n"  

.text
.globl main

main:
    li $t0, 5        
    li $t1, 5        
    li $t2, -3       
    li $t3, 10       

    beq $t0, $t1, equal_label
    li $v0, 4
    la $a0, newline
    syscall

not_equal_label:
    bne $t0, $t3, different_label
    li $v0, 4
    la $a0, newline
    syscall

equal_label:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $t0
    syscall

blez_label:
    blez $t2, less_or_equal_zero
    li $v0, 4
    la $a0, newline
    syscall

less_or_equal_zero:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

bgtz_label:
    bgtz $t3, greater_than_zero
    li $v0, 4
    la $a0, newline
    syscall

greater_than_zero:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $t3
    syscall

different_label:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 10
    syscall
