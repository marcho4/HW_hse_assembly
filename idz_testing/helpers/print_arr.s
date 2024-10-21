.data
	space_msg:      .asciz " "
	enter:		.asciz "\n"
	
.global print_arr
.text
print_arr: # signature (a0: array, a1: int) void
	push ra
    mv t0, a0        # array address
    mv t1, a1        # size
    li t2, 0         # counter
output_loop:
    bge t2, t1, end_output
    lw t3, (t0)
    print_int t3
    print space_msg
    addi t0, t0, 4
    addi t2, t2, 1
    j output_loop
end_output:
	print enter
	pop ra
    	ret