#include <stdio.h>

/*
    有1、2、3、4个数字，能组成多少个互不相同且无重复数字的三位数
*/

int main(){
    int count = 0; //统计
    for(int a=1; a<5; a++){ //百位
        for (int b=1; b<5; b++) { //十位
            if(a==b){
                continue;  
            }
            for (int c=1; c<5; c++){//个位
               if(a==c || b==c){
                   continue;
               }
               count += 1;
               printf("%d\n", 100 * a + 10 * b + c);
            }
        }
    }
    printf("total: %d\n", count);
    return 0;
}
