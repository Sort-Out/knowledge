#include <stdio.h>
#include <stdlib.h>

/*
    文件写入[一个字符一个字符写入]
*/

int main(){
    FILE *fp = fopen("C:\\Users\\xxc\\Desktop\\desk.txt", "w+");
    char c; 
    if(fp != NULL){
        printf("pls input : "); 
        while((c = getchar()) != '#'){
            fputc(c, fp);
        }
        fclose(fp);
    }else{
        exit(0);
    }
    system("pause");
    return 0;
}