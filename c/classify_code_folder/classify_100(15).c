#include <stdio.h>

/*
    用指针排大小
*/

void sorte(int *a, int *b, int *c);
int main(){
    int m, n, l;
    printf("pls input three num: ");
    scanf("%d,%d,%d", &m, &n, &l);
    sorte(&m, &n, &l);
    return 0;
}

void sorte(int *a, int *b, int *c){
    int *t;
    if(*a<*b){
        t = a;
        a = b;
        b = t;
    }
    if(*a<*c){
        t = a;
        a = c;
        c = t;
    }
    if(*b<*c){
        t = b;
        b = c;
        c = t;
    }
    printf("%d, %d, %d", *a, *b, *c);
}