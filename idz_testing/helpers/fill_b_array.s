.global fill_b_array

.text
fill_b_array: # signature (a0: array_a, a1: array_b, a2: array_a_size) void
    # a0 - array_a address, 
    # a1 - array_b address
    # a2 - size
    push ra
    mv t0, a0        # A[0] address
    mv t1, a1        # B[0] address
    mv t2, a2        # size
    li t3, 0         # counter
    li t4, 2
    blt t2, t4, check_one_elem
    
fill_b_loop:
    addi t4, t2, -1
    bge t3, t4, return       # If counter >= B size, end
    lw t5, 0(t0)             # Load A[i]
    lw t6, 4(t0)             # Load A[i+1]
    add t6, t5, t6           # B[i] = A[i] + A[i+1]
    sw t6, 0(t1)             # Store result in B[i]
    addi t0, t0, 4           # Move to next A element
    addi t1, t1, 4           # Move to next B element
    addi t3, t3, 1           # Increment counter
    j fill_b_loop
    
check_one_elem:
    li t4, 1
    bne t2, t4, return       # If A size != 1, return
one_elem: 
    lw t5, 0(t0)             # Load single element of A
    sw t5, 0(t1)             # Store it in B
return:
	pop ra
    ret