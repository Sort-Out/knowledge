#include "head.h"

/*
    构建学生选课管理系统
    思路：1、使用txt文件存储基础信息, 程序开启会从txt文件读取基本信息[如账号、选课情况信息、学生基础信息] [choiced]
         2、使用数据库记录程序使用的信息
         [本程序使用第一种思路,从文本文件加载信息到对用链表中,后续使用链表进行查、增、该、删操作]

    hint: char thingcode 
          [thingcode为用户操作事件代码，1：登录、2：注册、3：密码找回、
                                      4：选课情况查询[指定账号]、5：学生自主选课
                                      6: 选修课[整体查询]、7：选修课[新增]、8：选修课[修改]、9：选修课[删除]
                                      10: 学生信息[指定账号查询]、11：学生信息[新增]、12：学生信息[修改]、13：学生信息[删除]
                                      14、成绩单打印
    
*/

int main(){

    return 0;
}