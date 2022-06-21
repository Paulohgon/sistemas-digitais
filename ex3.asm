.data

pula:
     .asciiz "\n"

    .text
    .globl main
main:
    li $v0,5
    syscall
    move $a0,$v0
    jal fib
    
    ##imprime o resultado da chamada da funçaõ    
    move $a0, $v1
    li $v0, 1 
    syscall
	##pula linha
    la $a0, pula
    li $v0, 4 
    syscall
    
end:
    li $v0, 10
    syscall

fib:  
      beq $a0,0,parada0
      beq $a0,1,parada1 
      beq $a0,2,parada2
      addi $sp, $sp,   -20 
      sw   $s0, 0($sp)
      sw   $s1, 4($sp)
      sw   $s2, 8($sp)
      sw   $s3, 12($sp)
      sw   $ra, 16($sp)


      
      move $s0,$a0
      
      addi $a0, $a0,-1
    
      jal fib
      
      move $s2,$v1
      
      li $v1,0
       
      addi $s0, $s0,-2
      move $a0, $s0
       
      jal fib
      
      move $s3,$v1
      
      add $v1, $s2,$s3
      
      
      
      lw $s0, 0($sp)
      lw $s1, 4($sp)
      lw $s2, 8($sp)
      lw $s3, 12($sp)
      lw $ra, 16($sp)
      addi $sp, $sp,   20
      jr   $ra 
      
      
parada0:


	ori $v1, 1
    	jr $ra
    	
parada1:

	ori $v1, 1
    	jr $ra
    	
parada2:

	ori $v1, 2
    	jr $ra
