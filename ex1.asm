.data

pula:
     .asciiz "\n"

    .text
    .globl main
main:

 ##ler inteiro que quer analisar
    li $v0,5
    syscall
    move $a0,$v0
    ## verifica se quer parar o programa
    beqz $a0, end
    
    li $v1,0
##chama funçao que soma    
    jal somador
    
##imprime o resultado da chamada da funçaõ    
    move $a0, $v1
    li $v0, 1 
    syscall
##pula linha
    la $a0, pula
    li $v0, 4 
    syscall
## repete a main    
    j main 	

end:
  
    li $v0, 10
    syscall

somador:
    addi $sp,$sp,-8
    sw $s0, 0($sp)
    sw $ra, 4($sp)
##salva 10 em s2
    li $s2,10
##retira o numero decimal    
    move $s0,$a0
    div $s0,$s2
##salva o resto e o cociente 
    mfhi $s1
    mflo $a0


##soma o resto e salva
    add $v1,$v1,$s1
    
## se o cociente for igual a zero para a recursividade
    beqz $a0,parada
##chama a funcao de novo
    jal somador

   
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addi $sp,$sp,8

    jr $ra

parada:
    ori $v0, 1
    jr $ra