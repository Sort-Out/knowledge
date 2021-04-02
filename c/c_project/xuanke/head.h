#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
    变量声明
*/
//"账号 密码 邮箱" 以 account password email\n存储为一行
#define  account_file "D:\\learning manage\\repository for git\\knowledge\\program\\c\\c_project\\account.txt" //账号保存文件地址
//"学号 班级 年级 姓名 性别 年龄"以account cla grade name gender age\n存储为一行
#define  stu_info_file "D:\\learning manage\\repository for git\\knowledge\\program\\c\\c_project\\stuInfo.txt" //学生信息保存文件地址
//"课程编号 教师编号 授课题目 授课内容 学分 可授课人数 授课地点"
// 以 "cidcode tidcode ctitle content score num address\n"存储为一行
#define  class_info_file "D:\\learning manage\\repository for git\\knowledge\\program\\c\\c_project\\classInfo.txt" //课程信息保存文件地址
//"学生编号 课程编号" 以 account cidcode\n存储为一行
#define  choiced_class_file "D:\\learning manage\\repository for git\\knowledge\\program\\c\\c_project\\choicedClassInfo.txt" //学生选课情况文件地址

/*
    数据声明
*/
typedef struct stuNode{
    char idcode[10];        /*学生编号*/
    char cla[10];           /*班级*/
    char grade[6];          /*年级*/
    char name[20];          /*姓名*/
    char gender[2];         /*性别*/
    int age;                /*年龄*/
    struct stuNode *prev_stu; //前指针
    struct stuNode *next_stu; //后指针
} stuNode, *stunodeList;

typedef struct classinfoNode{
    char cidcode[10];   /*课程编号*/
    char tidcode[10];   /*教师编号*/
    char ctitle[10];    /*授课题目*/
    char content[100];  /*授课内容*/
    int score;          /*学分*/
    int num;            /*可授课人数*/
    char address[100];  /*授课地点*/
    struct classinfoNode *prev_class; //前指针
    struct classinfoNode *next_class; //后指针
} classinfoNode, *classinfoList;

/*
    数据存储【登录账号即学生编号、教师编号、管理员账号】
*/
/*账号存储：账号、密码、邮箱存储在文件中*/
void account_save(char *account, char *password, char *email);
/*学生基本信息存储：学生编号、班级、年级、姓名、性别、年龄*/
void stu_chain_save(stuNode L);
/*选修课基本信息存储：课程账号、教师编号、授课题目、学分、可授课人数......*/
void clzxx_chain_save(classinfoNode L);
/*选课情况存储: 学生编号、课程编号:*/
void class_choosen_save(char *account, char *cidcode);

/*功能设计*/
/*登录、注册、找回密码[AP:指向存储账号和密码的数组]*/
void login(char *account, char *password); //登录
void reGister(char *account); //注册
void retrieve(char *account); //忘记密码
/*学分查询：根据学号查询选课情况、学生自主进行课程选择*/
void class_choosen_info(); //根据学号查询选课情况[学生选的课默认都有满分，该功能代表查选修课总分]
void class_choose(); //学生自主选课
/*选课信息编辑: 增删改查*/
void classinfo_inquire(); //选课查询[显示所有选课详细信息、显示可选课程信息]
void classinfo_insert(); //选课增加
void classinfo_update(char *cid); //选课内容更新
void classinfo_delete(char *cid); //选课删除[删除课程id对应课程信息]
/*学生信息编辑：增删改查*/
void stuinfo_inquire(char *stu_id); //查询[显示学生账号对应学生信息]
void stuinfo_insert(char *stu_id); //增加学生
void stuinfo_update(char *stu_id); //修改[指定学生编号对应学生信息]
void stuinfo_delete(char *stu_id); //删除[删除学生编号对应学生信息]
/*成绩单打印: 学生完整信息+总学分[需验证密码]*/
void performance_print(char *stu_id);