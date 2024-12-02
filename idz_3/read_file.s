.eqv TEXT_SIZE 512
.eqv MAX_TEXT_SIZE 10240
.text    
.globl read_from_file
# a0 - descriptor
# returns a0 - address on heap where text starts
# a1 - length of string
read_from_file: 
    push ra
    push s0
    push s1
    push s2
    push s3
    push s4
    push s5
    push s6
    
    mv s0, a0 # s0 - descriptor
    
    allocate(TEXT_SIZE)         # Результат хранится в a0
    mv      s3, a0          # Сохранение адреса кучи в регистре
    mv      s5, a0          # Сохранение изменяемого адреса кучи в регистре
    li      s4, TEXT_SIZE       # Сохранение константы для обработки
    mv      s6, zero        # Установка начальной длины прочитанного текста
    
read_loop:
    # Проверка превышения максимального размера
    li t0, MAX_TEXT_SIZE
    bge s6, t0, end_loop

    read_addr_reg(s0, s5, TEXT_SIZE) # чтение для адреса блока из регистра
    
    # Проверка на корректное чтение
    li s1, -1
    beq     a0, s1, er_read    # Ошибка чтения если -1
    mv      s2, a0         # Сохранение длины текста
    add     s6, s6, s2     # Размер текста увеличивается на прочитанную порцию
    
    # При длине прочитанного текста меньшей, чем размер буфера,
    # необходимо завершить процесс.
    bne     s2, s4, end_loop
    
    # Проверка превышения максимального размера перед выделением памяти
    li t0, MAX_TEXT_SIZE
    bge s6, t0, end_loop
    
    allocate(TEXT_SIZE)     
    add     s5, s5, s2      
    b read_loop 
    
end_loop:
    close(s0)
    
    # добавление нуля в конец считанной строки
    mv      t0, s3         # Адрес буфера в куче
    add     t0, t0, s6     # Адрес последнего прочитанного символа
    sb      zero, (t0)     # Запись нуля в конец текста
    
    mv      a0, s3         # Адрес начала буфера из кучи
    addi    a1, s6, 1      # Длина с учетом нулевого байта
    
    pop s6
    pop s5
    pop s4
    pop s3
    pop s2
    pop s1
    pop s0
    pop ra
    ret 
    
er_read:
    print_str("Error while reading. Program stopped")
    j end_loop