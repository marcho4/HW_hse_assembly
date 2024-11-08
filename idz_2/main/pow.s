.text
	pow: # fa0 - x, a0 - pow, return fa0 - result
		push_float fs1
		push ra
		fmv.s fs1, fa0
		addi a0, a0, -1
	loop: # loop
		beqz a0, return_pow
		fmul.s fa0, fs1, fa0
		addi a0, a0, -1
		j loop
	return_pow:
		pop ra
		pop_float fs1
		ret
