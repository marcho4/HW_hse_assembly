.macro test_case(%x, %expected, %eps) 
	flw fa0, %x, t0
	flw fa1, %expected, t0
	flw fa2, %eps, t0
	# fa0 - given x
	# fa1 - expected arctan(x)
	# fa2 - eps
	jal test_case
	# returns void, just prints result
.end_macro 
