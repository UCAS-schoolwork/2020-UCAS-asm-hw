.align 16
.globl mymemcpy
.type mymemcpy, @function

L_16b:
    cmp $8, %dl
    jb L_8b
    movq (%rsi), %rcx
    movq -8(%rsi,%rdx), %rax
    movq %rcx, (%rdi)
    movq %rax, -8(%rdi, %rdx)
    ret
L_8b:
    cmp $4, %dl
    jb L_4b
    mov (%rsi), %ecx
    mov -4(%rsi, %rdx), %eax
    mov %ecx, (%rdi)
    mov %eax, -4(%rdi, %rdx)
    ret
L_4b:
    cmp $1, %dl
    jbe L_2b
    mov (%rsi), %cx
    mov -2(%rsi, %rdx), %ax
    mov %cx, (%rdi)
    mov %ax, -2(%rdi, %rdx)
    ret
L_2b:
    jb L_ret
    mov (%rsi), %cl
    mov %cl, (%rdi)
L_ret:
    ret
L_32b:
    vmovdqu (%rsi), %xmm0
	vmovdqu -0x10(%rsi, %rdx), %xmm7
	vmovdqu %xmm0, (%rdi)
	vmovdqu %xmm7, -0x10(%rdi, %rdx)
	ret

mymemcpy:
    cmp $16, %rdx
    jb L_16b
    cmp $64, %rdx
    jae L_64ae
    cmp $32, %rdx
    jb L_32b
    vmovdqu (%rsi), %ymm0
    vmovdqu -0x20(%rsi, %rdx), %ymm7
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm7, -0x20(%rdi, %rdx)
    ret
L_64ae:
    cmp $8388608, %rdx
    jae L_big
    vmovdqu -0x20(%rsi, %rdx), %ymm7
    mov %rdx, %rcx
    vmovdqu %ymm7, -0x20(%rdi, %rdx)
    and $32, %rcx
    jz L_s
    vmovdqu -0x40(%rsi, %rdx), %ymm6
    vmovdqu %ymm6, -0x40(%rdi, %rdx)
L_s:
    shr $6, %rdx
    jz L_ret
L_loop1:
    vmovdqu (%rsi), %ymm0
    vmovdqu 0x20(%rsi), %ymm1
    add $64, %rsi
    vmovdqu %ymm0, (%rdi)
    vmovdqu %ymm1, 0x20(%rdi)
    add $64, %rdi
    dec %rdx
    jnz L_loop1
    ret

L_big:
    lea	(%rsi, %rdx), %rcx
    vmovdqu (%rsi), %ymm0
    vmovdqu -0x80(%rcx), %ymm7
    vmovdqu -0x60(%rcx), %ymm6
    vmovdqu -0x40(%rcx), %ymm5
    vmovdqu -0x20(%rcx), %ymm4
    lea	(%rdi, %rdx), %rcx
    vmovdqu %ymm0, (%rdi)
    mov %rdi, %rax
    and $-32, %rdi
    add $32, %rdi
    mov %rdi, %r8
    sub %rax, %r8
    add %r8, %rsi
    sub %r8, %rdx
    vmovdqu %ymm7, -0x80(%rcx)
    vmovdqu %ymm6, -0x60(%rcx)
    vmovdqu %ymm5, -0x40(%rcx)
    vmovdqu %ymm4, -0x20(%rcx)
    shr $7, %rdx
L_loop2:
    vmovdqu (%rsi), %ymm0
    vmovdqu 0x20(%rsi), %ymm1
    vmovdqu 0x40(%rsi), %ymm2
    vmovdqu 0x60(%rsi), %ymm3
    add $128, %rsi
    vmovntdq %ymm0, (%rdi)
    vmovntdq %ymm1, 0x20(%rdi)
    vmovntdq %ymm2, 0x40(%rdi)
    vmovntdq %ymm3, 0x60(%rdi)
    add $128, %rdi
    dec %rdx
    jnz L_loop2
    ret



