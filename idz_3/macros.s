.macro print(%x)
	push a0
	la a0, %x
	li a7, 4
	ecall
	pop a0
.end_macro

.macro str_get(%strbuf, %size)
    la      a0 %strbuf
    li      a1 %size
    li      a7 8
    ecall
    push(s0)
    push(s1)
    push(s2)
    li	s0 '\n'
    la	s1	%strbuf
next:
    lb	s2  (s1)
    beq s0	s2	replace
    addi s1 s1 1
    b	next
replace:
    sb	zero (s1)
    pop(s2)
    pop(s1)
    pop(s0)
.end_macro
	
.eqv READ_ONLY	0	# Открыть для чтения
.eqv WRITE_ONLY	1	# Открыть для записи
.eqv APPEND	    9	# Открыть для добавления
.macro open(%file_name, %opt)
    li   	a7 1024     	# Системный вызов открытия файла
    la      a0 %file_name   # Имя открываемого файла
    li   	a1 %opt        	# Открыть для чтения (флаг = 0)
    ecall             		# Дескриптор файла в a0 или -1)
.end_macro

.macro print_int(%x)
	push a0
	mv a0, %x
	li a7, 1
	ecall
	pop a0
.end_macro

.macro print_str (%x)
   .data
str:
   .asciz %x
   .text
   push (a0)
   li a7, 4
   la a0, str
   ecall
   pop	(a0)
.end_macro

.macro write_file(%descriptor, %buffer, %size)
	mv a0, %descriptor
	mv a1, %buffer
	mv a2, %size
	li a7, 64
	ecall
.end_macro

# Чтение информации из открытого файла
.macro read(%file_descriptor, %strbuf, %size)
    li   a7, 63       	# Системный вызов для чтения из файла
    mv   a0, %file_descriptor       # Дескриптор файла
    la   a1, %strbuf   	# Адрес буфера для читаемого текста
    li   a2, %size 		# Размер читаемой порции
    ecall             	# Чтение
.end_macro

# Чтение информации из открытого файла,
# когда адрес буфера в регистре
.macro read_addr_reg(%file_descriptor, %reg, %size)
    li   a7, 63       	# Системный вызов для чтения из файла
    mv   a0, %file_descriptor       # Дескриптор файла
    mv   a1, %reg   	# Адрес буфера для читаемого текста из регистра
    li   a2, %size 		# Размер читаемой порции
    ecall             	# Чтение
.end_macro

.macro close(%file_descriptor)
    li   a7, 57       # Системный вызов закрытия файла
    mv   a0, %file_descriptor  # Дескриптор файла
    ecall             # Закрытие файла
.end_macro

.macro allocate(%size)
    li a7, 9
    li a0, %size
    ecall
.end_macro

.macro print_str (%x)
   .data
str:
   .asciz %x
   .align 2     # Выравнивание памяти. Возможны данные размером в слово
   .text
   push (a0)
   li a7, 4
   la a0, str
   ecall
   pop	(a0)
.end_macro


.macro push(%x)
    addi sp, sp, -4
    sw  %x, (sp)
.end_macro

.macro pop(%x)
    lw  %x, (sp)
    addi sp, sp, 4
.end_macro

.macro break
	li a7, 10
	ecall
.end_macro

.macro get_char(%buffer)
    li a7, 63              # системный вызов: ввод символа
    li a0, 0               # дескриптор stdin
    la a1, %buffer         # буфер для ввода
    li a2, 1               # размер буфера
    ecall
.end_macro

