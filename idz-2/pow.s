.data
	pow_msg: .asciz "Возвожу "
	pow_msg_2: .asciz " в степень "
.text
	pow: # fa0 - x, a0 - степень, return fa0 - result
		push_float fs1
		push ra
		
		fmv.s fs1, fa0
		print(new_line)
		print(pow_msg)
		print_float(fa0)
		print(pow_msg_2)
		print_int(a0)
		print(new_line)
		addi a0, a0, -1
	loop:
		beqz a0, return_pow
		fmul.s fa0, fs1, fa0
		addi a0, a0, -1
		j loop
		
	return_pow:
		pop ra
		pop_float fs1
		ret