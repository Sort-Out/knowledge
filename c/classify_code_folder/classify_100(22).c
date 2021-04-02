#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
    输入一串字符串，在写入文件之前，小写转大写。并加上'!'
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
        exit(0); //正常退出状态
    }
    return 0;
}