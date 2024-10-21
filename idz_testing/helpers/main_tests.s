.data 
    counter: .word 0
    test_error: .asciz "Failed test #"
    test_accepted: .asciz "Passed all tests"
    test_errors: .asciz "Some tests didn`t finish successfully!"
    newline: .asciz "\n"
# test_data_1
    n1: .word 1
    array1: .word 1
    func_res1: .space 36
    expect1: .word 1
# test_data_3
    n2: .word 10
    array2: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    func_res2: .space 36
    expect2: .word 3, 5, 7, 9, 11, 13, 15, 17, 19
# test_data_4
    n3: .word 8
    array3: .word 1000, 900, 1009, 990, 102, 13, 23, 132
    func_res3: .space 36
    expect3: .word 1900, 1909, 1999, 1092, 115, 36, 155

.text
.global main

main:
    # Сохраняем регистр возврата
    addi sp, sp, -4
    sw ra, 0(sp)
    
    test array1, func_res1, n1, expect1
    test array2, func_res2, n2, expect2
    test array3, func_res3, n3, expect3
    
    
    # Проверяем, были ли ошибки
    lw t0, counter
    beqz t0, all_tests_passed
    
    # Выводим сообщение об ошибках
    print test_errors
    j end_program

all_tests_passed:
    # Выводим сообщение об успешном прохождении всех тестов
    print test_accepted

end_program:
    # Восстанавливаем регистр возврата и завершаем программу
    lw ra, 0(sp)
    addi sp, sp, 4
    li a7, 10
    ecall

test_case:
    # Сохраняем регистры
    addi sp, sp, -20
    sw ra, 16(sp)
    sw s0, 12(sp)
    sw s1, 8(sp)
    sw s2, 4(sp)
    sw s3, 0(sp)
    
    # Сохраняем аргументы
    mv s0, a0  # адрес входного массива
    mv s1, a1  # адрес результирующего массива
    mv s2, a2  # размер входного массива
    mv s3, a3  # адрес ожидаемого результата
    
    # Вызываем тестируемую функцию
    jal fill_b_array
    
    # Определяем размер результирующего массива
    li t0, 1
    ble s2, t0, size_one
    addi a2, s2, -1  # размер результата на 1 меньше входного, если размер входного > 1
    j compare
size_one:
    li a2, 1  # размер результата равен 1, если размер входного <= 1
compare:
    # Проверяем результат
    mv a0, s1  # адрес полученного результата
    mv a1, s3  # адрес ожидаемого результата
    jal compare_arrays
    
    # Восстанавливаем регистры и возвращаемся
    lw ra, 16(sp)
    lw s0, 12(sp)
    lw s1, 8(sp)
    lw s2, 4(sp)
    lw s3, 0(sp)
    addi sp, sp, 20
    ret

compare_arrays:
    # a0 - адрес первого массива (результат функции)
    # a1 - адрес второго массива (ожидаемый результат)
    # a2 - размер для сравнения
    li t0, 0  # счетчик
compare_loop:
    beq t0, a2, compare_success
    lw t1, 0(a0)
    lw t2, 0(a1)
    bne t1, t2, compare_fail
    addi a0, a0, 4
    addi a1, a1, 4
    addi t0, t0, 1
    j compare_loop

compare_fail:
    # Увеличиваем счетчик ошибок
    lw t0, counter
    addi t0, t0, 1
    sw t0, counter, t1 

    # Выводим сообщение об ошибке
    print test_error
    print_int t0
    print newline
    
    li a0, 0  # возвращаем 0 (ошибка)
    ret

compare_success:
    li a0, 1  # возвращаем 1 (успех)
    ret