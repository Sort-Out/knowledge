#include "head.h"

/*
    构建学生选课管理系统
    hint: char thingcode 
          [thingcode为用户操作事件代码，1：登录、2：注册、3：密码找回、4：选课、
                                      5: 选修课安排[51-增加、52-删除、53-修改]
                                      6：学分查询、7：成绩单打印
          账号文件地址为: D:\learning manage\repository for git\knowledge\program\c\c_project\account.txt
                        "账号密码邮箱"以account:password:email\n存储为一行[账号:0-9、密码:11-20、邮箱: 22-31]
          学生基本信息文件地址为: D:\learning manage\repository for git\knowledge\program\c\c_project\stuInfo.txt
                        "学号班级年级姓名性别年龄"以account-cla-grade-name-gender-age\n存储为一行
                                               [账号:0-9、班级：10-19、年级：20-25、姓名：26：45、性别：46-47、年龄：48]
    
*/

int main(){
    int a = 1;
    printf("%d", a);
    return 0;
}

void login_regist_retrieve(char *account, char *password, char thingcode){ 
    /*账号登录、注册、找回[AP数据类型为[account, password], char t]*/
    if(thingcode == '1'){
        //1、登录逻辑
        char a[33];
        FILE *fp = fopen(account_file, 'r');
        if(fp != NULL){
            int flag = 0; //验证是否找到该账号
            while(fgets(a, 33, fp)!= NULL){ //遍历行读取文件, 寻找对应账号数据
                for (int i = 0; i < 10; i++){
                    if(account[i]!=a[i]){ //账号判断
                        break;
                    }else if(i==9 && account[i]==a[i]){
                        flag = 1;
                    }
                if(flag == 1){
                    //验证密码
                    for (int i = 11; i < 21; i++){
                        if(password[i] != a[i]){
                            printf("password is wrong......\n");
                        }else if(i==20 && password[i]==a[i]){
                            printf("login successfully......\n");
                        }
                    }
                    break;
                }
            }
            if(flag == 0){
                printf("account is wrong......\n");
            }     
        }
        fclose(fp);
    }
    if(thingcode == '2'){
        //2、注册逻辑  [填写学生基本信息 并 设置登录密码]
        stuNode stud;
        char c;
        strcpy(stud.idcode, account);
        printf("pls input cla、grade、name、gender、age： ");
        scanf("%s, %s, %s, %s, %d", &stud.cla, &stud.grade, &stud.name, &stud.gender, stud.age); //输入学生基本信息
        stu_chain_save(stud); //存储注册的学生信息
        printf("pls input password、email to login:  ");
        //todo: 输入密码，存储账号文件
    }    
    if(thingcode == '3'){
        //3、找回逻辑[通过账号对应邮箱验证，找回密码]
        //todo...
    }
}