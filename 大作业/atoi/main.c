#include <stdio.h>
extern int atoi(const char *nptr);

int main()
{  
    printf("%15sOutput\n","Expected ");
    char s1[]=" +12345";
    char s2[]="+asd777";
    char s3[]="-999999999999asd";
    char s4[]="2147483647+";
    char s5[]="+2147483648+ss";
    char s6[]=" -2147483647 d";
    char s7[]="00ww00";
    char s8[]="          -2147483648";
    char s9[]=" 020 3";
    char s10[]=" 9999999997";
    printf("%15s","12345 "); printf("%d\n",atoi(s1));
    printf("%15s","0 "); printf("%d\n",atoi(s2));
    printf("%15s","-2147483648 "); printf("%d\n",atoi(s3));
    printf("%15s","2147483647 "); printf("%d\n",atoi(s4));
    printf("%15s","2147483647 "); printf("%d\n",atoi(s5));
    printf("%15s","-2147483647 "); printf("%d\n",atoi(s6));
    printf("%15s","0 "); printf("%d\n",atoi(s7));
    printf("%15s","-2147483648 "); printf("%d\n",atoi(s8));
    printf("%15s","20 "); printf("%d\n",atoi(s9));
    printf("%15s","2147483647 "); printf("%d\n",atoi(s10));
    
    return 0;
}
