#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/time.h>

static inline unsigned long long rdtsc()
{
    unsigned long long tick;
    asm volatile("rdtsc":"=A"(tick));
    return tick;
}

extern void mymemcpy(void *,void *,size_t);
unsigned testsize[30] = {3,7,19,35,65,113,153,255,567,1111,2567,7777,23432,76345,201234,2012345,5676543,8399999,10123456,123456789};

int num = 20;

int main()
{
    volatile unsigned long long tick1,tick2;
    struct timeval tv1, tv2;
    char *dest, *src;
    int cycletime;
    double time;

//Act once and verify correct correctness.
    printf("Act once and verify correct correctness.\n");
    printf("%10s  %s\n","SIZE","RDTSC");
    for(int i=0;i<num;i++){
        cycletime = 1;
        printf("%10d",testsize[i]);
        dest = (char *)malloc(testsize[i]);
        src = (char *)malloc(testsize[i]);
        memset(src,-1,testsize[i]);
        memset(dest,0,testsize[i]);
        tick1 = rdtsc();
        mymemcpy(dest,src,testsize[i]);
        tick2 = rdtsc();      
        printf("  %llu",tick2-tick1);
        for(int j=0;j<testsize[i];j++){
            if(dest[j]!=-1){
                printf("  Wrong at %d.\n",j);
                goto NEXT;
            }
        }
        printf("  Pass.\n");
NEXT:
        free(dest);
        free(src);
    }

//Loop and test efficiency. 
    printf("\nLoop and test efficiency. \n");
    printf("%10s  %10s  CYCLE\n","SIZE","TIME");
    for(int i=0;i<num;i++){
        cycletime = 380000000/testsize[i];
        printf("%10d",testsize[i]);
        dest = (char *)malloc(testsize[i]);
        src = (char *)malloc(testsize[i]);
        memset(src,-1,testsize[i]);
        mymemcpy(dest,src,testsize[i]);
        gettimeofday(&tv1,NULL);
        for(int j=0;j<cycletime;j++){
            mymemcpy(dest,src,testsize[i]);
        }
        gettimeofday(&tv2,NULL);
        time = (tv2.tv_sec-tv1.tv_sec)*1000+(tv2.tv_usec-tv1.tv_usec)/1000.0;
        printf("  %10.3fms",time);
        printf("  %u\n",cycletime);
        free(dest);
        free(src);
    }
    
    return 0;
}

