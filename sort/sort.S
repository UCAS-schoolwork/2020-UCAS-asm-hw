.section .data
testdata:
    .byte 'A', '0', 'z', 'P', '8', 'r', 'Z', '2', 'f', 'H'

.section .text
.globl _start
_start:
  movq $testdata, %rdi
  movq $10, %rsi
  call insert_sort

#output
  call as_puts

#exit
  call as_exit


.text
  .globl insert_sort
  .type insert_sort, @function
insert_sort:
  mov %rdi, %rax
  add %rdi, %rsi
  dec %rsi
L1:
  mov %rax, %r12
  inc %rax
  mov (%rax), %bl
L2:
  cmp %rdi, %r12
  jb L3
  movb (%r12), %r13b
  cmpb %bl, %r13b
  jbe L3
  movb %r13b, 1(%r12)
  dec %r12
  jmp L2
L3:
  movb %bl, 1(%r12)
  cmp %rsi, %rax
  jb L1
  sub %rdi, %rsi
  inc %rsi
  ret

.globl as_puts
  .type as_puts, @function
as_puts:
  movq $1, %rax
  movq %rsi, %rdx
  movq %rdi, %rsi
  movq $1, %rdi
  syscall

.globl as_exit
  .type as_exit, @function
as_exit:
  movq $60,%rax
  movq $0, %rdi
  syscall

