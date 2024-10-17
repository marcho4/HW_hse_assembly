
.data
	start: .asciz "Введите число элементов в массиве (от 1 до 10):\n"
	enter_number: .asciz "Введите число:\n"
	error: .asciz "Вы ввели неккоректные данные\n"
	even: .asciz "Количество четных чисел\n"
	uneven: .asciz "Количество нечетных чисел\n"
	summa: .asciz "Последняя до переполнения сумма чисел массива \n" 
.align 2
	array: .space 40
	arrend:
.text 
	la t0, array
	la s1, arrend
	li t2, 0 # counter
	li t3, 0 # sum
    	li t4, 0 # even counter
    	li t5, 0 # uneven counter
	
	# output start message
	la a0, start 
	li a7, 4            
    	ecall
	
	# getting number of elems in array
	li a7, 5
	ecall 
	mv s3 a0
	
fill_loop:
	# output enter_number message
	la a0, enter_number 
	li a7, 4            
    	ecall
    	
    	# getting number from user and placing it in s2
    	li a7, 5
	ecall 
	mv s2 a0
	
	#append elem to array
	sw s2, (t0)
	addi t0 t0 4
	
	#counter += 1
    	addi t2, t2, 1
    	
    	# check if counter == desired number of elems
	beq t2, s3, reset
	
	# going to the loop if there is any space left
    	bltu t0, s1, fill_loop
    	
    	
reset:
	la t0, array  # Reset t0 to the start of the array
	
sum_loop:
	# check if it is an array's end
    	beq t2, zero, end_sum_loop  # End when we've processed all elements
	addi t2, t2, -1  # Decrement the counter
	
	# loading elem from array to t6
    	lw t6, 0(t0)   
    	beq t6, zero, end_sum_loop    
    
    	# check if number is even
    	andi s4, t6, 1    
    	beq s4, zero, even_count 

    	# if number is uneven
    	addi t5, t5, 1
    	j add_to_sum

even_count:
    	addi t4, t4, 1 
	
add_to_sum:

	# saving new sum to tmp (s5)
   	add s5, t3, t6 
   	
   	# check if overflow    
   	blt s5, t3, overflow_detected  
	
   	mv t3, s5         
    	addi t0, t0, 4     
    	j sum_loop        

overflow_detected:

	la a0, summa
	li a7, 4
	ecall
	
    	# output sum
    	mv a0, t3
    	li a7, 1           
    	ecall
    	j print_results 

end_sum_loop:
	#print sum
	la a0, summa
	li a7, 4
	ecall
	
   	# output sum
    	mv a0, t3
    	li a7, 1
    	ecall
    	
    	li a0, 10
	li a7, 11
	ecall
print_results:

	# output even
    	la a0, even
	li a7, 4
	ecall

    	# output even
    	mv a0, t4
    	li a7, 1
    	ecall
    	
    	li a0, 10
	li a7, 11
	ecall

	la a0, uneven
	li a7, 4
	ecall

    	# output uneven
    	mv a0, t5
    	li a7, 1
    	ecall

    	# break programm
    	li a7, 10         
    	ecall





	