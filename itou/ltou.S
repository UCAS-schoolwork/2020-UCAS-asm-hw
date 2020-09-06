.section .data
iostring:
    .asciz "ab1g2hA0H56po9wK78nB"
.section .text
.globl _start

_start:
    mov $iostring, %edx
L1:  
    mov (%edx), %al
    test %al, %al
    je L2
    sub $'a', %al
    cmp $25, %al
    ja L3
    add $'A', %al
    mov %al, (%edx)
L3:
    inc %edx
    jmp L1
#output
L2:
    movl $4, %eax
    movl $1, %ebx
    movl $iostring, %ecx
    sub $iostring, %edx
    int $0x80
#exit
    movl $1, %eax
    movl $0, %ebx
    int $0x80

