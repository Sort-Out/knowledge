assume cs:code
data segment
     db 9,8,7,4,2,0
	 ;年：9单元、月：8单元、日：7单元、时：4单元
	 ;分：2单元、秒：0单元
data ends
code segment
     start: 
	       mov ax, data
		   mov ds, ax
		   
		   mov ax, 0B800H
		   mov es, ax
		   
		   mov si, 0 ; 用于data数据遍历
           mov di, 2000
		   mov cx, 6
		   call show
           
           mov ax, 4c00h
           int 21h
        show:
		   push cx
           mov al, ds:[si] ;得到ds:[si]对应单元字节数据	
		   out 70h, al
		   in al, 71h
		   
		   mov ah, al ; BCD十进制转换为对应字符
		   mov cl, 4
		   shr ah, cl  ; ah为十位数
		   and al, 00001111b ; al为个位数
		   add al, 30h  ; 数值0转化为字符串0
		   add ah, 30h  ; ..
		   
		   mov byte ptr es:[di], ah  ;将内容写入显卡地址
		   mov bl, 2
		   mov byte ptr es:[di+1], bl
		   mov byte ptr es:[di+2], al 
		   mov byte ptr es:[di+3], bl
		   
		   inc si
		   add di, 6
		   
		   pop cx
		   loop show
		   
  		zf: 
		   mov bx, 2000 ; 使用di相同位置
		   mov ah, 2                  ; 给年月日.,添加间隔符 
     	   mov al, 2dh
		   mov byte ptr es:[bx+4], al
		   mov byte ptr es:[bx+5], ah
           mov byte ptr es:[bx+10], al
		   mov byte ptr es:[bx+11], ah
		   mov al, 20h
		   mov byte ptr es:[bx+16], al
		   mov byte ptr es:[bx+17], ah
		   mov al, 3ah
		   mov byte ptr es:[bx+22], al
		   mov byte ptr es:[bx+23], ah
		   mov byte ptr es:[bx+28], al
		   mov byte ptr es:[bx+29], ah 
		endo: 
           ret		
code ends
end start 
		   
		   
		   