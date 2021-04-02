#include <stdio.h>

/*
    根绝不同的利润计算奖金
*/

double bonus(double i);//函数声明

int main(){
    double l; //当月利润
    printf("请输入当月利润: ....");
    scanf("%lf", &l);
    double i = bonus(l/10000);
    printf("所能获得的奖金为: %lf\n", i);
    return 0;
}

double bonus(double i){
    double m=0;
    if(i<=10){
        m = i*0.1; 
    }else if(i>=10 && i<20){
        m = 10*0.1 + (i-10)*0.075; 
    }else if(i>=20 && i<40){
        m = 10*0.1 + 10*0.075 + (i-20)*0.05;
    }else if(i>=40 && i<60){
        m = 10*0.1 + 10*0.75 + 20*0.05 + (i-40)*0.03;
    }else if(i>=60 && i<100){
        m = 10*0.1 + 10*0.75 + 20*0.05 + 20*0.03 + (i-60)*0.015;
    }else if(i>=100){
        m = 10*0.1 + 10*0.75 + 20*0.05 + 20*0.03 + 40*0.015 + (i-100)*0.01;
    }
    return m*10000;
}
