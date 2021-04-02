#include <stdio.h>
#include <math.h>

/*
    将一个正整数分解质因数。例如：输入90,打印出90=2*3*3*5
*/

int main(){
    int n;
    printf("please input num: ");
    scanf("%d", &n);
    printf("%d = ", n);
    for(int i=2; i<=n; i++){
        if(n%i == 0){
            if(i!=n){
                printf("%d*", i);
            }else{
                printf("%d", i);
                break;
            }  
            n = n/i;
            i = 1;
        }
    }
    return 0;
}