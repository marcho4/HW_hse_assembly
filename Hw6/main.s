.include "macro_strncpy.s"
.include "macros.s"
.global main
.data
    str1: .string "Hello, World!"
    str2: .string "Test string"
    buffer: .space 50
    buffer1: .space 50
    buffer2: .space 50
    buffer3: .space 50
    prompt_src: .string "Введите исходную строку: "
    prompt_n: .string "Введите количество символов для копирования: "
    before: .string "Строка до обработки: "
    before_n: .string "Кол-во символов для копирования: "
    after: .string "После обработки: "
    newline: .string "\n"
    delimetr: .string "***************************\n"
.text
main:
    # Тест на данных пользователя
    print(prompt_src)
    la a0, buffer1           # Загружаем адрес buffer в a0
    li a1, 50               # Максимальный размер ввода (100 байт)
    read_string
    mv a1, a0
    
    print(prompt_n)
    read_int(a2)
    la a0, buffer2
    
    print(delimetr)
    print(before)
    print(buffer1)
    print(before_n)
    print_int(a2)
    print(newline)
    
    STRNCPY(buffer2, buffer1, a2)
    
    print(after)
    print(buffer2)
    print(newline)
    print(delimetr)

    # Тест 1: Копирование предопределенной строки
    li a2, 5
    print(before)
    print(str1)
    print(newline)
    print(before_n)
    print_int(a2)
    print(newline)
    
    STRNCPY(buffer, str1, a2)
    
    print(after)
    print(buffer)
    print(newline)
    print(delimetr)
    
    
    # Тест 2: Копирование с превышением длины исходной строки
    li a2, 20
    print(before)
    print(str2)
    print(newline)
    print(before_n)
    print_int(a2)
    print(newline)
    
    STRNCPY(buffer3, str2, a2)
    
    print(after)
    print(buffer3)
    print(newline)
    print(delimetr)
    
    break

.include "strncpy.s"
