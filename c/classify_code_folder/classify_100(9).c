#include <stdio.h>

/*
    递归计算阶乘
*/

int fac(int a);

int main(){
    int count;
    count = fac(5);
    printf("5! value = %d", count);
    return 0;
}

int fac(int a){
    int m = 0;
    if(a==1){
        return a;
    }
    else{
        m = a*fac(a-1);
    }
    return m;
}