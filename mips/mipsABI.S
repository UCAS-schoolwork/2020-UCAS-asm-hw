#将输入的32位无符号整数以10进制的字符串形式在终端输出

.section .data
    var: .int 0xffffffff

.section .text
    .globl __start

__start:
    la $t0, var
    lw $a0, 0($t0)
    jal print_dec
    addiu $v0, $zero, 4001
    addiu $a0, $zero, 0
    syscall

.text
.type print_dec, @function
.globl print_dec
print_dec:
    addiu $sp, $sp, -24
    sw $fp, 20($sp)
    move $fp, $sp
    addiu $t0, $sp, 11

    beq $a0, $zero, L2
    li $t1, 10
L1:
    subu $t0, $t0, 1
    divu $a0, $t1
    mflo $a0
    mfhi $t2
    ori $t2, $t2, 0x30
    sb $t2, 0($t0)
    bne $a0, $zero, L1
    nop
    addiu $a2, $sp, 11
    subu $a2, $a2, $t0
    j L3
    nop
L2:
    subu $t0, $t0, 1
    li $t2, '0'
    sb $t2, 0($t0)
    li $a2, 1
L3:
    move $a1, $t0
    li $v0, 4004
    li $a0, 1
    syscall
    move $sp, $fp
    lw $fp, 20($sp)
    addiu $sp, $sp, 24
    jr $31
    nop