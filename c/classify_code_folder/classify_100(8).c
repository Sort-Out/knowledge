#include <stdio.h>

/*
    计算最大公约数、最小公倍数
*/

int main(){
    int m, n, max_yue=1, min_bei=1;
    printf("please input two num: ");
    scanf("%d, %d", &m, &n);
    for(int i=1; i<=m*n; i++){
        if(m%i == 0 && n%i == 0){ 
            max_yue = i; //公约数
        }
        if(i%m == 0 && i%n == 0){ //公倍数
            min_bei = i;
            break;
        }
    }
    printf("max_yue = %d,min_bei = %d", max_yue, min_bei);
    return 0;
}