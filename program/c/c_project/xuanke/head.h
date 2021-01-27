#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/*
    数据声明
*/
typedef struct stu{
    char idcode[10]; /*学生编号*/
    char class[10]; /*班级*/
    char grade[6]; /*年级*/
    char name[20]; /*姓名*/
    char gender[2]; /*性别*/
    char age[3]; /*年龄*/
    struct stu *stu_pre;  /*前指针*/
    struct stu *stu_next; /*后指针*/
} *StuList;

typedef struct classinfo{
    char cidcode[10];   /*课程编号*/
    char tidcode[10];   /*教师编号*/
    char ctitle[10];    /*授课题目*/
    char content[100];  /*授课内容*/
    int score;          /*学分*/
    int num;            /*可授课人数*/
    int num2;           /*已选人数*/
    char age[3];        /*年龄*/
    char address[100];  /*授课地点*/
    struct classinfo *pre;  /*前指针*/
    struct classinfo *next; /*后指针*/
} * ClassinfoList;

/*
    数据存储【账号即编号】
*/
/*账号存储：账号、密码、邮箱存储在文件中*/
void account_save(char account, char password, char *email);
/*选课情况存储: 账号、课程编号:*/
void class_choosen_save(char account, char cidcode);
/*学生基本信息存储：学生编号、班级、年级、姓名、性别*/
StuList stu_chain_save(StuList L);
/*选修课基本信息存储：课程账号、教师编号、授课题目、学分、可授课人数......*/
ClassinfoList clzxx_chain_save(ClassinfoList L);

/*功能设计*/
/*登录、注册、找回密码[AP:指向存储账号和密码的数组]*/
void login_regist_retrieve(char *AP);
/*选课：1、根据学号查询选课情况 2、学生自主进行课程选择*/
void class_choosen(char account);
/*选修课安排: 1、增加 2、删除 3、修改[flag=0(增加), flag=1(删除), flag=2(修改)*/
void classinfo_operate(int flag);
/*学分查询：通过学生编号查询总体学分成绩*/
void score_result(char account);
/*成绩单打印: 学生完整信息+总学分[需验证密码]*/
void performance_print(char *AP);