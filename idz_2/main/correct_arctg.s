.text
	get_arctg: # get_arctg(fa0 = x) return fa0 = arctg(x)
	    push ra
	    push s1
	    push_float fa1
	    push_float fs6
	    push_float fs5
	    push_float fs4
	    push_float fs3
	    # check if |x| < 1
	    fabs.s fa1, fa0
	    flw fs6, one, t0
	    fge.s s1, fa1, fs6
	    beqz s1, ltz
	    j gtz
	    
	ltz:
	    # |x| < 1
	    jal calculate_arctan
	    j print_res
	    
	gtz:
	    # |x| > 1 => answer = pi/2 - arctan 1/x
	    fdiv.s fa0, fs6, fa0
	    jal calculate_arctan
	    flw fs5, half_pi, t0
	    li t0, 0
	    fcvt.s.w fs4, t0
	    fle.s t0, fa0, fs4
	    beqz t0, bigger
	    j less
	    
	bigger:
	    # x > 1
	    fsub.s fa0, fs5, fa0
	    j print_res
	    
	less:
	    # x < -1
	    flw fs3, minus_one, t0
	    fmul.s fs5, fs5, fs3
	    j bigger
	    
	print_res:
	    pop_float fs3
	    pop_float fs4
	    pop_float fs5
	    pop_float fs6
	    pop_float fa1
	    pop s1
	    pop ra
	    ret 