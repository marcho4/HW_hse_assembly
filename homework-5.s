.data
	output: .asciz "Максимальный факториал: "
.text
	start:
	    li t0, 1            
	    li t1, 1             
	    li t2, 214748364   
	    
	    jal ra, fact
	    
	    la a0, output                    
	    li a7, 4
	    ecall
	 
	    mv a0, t1
	    li a7, 1
	    ecall  
	                
	    li a7, 10           
	    ecall               
	
	fact:
	
	    mul t0, t0, t1
	    addi t1, t1, 1       
	    bgtu t0, t2, done    
	    j fact    
	     
	done:
	
	    addi t1, t1, -1 
	    ret 


    