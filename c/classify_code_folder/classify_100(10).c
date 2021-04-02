#include <stdio.h>

/*
    在字符串中删除指定字符
*/

int main(){
     char a[256], b[256], c, alpha_for_delete;
     int i=0;
     printf("pls input char: ");
     while((c=getchar())!='\n'){
         a[i] = c;
         i++;
     }
     printf("before del: %s\n", a);
     printf("pls input the alpha to del: ");
     scanf("%c", &alpha_for_delete);
     int j = 0;
     for(int m=0; m<i; m++){
         if(a[m] != alpha_for_delete){
            b[j] = a[m]; 
            j++;
         }
     }
     b[j] = '\n';
     printf("before del:  ");
     for(int i=0; i<j; i++){
         if(b[i] != '\n'){
             printf("%c", b[i]);
         }
     }
}