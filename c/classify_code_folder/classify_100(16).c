#include <stdio.h>
#include <string.h>

/*
    n个人围一圈，数1、2、3，数到3则退出，算最后留下来的人
*/

int final_num(int *m, int n);
int strlen1(int *m);

int main(){
    int n, num_final;
    printf("pls input num for people: ");
    scanf("%d", &n);
    int a[n]; 
    for(int i=0; i<n; i++){ //根据n数值进行赋值，形成数据集[初始化]
        a[i] = i+1; //1,2,3,4,5...n
    }
    num_final = final_num(a, n); 
    if(num_final == -1){
        printf("pls check u code!\n");
    }
    printf("the num to be the last one is: %d", num_final);
    return 0;
}

int final_num(int *m, int n){
    //循环计数: 当k计数到3时，将此处值置为0，否则不变[如此每判定一次则i+1,指针向后移动,
    //直到为末尾时i置为0,指针从头开始继续运动]，直到只有一个不为0的数字退出循环
    int i = 0, count=0, total=0; //i: 用于指针移动、count: 数1 2 3、total: 累加数组中为0的个数   
    while(total != (n-1)){
        if(*(m+i) != 0){ 
            count += 1;
            if(count == 3){
                *(m + i) = 0;
                total += 1;
                count = 0; //重置
            }
        }
        i++;
        if(i == n){
            i = 0; //重置
        }
    }
    for(int i=0; i<n; i++){
        if(*(m+i) != 0){
            return *(m + i);
        }
    }
    return -1;
}
