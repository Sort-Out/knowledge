#include <stdio.h>
#include <math.h>

/*
    计算101~200的素数
*/

int main(){
    int a = 101, b = 200, flag;
    for(int i=a; i<=b; i++){
        flag = 0;
        for(int j=2; j<=sqrt(i); j++){
            if(i%j == 0){
                flag = 1;
                break;
            }
        }
        if(flag == 0){
            printf("%d ", i);
        }
    }
    return 0;
}