.data
	array_a:	.space 40
	array_b:	.space 36
	arr_B_msg:	.asciz "Here is your array B: \n"
    
.text
.global main

main:
	jal get_arr_size	# получаем размер массива из подпрограммы в регистр а0
    	mv s2, a0               # помещаем размер массива в s2
    	beqz s2, end            # завершаем программу если размер равен 0
	
	
	mv a1, s2	
	la a0, array_a
	jal fill_array		# вызываем подпрограмму для заполнения массива с клавиатуры
	
	
	
	la a0, array_a
	la a1, array_b
	mv a2, s2
	jal fill_b_array	# вызываем подпрограмму для заполнения массива B 
	
	print arr_B_msg		# выводим массив B
	li s0, 1
	bgt s2, s0, correct_size_of_B # если размер A == 1 то не меняем переменную с размером массива A для передачу в функцию вывода массива B
	j print_b
	
correct_size_of_B:
	addi s2, s2, -1
	
print_b:
	la a0, array_b
	mv a1, s2
	jal print_arr		# вывод массива B
	
end:	
	break


