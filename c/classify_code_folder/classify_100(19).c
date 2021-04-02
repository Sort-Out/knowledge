#include <stdio.h>
#include <malloc.h>

/*
    反向输出链表
*/

typedef struct LNode
{
    int money;
    char name[20];
    struct LNode* next;
    struct LNode* prev;
}LNode, *LinkList;  //如果是创建

LinkList createLNode(int n);
void print_prev(LinkList cont);

int main(){
    LinkList Head = NULL; //头指针
    Head = createLNode(3);
    print_prev(Head);
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
    q->prev = NULL;
    for (int i = 0; i < n; i++){ //根据链表大小动态创建链表
        p = (LinkList)malloc(sizeof(LNode));  
        if(!p){
            return 0;
        }
        //链表赋值
        printf("the %dth to be valued: \n", i+1);
        scanf("%d, %s", &(p->money), p->name);

        p->next = NULL;
        p->prev = q; //前指针指向

        q->next = p;
        q = p;
    }
    
    return q;
}

void print_prev(LinkList cont)
{
    printf("start to print_prev data: \n");
    while(cont->prev != NULL){  
        printf("%d, %s\n", cont->money, cont->name);
        cont = cont->prev;
    }
}
