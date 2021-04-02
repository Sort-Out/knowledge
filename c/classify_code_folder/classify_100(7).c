#include <stdio.h>

/*
    三元条件表达式
*/

int main(){
    int score;
    char m;
    printf("please input score: ");
    scanf("%d", &score);
    m = (score>=90)?'A':((score<60)?'C':'B');
    printf("%d 对应等级为: %c", score, m);
    return 0;
}