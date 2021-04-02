assume cs:code
code segment
    start: 
	     mov ax, cs
		 mov ds, ax 
		 mov si, offset site
		 mov cx, offset end0-offset site ; 代码长度
         
		 mov ax, 0
         mov es, ax
         mov di, 0200h
		 
		 cld   ; 安装中断例程
		 rep movsb
		 
		 mov ax, 0
		 mov word ptr es:[4*7ch+2], ax ; 更改中断向量表
		 mov bx, 0200h
         mov word ptr es:[4*7ch], bx 		 
		 
		 mov ax, 4c00h
		 int 21h
		 
	site: 
         mov ax, 0B800H
		 mov es, ax

         ; 计算显示偏移
		 mov ah, 0   ; 计算行偏移
		 mov al, dh
		 mov bx, 160 
		 mul bx
	     mov dx, ax 
		 dec dl    ; 计算列偏移
		 mov al, dl
		 mov bl, 2
		 mul bl 
		 mov bx, ax
		 add ax, bx
         mov di, ax		 
	
	show: 
         cmp byte ptr ds:[si], 0	; 循环显示字符
         je retu
		 mov al, byte ptr ds:[si]
		 mov es:[di], al
		 mov es:[di+1], cl
		 inc si
		 add di, 2
		 jmp short show 
	retu:
	     iret 
		 
	end0:
	    nop
	
code ends
end start 