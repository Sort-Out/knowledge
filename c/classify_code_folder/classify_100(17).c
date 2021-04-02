#include <stdio.h>

/*
    结构体创建和输出
*/

typedef struct Student
{
    /* data */
    int age;
    char name[20];
    char gender[2];
} stu;

void input(stu* student, int n);
void output(stu* student, int n);

int main(){
    stu student[5];
    input(student, 5);
    output(student, 5);
    return 0;
}

void input(stu* student, int n){
    printf("pls input infor: \n");
    for (int i = 0; i < n; i++){
        scanf("%d, %s, %s", &(student[i].age), student[i].name, student[i].gender); //结构体赋值注意&
    }
}

void output(stu* student, int n){
    for (int i = 0; i < n; i++){
        printf("%d, %s, %s\n", student[i].age, student[i].name, student[i].gender);
    }
}