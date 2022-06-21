    .text
    .globl main

main:
    li $v0,5
    syscall
    move $a0,$v0
    jal soma
    
    # imprimir resultado
    addu $a0, $zero, $v0
    addiu $v0, $zero, 1
    syscall
    
end:
    addiu $v0, $zero, 10
    syscall

soma: 
    bne $a0, $zero, soma_corpo
    addiu $v0, $zero, 0
    jr $ra

soma_corpo:
    #salvar ctx
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $ra, 4($sp)
    
    #code principal
    addu $s0, $zero, $a0
    addi $a0, $a0, -1
    jal soma
    add $v0, $v0, $s0
    
    #restaurar ctx
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    #retorna
    jr $ra