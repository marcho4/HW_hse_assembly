.include "macros.s"
.include "read_file.s"
.include "parse_data.s"
.global main
.data
	# Predefined paths
	input_path: .asciz "/Users/marcho/Desktop/idz_3/data.txt"
	output_path: .asciz "/Users/marcho/Desktop/idz_3/test_output_data.txt"
	error_path: .asciz "Error happened while opening file"
	
	expected: .asciz "55+77+88+984"
	newline: .asciz "\n"
	# Predefined test data (as if read from a file)
	test_data: .asciz "55adfd77ss88sdasdklkj984"
	test_data_len: .word 27  # Length of test_data
.text
main:
	# Use predefined input path
	open(input_path, 0)
	
	li	s1 -1		# Check for correct file opening
    	beq	a0 s1 er_name	# File opening error
    	mv   	s0 a0   
    	
    	# Simulate read_from_file with predefined data
    	la a0, test_data
    	lw a1, test_data_len
    	
    	# Parse the predefined data
    	jal parse_data 
    	# a0 - parsed data pointer
    	# a1 - length of parsed data
    	
    	mv s0 a0 # result string in s0
	mv s1 a1
    	
    	print_str("Result: ")
    	# Automatically decide to output (simulating 'Y')
	li a7, 4
	mv a0, s0
	ecall
	
	print_str("\nExpected: ")
	print(expected)
	print(newline)
    	
	# Write to predefined output path
	open(output_path, WRITE_ONLY)
	li	s2 -1		# Check for correct file opening
    	beq	a0 s2 er_name	# File opening error
    	mv   	s4 a0   
    	write_file(a0, s0, s1)
	close(a0)
	break
	
er_name:
	print(error_path)
	break