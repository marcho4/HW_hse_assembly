.data
	enter_msg: .asciz "Enter x:\n"
	new_line: .asciz "\n"
	result_msg: .asciz "Result: "
	x: .float 0.0
	half_pi: .float 1.5707963
	one: .float 1.0
	minus_one: .float -1.0
.text
	main:
	    # getting x from user
	    print(enter_msg)
	    read_float(x)
	    flw fa0, x, t0
	    arctan(fa0)
	    print(result_msg)
	    print_float(fa0)
	    break
	    
