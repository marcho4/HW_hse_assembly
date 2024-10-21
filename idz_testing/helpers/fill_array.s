.data
	loop_msg:       .asciz "Enter number: \n"

.text
.global fill_array

fill_array: # signature (a0: array, a1: int) void
    # a0 - array address, a1 - size
    push ra
    mv t0, a0        # array address
    mv t1, a1        # size
    li t2, 0         # counter
    
fill_loop:
    bge t2, t1, end_of_filling
    print loop_msg
    read_int t3
    sw t3, (t0)
    addi t0, t0, 4
    addi t2, t2, 1
    j fill_loop
    
end_of_filling:
    pop ra
    ret
