#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
    ����һ���ַ�������д���ļ�֮ǰ��Сдת��д��������'!'
*/

int main(){
    FILE *fp = fopen("C:\\Users\\xxc\\Desktop\\desk.txt", "w+");
    char c[50]; 
    if(fp != NULL){
        printf("pls input : "); 
        gets(c);
        int len = strlen(c);
        for(int i=0; i<len; i++){
            if(c[i]>='a' && c[i]<='z'){
                c[i] = c[i] - 32;
            }
        }
        c[len] = '!';
        fputs(c, fp);
        fclose(fp); 
    }
    else{
        exit(0); //�����˳�״̬
    }
    return 0;
}