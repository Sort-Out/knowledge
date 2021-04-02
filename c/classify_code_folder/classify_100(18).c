#include <stdio.h>
#include <malloc.h>

/*
    链表创建和输出
*/

typedef struct LNode
{
    int money;
    char name[20];
    struct LNode* next; 
}LNode, *LinkList;  //如果是创建

LinkList createLNode(int n);
void print(LinkList cont);

int main(){
    LinkList Head = NULL; //头指针
    Head = createLNode(3);
    print(Head);
    return 0;
}

LinkList createLNode(int n){
    //创建链表并返回
    LinkList L, q, p; //L: 头结点、q: 链接链表、p：不断动态创建链表并添加内容数据
    L = (LinkList)malloc(sizeof(LNode)); //头结点创建
    if(!L){
        return 0;
    }
    q = L;
    q->next = NULL; //头结点初始next指向NULL
    for (int i = 0; i < n; i++){ //根据链表大小动态创建链表
        p = (LinkList)malloc(sizeof(LNode));  
        if(!p){
            return 0;
        }
        //链表赋值
        printf("the %dth to be valued: \n", i+1);
        scanf("%d, %s", &(p->money), p->name);

        p->next = NULL; 
        q->next = p; 
        q = p;
    }
    return L;
}

void print(LinkList cont)
{
    LinkList l = cont->next;
    printf("start to print data: \n");
    while(l!=NULL){
        printf("%d, %s\n", l->money, l->name);
        l = l->next;
    }
}
