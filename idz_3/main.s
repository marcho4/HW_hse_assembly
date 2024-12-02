.include "macros.s"
.include "read_file.s"
.include "parse_data.s"

.global main
.data
	input_path: .space 256
	output_path: .space 256
	error_path: .ascii "Error happened while opening file"
	data_msg: .ascii "Data from file:\n"
.text
main:
	print_str("Enter absolute path:\n")
	str_get(input_path, 100)
	open(input_path, 0)
	
	li	s1 -1		# Проверка на корректное открытие
    	beq	a0 s1 er_name	# Ошибка открытия файла
    	mv   	s0 a0   
    	
    	# a0 - descriptor
    	jal read_from_file
    	# a0 - data poiner
    	# a1 - length

    	# a0 - input data
    	# a1 - length
    	jal parse_data 
    	# a0 - parsed data pointer
    	# a1 - length of parsed data
    	
    	mv s0 a0 # в s0 - result string
	mv s1 a1
    	
    	li t0, 'Y'
	li t1, 'N'
	
out_loop:	
    	print_str("Print results? (Y/N)\n")
    	li a7, 12     # syscall number for read character
	ecall 
	beq a0, t0, output
	beq a0, t1, cont
	j out_loop
output:
	li a7, 4
	mv a0, s0
	ecall
	
cont:
	print_str("\nEnter absolute path to the new file:\n")
	str_get(output_path, 100)
	open(output_path, WRITE_ONLY)

	li	s2 -1		# Проверка на корректное открытие
    	beq	a0 s2 er_name	# Ошибка открытия файла
    	mv   	s4 a0   
    	write_file(a0, s0, s1)
	close(a0)
	break
er_name:
	print(error_path)
	break