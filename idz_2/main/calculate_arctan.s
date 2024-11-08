.data
	epsilon: .float 0.00005 

.text
	calculate_arctan: #signature (x: float (should be in fa0)) returns float
		push ra
		push_float(fs2)
		push_float(fs1)
		push_float(fs0)
		
		flw fs2, epsilon, t0 # fs2 - 0.00005
		
		li t0, 0
		fcvt.s.w ft0, t0 # ft0 - n
		
		fcvt.s.w fs0, t0 # fs0 - sum
		
		fmv.s ft1, fa0 # ft1 - x
		
		# ft0 = n, ft1 = x, fs0 - sum, fs2 - epsilon
		
		# Check if x == 0
		feq.s t0, ft0, ft1
		bgtz t0, return
		
	calculate_curr:
		li t0, 2
		fcvt.s.w ft2, t0
		
		li t0, 1
		fcvt.s.w ft3, t0 
		
		fmadd.s ft4, ft2, ft0, ft3 
		fcvt.w.s t3, ft4
		# ft4 = t3 = (2 * n) + 1
		
		
		mv a0, t3
		fmv.s fa0, ft1
		jal pow
		# fa0 = x^(2n + 1)
		
		fdiv.s fa0, fa0, ft4
		# fa0 = x^(2n+1) / (2n+1)
		
		# проверка добалять или нет
		fcvt.w.s t0, ft0
		andi t5, t0, 1
		beqz t5, add_to_sum     
    		j subtract_from_sum
		
	add_to_sum:
		fadd.s fs0, fs0, fa0 # add fa0 to summ
		j check_accuracy
	
	subtract_from_sum:
		fsub.s fs0, fs0, fa0 # subtract fa0 to summ
		j check_accuracy
		
	check_accuracy: 
		fdiv.s fs1, fa0, fs0 # fa0 (curr) / fs0 (sum)
		flt.s t1, fs1, fs2 # if fs1 < 0.00005 t1 = 1
		fadd.s ft0, ft0, ft3 # sum = sum + curr
		beqz t1 calculate_curr # if accurasy > eps: loop
		
	return:
		fmv.s fa0, fs0
		pop_float(fs0)
		pop_float(fs1)
		pop_float(fs2)
		pop ra
		ret
