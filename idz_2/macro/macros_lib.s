.macro read_float(%dw)
	li a7, 6
	ecall
	fsw fa0, %dw, t0
.end_macro 

.macro print_float_word(%x)
	flw fa0, %x, t0
	li a7, 2 
    	ecall
.end_macro

.macro print_float(%x)
	push_float fa0
	fmv.s fa0, %x
	li a7, 2 
    	ecall
    	pop_float fa0
.end_macro

.macro break
	li a7, 10
	ecall
.end_macro

.macro print(%x)
	push a0
	la a0, %x
	li a7, 4
	ecall
	pop a0
.end_macro

.macro push_float %reg
    addi sp, sp, -8
    fsd %reg, 0(sp)
.end_macro

.macro pop_float %reg
    fld %reg, 0(sp)
    addi sp, sp, 8
.end_macro

.macro push(%x)
    addi sp, sp, -4
    sw  %x, (sp)
.end_macro

.macro pop(%x)
    lw  %x, (sp)
    addi sp, sp, 4
.end_macro

.macro print_int(%x)
	push a0
	mv a0, %x
	li a7, 1
	ecall
	pop a0
.end_macro

.macro arctan(%float_word) 
	fmv.s fa0, %float_word
	# fa0 = x
	jal get_arctg
	# fa0 = arctan(x)
.end_macro
