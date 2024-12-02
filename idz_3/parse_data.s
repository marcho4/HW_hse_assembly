.text
.globl parse_data

parse_data:
	push ra
	push s0
	push s1
	push s3
	

	mv s3, a0 # pointer to the data
	mv t1, a1
	li t2, 1 # flag
	
	li t4, '+'
	
	li t5, '0'     # ASCII код '0'
	li t6, '9'     # ASCII код '9'
	
	# reserve memory
	li a7, 9
    	mv a0, a1
    	ecall
    	
	mv s0, a0 # s0 - output
	mv s1, a0 # s1 - dynamic 
loop:
	lb t0, (s3)
	beqz t0, end_of_string

	blt t0, t5, not_digit
	bgt t0, t6, not_digit
	
	# flag reset
	li t2, 0
	
	# Сохраняем цифру в выделенную память
	sb t0, 0(s1)
	addi s1, s1, 1     # Увеличиваем указатель выделенной памяти
	addi s3, s3, 1     # Адрес символа в строке 1 увеличивается на 1
	b loop
	
not_digit:
	beqz t2, plus
	addi s3, s3, 1     # Адрес символа в строке 1 увеличивается на 1
	b loop

plus:
	li t2, 1
	sb t4, 0(s1)
	addi s1, s1, 1     # Увеличиваем указатель выделенной памяти
	addi s3, s3, 1     # Адрес символа в строке 1 увеличивается на 1
	b loop
	
end_of_string:
	# Добавляем нулевой байт в конец строки
	li t0, 0
	sb t0, 0(s1)

	mv a0, s0
	
	pop s3
	pop s1 
	pop s0
	pop ra
	ret
