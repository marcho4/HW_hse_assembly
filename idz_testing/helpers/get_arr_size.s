.data
	start_msg:      	.asciz "Enter number of elements in the array A: \n"
	wrong_count_msg:	.asciz "Accepted length is between 0 and 10, enter again\n"

.text
.global get_arr_size

get_arr_size:  # signature ()
    push ra
    print start_msg
    read_int t1
    li t0, 10
    bltz t1, wrong_size      # Checking if size is less than zero
    bgt t1, t0, wrong_size   # Checking if size is more than 10
    mv a0, t1
    pop ra
    ret			# возвращает в регистре a0 размер массива
    
wrong_size:
    print wrong_count_msg 
    j get_arr_size