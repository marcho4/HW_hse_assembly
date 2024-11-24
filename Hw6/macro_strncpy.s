.macro STRNCPY %dest, %src, %n
    push a0
    push a1
    push a2
    push ra

    la a0, %dest
    la a1, %src
    mv a2, %n

    jal strncpy

    pop ra
    pop a2
    pop a1
    pop a0
.end_macro
