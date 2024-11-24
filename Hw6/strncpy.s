.global strncpy

# Функция strncpy:
# a0 - адрес строки назначения (dest)
# a1 - адрес исходной строки (src)
# a2 - максимальное количество символов для копирования (n)
# Возвращает в a0 указатель на строку назначения

strncpy:

    push(ra)
    push(s0)
    push(s1)
    push(s2)
    
    mv s0, a0      # dest
    mv s1, a1      # src
    mv s2, a2      # n
    
    # Проверяем n на 0
    beqz s2, done
    
copy_loop:
    # Загружаем байт из src
    lbu t0, 0(s1)
    
    # Сохраняем байт в dest
    sb t0, 0(s0)
    
    # Проверяем на нулевой байт
    beqz t0, pad_zeros
    
    # Увеличиваем указатели
    addi s0, s0, 1
    addi s1, s1, 1
    
    # Уменьшаем счетчик
    addi s2, s2, -1
    bnez s2, copy_loop
    j done

pad_zeros:
    # Если встретили ноль, заполняем остаток нулями
    addi s0, s0, 1
    addi s2, s2, -1
    
pad_loop:
    beqz s2, done
    sb zero, 0(s0)
    addi s0, s0, 1
    addi s2, s2, -1
    j pad_loop

done:
    # Восстанавливаем регистры
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    
    # Возвращаем указатель на начало dest
    mv a0, s0
    ret
