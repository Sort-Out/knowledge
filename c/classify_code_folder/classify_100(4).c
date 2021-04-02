#include<stdio.h>

/*
    兔子生育问题
*/

int main(){
    int n, f1=1, f2=1, count;
    printf("请输入一个月份: ");
    scanf("%d", &n);
    for(int i = 1; i <=n; i++){
        if(i==1 || i==2){
            count = 1;
        }else{ 
            count = f1 + f2;
            f1 = f2;
            f2 = count;
        }
        printf("%d ", count);
    }
    return 0;
}