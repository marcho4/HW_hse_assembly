.data
	enter_msg: .asciz "Enter x:\n"
	new_line: .asciz "\n"
	result_msg: .asciz "Result: "
	x: .float 0.0
.text
	main:
	    print(enter_msg)
	    read_float(x)
	    print(new_line)
	    flw fa0, x, t0
	    jal calculate_arctan
	    print(new_line)
	    print(result_msg)
	    print_float(fa0)
	    break
	    
