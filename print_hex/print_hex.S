.section .data
  var: .int 0x0812abcd
.section .text
.globl  _start
_start:
  pushl var
  call  print_hex
  mov   $1, %eax
  mov   $0, %ebx
  int   $0x80

.section .text
.type print_hex, @function
print_hex:
  push %ebp
  mov %esp, %ebp
  sub $16, %esp
  mov %ebx, 12(%esp)
  mov 8(%ebp), %ecx
  lea 10(%esp), %eax
  test %ecx, %ecx
  mov $0, %ebx
  jge L1
  not %ecx
  inc %ecx
  mov $1, %ebx
L1:
  mov %ecx, %edx
  andb $0xf, %dl
  cmpb $10, %dl
  jb L2
  addb $0x57, %dl
  jmp L3
L2:
  orb $0x30, %dl
L3:
  movb %dl, (%eax)
  dec %eax
  shr $4, %ecx
  test %ecx, %ecx
  jne L1
  movb $'x', (%eax)
  movb $'0', -1(%eax)
  test %ebx, %ebx
  je L4
  dec %eax
  movb $'-', -1(%eax)
L4:
  lea -1(%eax), %ecx
  sub %esp, %eax
  mov $12, %edx
  sub %eax, %edx
  mov $4, %eax
  mov $1, %ebx
  int $0x80
  mov 12(%esp), %ebx 
  leave
  ret

