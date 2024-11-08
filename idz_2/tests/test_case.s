.data 
	fail_msg: .asciz "Result: Fail\n"
	success_msg: .asciz "Result: Success\n"
	new_line: .asciz "\n"
	half_pi: .float 1.5707963
	one: .float 1.0
	minus_one: .float -1.0
	answer: .asciz "Answer: "
	expected: .asciz "Expected: "
.text
test_case: # fa0 - x, fa1 - expected outcome, fa2 - epsilon void function
	push ra
	push s1
	push_float fa0
	push_float fa1
	push_float fa2
	push_float fs1
	push_float fs2
	push_float fs3
	push_float fs4
	push_float fs5
	push_float fs6
	
	li t0, 1
	fcvt.s.w fs1, t0 # fs1 = 1
	# flw fs2, eps, t0 # fs2 = eps
	fmv.s fs2, fa2
	arctan(fa0)
	
	print(answer)
	print_float(fa0)
	print(new_line)
	print(expected)
	print_float(fa1)
	print(new_line)
	
	# проверка на четкое равенство
	feq.s t0, fa0, fa1
	bgtz t0, success 
	
	# проверка с погрешностью
	fdiv.s fa0, fa0, fa1
	fsub.s fa0, fs1, fa0
	fabs.s fa0, fa0
	fle.s t0, fa0, fs2
	beqz t0, fail
	
success:
	print(success_msg)
	j end
fail:
	print(fail_msg)
end:

	pop_float fs6
	pop_float fs5
	pop_float fs4
	pop_float fs3
	pop_float fs2
	pop_float fs1
	pop_float fa2
	pop_float fa1
	pop_float fa0
	pop s1
	pop ra
	ret
