.macro test (%arr, %empty, %size, %expected)
	push ra
	
	la a0, %arr
    	la a1, %empty
    	lw a2, %size
    	la a3, %expected
    	jal test_case
    	
    	pop ra
.end_macro