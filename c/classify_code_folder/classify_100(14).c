#include <stdio.h>

/*
    >> & ~ 位运算符号使用
*/

int main()
{
    unsigned a,b,c,d;
    printf("请输入整数：\n");
    scanf("%o",&a);
    b=a>>4;
    c=~(~0<<4);
    d=b&c;
    printf("%o\n%o\n",a,b);
    printf("%d\n", ~(~0<<4)); //~0: 1、 ~0<<4: 0001 0000[~会改变符号，产生-16]、~(~0<<4): 0000 1111 [15]
    return 0;
}