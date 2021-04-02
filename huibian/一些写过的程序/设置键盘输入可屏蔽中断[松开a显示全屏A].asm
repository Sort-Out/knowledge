assume cs:code
stack segment
      db 128 dup (0)
stack ends 
code segment 
     start:
	       ;使用stack 为栈
		   mov ax, stack 
		   mov ss, ax 
		   mov sp, 128
		   ;安装新int 9代码[0:204]
           push cs
		   pop ds 
		   
		   mov ax, 0
		   mov es, ax
		   mov si, offset int9
		   mov di, 0204H
		   mov cx, offset end0 - offset int9
		   cld 
		   rep movsb
		   ;保存原int 9指向的cs, ip[保存地址:0:200]
		   push es:[4*9]
		   pop es:[200h]
		   push es:[4*9+2]
		   pop es:[202h]		   
		   ;设置新int 9指向cs, ip
		   cli		   
		   mov word ptr es:[4*9], 0204H
		   mov word ptr es:[4*9+2], 0
		   sti
		   
		   
		   ; 程序结束
		   mov ax, 4c00h
		   int 21h
    int9:   
	       ; 因为执行完中断程序后, 返回源程序继续执行, 所以需要保存中断程序使用的寄存的值
		   push ax
		   push bx
		   push es 
		   push cx 

           mov ax, 0
		   mov es, ax
		   ; 模拟执行int 9, 根据输入键符增加相应功能
           in al, 60h ; 读取输入 
           pushf 
           call dword ptr cs:[200h]
	      
		   ; 判断是是A键松开[如果是则执行正常逻辑, 否则执行A键松开逻辑]
		   cmp al, 1eh+80h
		   jne int9end  
		  
		   ; 执行从A键松开的逻辑
           mov cx, 2000
	       mov ax, 0B800H
		   mov es, ax
		   mov bx, 0
	show_A:	   
		   mov byte ptr es:[bx], 'A'
		   add bx, 2
		   loop show_A
  int9end: 
           pop cx
		   pop es
		   pop bx
		   pop ax	   
           iret
     end0: 
	       nop			  

code ends 
end start 		   
    		   
		  
		   