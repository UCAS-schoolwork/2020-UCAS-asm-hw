#include <stdio.h>

unsigned int shld5(unsigned int a, unsigned int b)
{
    unsigned int result;
    asm("shld $5, %1, %0\n\t"
        :"=r"(result)
        :"r"(b),"0"(a));
    return result;
}

int main() {
    unsigned a = 0x0;
    unsigned b = 0xffffffff;
    printf("%08x\n",shld5(a,b)); 
    return 0;
}


