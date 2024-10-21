.text

.macro push(%x)
    addi sp, sp, -4
    sw  %x, (sp)
.end_macro

.macro pop(%x)
    lw  %x, (sp)
    addi sp, sp, 4
.end_macro

.macro pop_without_address
    addi sp, sp, 4
.end_macro

.macro print(%x)
    la a0, %x
    li a7, 4
    ecall
.end_macro


.macro read_int(%x)
   push (a0)
   li a7, 5
   ecall
   mv %x, a0
   pop  (a0)
.end_macro

.macro break
	li a7, 10
	ecall
.end_macro

.macro print_int(%x)
	mv a0, %x
	li a7, 1
	ecall
.end_macro
