    .text
    .globl main

main:
#le o inteiro
    li $v0,5
    syscall
    move $a0,$v0
    jal soma_corpo
    
    add $a0, $v0,$a0
    
    
    jal soma_corpo
    
    addu $a0, $zero, $v0
    addiu $v0, $zero, 1
    syscall
    
    li $v0, 1
    syscall
    
    
end:
    li $v0, 10
    syscall
    	
	
    	
soma_corpo:
#salvar ctx
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $ra, 4($sp)
    move $s0,$a0
    #caso de parada x<=0
    ble  $s0, 1, parada
    
    
    move $a1,$s0
    
    #divide e pega o resto
    div $a0,$s0, 2
    
    mfhi $t1
    
   
   #if reto  ==0 
    beqz $t1,if
    
    move $a0,$s0
    
    #else
    bnez $t1, else
    
   
    
    jr $ra
    
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp,$sp,8
	
    jr $ra
    
if:
    addi $sp, $sp, -8
    sw $s0, 0($sp)
    sw $ra, 4($sp)
    #chama a função
    jal soma_corpo
    #soma o retorno da funçao com o parametro anterior
    add $s0,$v0,$a1
    
    move $v0,$s0
    
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp,$sp,8
	
    jr $ra

    
else:
    addi $sp, $sp,-20 
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $ra, 16($sp)
    
    move $s0, $a0
        #add -1 no parametro
    addi $a0, $a0, -1

    jal soma_corpo
    move $s1, $v0
    
    move $a0, $s0
    	#add 1 no parametro
    addi $a0, $a0, 1
    
    jal soma_corpo 
    #salva o retorno
    move $s2, $v0
   
    add $v0,$s0,$s1
    add $v0,$v1,$s2
    #soma tudo e retorna
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp,$sp,20
	
    jr $ra
parada:   	
    ori $v0, 1
    jr $ra