#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
unsigned long s[2000];
int sp;
int mode[8000];

int cmp1(const void *a, const void *b) //use for qsort
{
	return *(unsigned long*)a - *(unsigned long*)b;
}

int main()
{
    struct timeval tv1, tv2;
    unsigned long cpufreq, time;

    for(int i=0;i<100;i++){
            asm volatile(
                ".rept 100000\n\t"
                "add $3, %%eax\n\t"
                ".endr\n\t"
                :
                :
            );
    }
    for(int i=0;i<100;i++){
        gettimeofday(&tv1,NULL);
            asm volatile(
                ".rept 100000\n\t"
                "add $5, %%eax\n\t"
                ".endr\n\t"
                :
                :
            );
        gettimeofday(&tv2, NULL);
        time = (tv2.tv_sec-tv1.tv_sec)*1000000+(tv2.tv_usec-tv1.tv_usec);
        s[sp++] = time;
    }
    qsort(s,sp,sizeof(unsigned long),cmp1);
    for(int i=0;i<sp;i++){
        if(s[i]>0&&s[i]<8000) mode[s[i]]++;
    }
    //求众数
    unsigned maxc;
    unsigned zhong;
    zhong=maxc=0;
    for(int i=7999;i>0;i--){
       if(mode[i]>maxc){
           maxc = mode[i];
           zhong = i;
       }
    }
    cpufreq = 100000/zhong;
    printf("The cpu frequency is %lu MHz\n", cpufreq);
    return 0;
}



