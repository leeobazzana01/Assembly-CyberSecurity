.data
    newline: .asciiz "\n"

.text
.globl main

main:
    li $t0, 0           

loop:
    li $v0, 1           
    move $a0, $t0       
    syscall

    li $v0, 4           
    la $a0, newline     
    syscall

    addi $t0, $t0, 1    
    ble $t0, 10, loop   

exit:
    li $v0, 10          
    syscall
