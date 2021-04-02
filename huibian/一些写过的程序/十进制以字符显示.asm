assume cs:code
data segment
     dd 123456
	 db 16 dup(0) ; 余数存放位置
data ends

code segment
     start:
		   mov ax, data
		   mov ds, ax 
		   
		   ; 除10运算[得出被除数的每一次余数，直到商为0位置]
		   mov bx, 10 ; 设置除数
		   mov si, 0
		   call div_10
		  
		   
		   mov ax, 4c00H
		   int 21H
		   
    div_10:		   
		   mov ax, ds:[0]
		   mov dx, ds:[2]
		   div bx 
		   ; 将余数保存至ds
		   add dl, 0030H
		   mov byte ptr ds:[4+si], dl
		   ; 如果商为0，则结束[跳转至显示程序]
		   mov cx, ax
		   jcxz ok
		   ; 如果商不为0，则继续
		   ; 修改被除数
		   inc si
		   mov ds:[0], ax
		   mov ax, 0
		   mov ds:[2], ax 
		   loop div_10
		   
	   ok: ret
code ends
end start 
		   