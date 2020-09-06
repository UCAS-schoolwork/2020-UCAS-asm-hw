# int atoi(const char *nptr)
# x86-64

.section .text
.type atoi, @function
.globl atoi

atoi:
L0:
    movzbq (%rdi), %rcx #character
    cmpb $' ', %cl
    jne L1
    inc %rdi
    jmp L0
L1:
    xorb %dl, %dl #sign
    xor %rax, %rax #sum 
    cmpb $'+', %cl
    jne L2
    inc %rdi
    movzbq (%rdi), %rcx
    jmp L3
L2: 
    cmpb $'-', %cl
    jne L3
    inc %dl
    inc %rdi
    movzbq (%rdi), %rcx
L3:
    subb $'0', %cl
    cmpb $9, %cl
    ja L5
    lea (%rax,%rax,4), %rax
    lea (%rcx, %rax,2), %rax
    cmpq $0x7fffffff, %rax #overflow
    ja L4
    inc %rdi
    movzbq (%rdi),%rcx
    jmp L3
L4:
    test %dl, %dl
    movl $0x7fffffff, %eax
    je L6
    inc %rax
    ret
L5:
    test %dl, %dl
    je L6
    neg %rax
L6:
    ret
    

