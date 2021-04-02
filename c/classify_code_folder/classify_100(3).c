#include <stdio.h>

/*
    计算输入的年月日是当年的第几天
*/

int main(){
    int year, month, day, count;
    count = 0;
    printf("请输入年月日: ");
    scanf("%d, %d, %d", &year, &month, &day);
    if(((year%400)==0 || ((year%4)==0 && (year%100)!=0)) && month>2){ //如果是闰年且是3月及以上,则加1
        count += 1;
    }
    switch(month){
        case 1: count += 0; break;
        case 2: count += 31; break;
        case 3: count += 31 + 28; break;
        case 4: count += 31 + 28 + 31; break;
        case 5: count += 31 + 28 + 31 + 30; break;
        case 6: count += 31 + 28 + 31 + 30 + 31; break;
        case 7: count += 31 + 28 + 31 + 30 + 31 + 30; break;
        case 8: count += 31 + 28 + 31 + 30 + 31 + 30 + 31; break;
        case 9: count += 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31; break;
        case 10: count += 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30; break;
        case 11: count += 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31; break;
        case 12: count += 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30; break;
    }
    count += day;
    printf("%d-%d-%d 是%d的第%d天", year, month, day, year, count);
    return 0;
}
