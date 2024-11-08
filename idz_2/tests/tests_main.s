.data
	test1: .float 0.0
	test2: .float 1.0
	test3: .float 0.15433
	test4: .float 10
	test5: .float -0.59278
	test6: .float -25
	test8: .float 8
	test7: .float 
	test1_expected: .float 0.0
	test2_expected: .float 0.78539816
	test3_expected: .float 0.15312195
	test4_expected: .float 1.47112767
	test5_expected: .float -0.5350937
	test6_expected: .float -1.53081763
	test8_expected: .float 1.44644133
	msg1: .asciz "Test 1:\n" 
	msg2: .asciz "Test 2:\n"
	msg3: .asciz "Test 3:\n"
	msg4: .asciz "Test 4:\n"
	msg5: .asciz "Test 5:\n"
	msg6: .asciz "Test 6 (no data):\n"
	msg7: .asciz "Test 7:\n"
	eps1: .float 0.00005
	eps2: .float 0.0005	
	eps3: .float 0.000005
.text
	print(msg1)
	test_case(test1, test1_expected, eps1)
	print(msg2)
	test_case(test6, test6_expected, eps1)
	print(msg3)
	test_case(test3, test3_expected, eps1)
	print(msg4)
	test_case(test4, test4_expected, eps2)
	print(msg5)
	test_case(test5, test5_expected, eps2)
	print(msg6)
	test_case(test7, test1_expected, eps1)
	print(msg7)
	test_case(test8, test8_expected, eps3)
	break
	
	
