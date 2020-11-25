assume cs:code
data segment
     db 'Welcome to masm!', 0
data ends

code segment
     start: mov dh, 8
	        mov dl, 3
			mov cl, 2
			mov ax, data
			mov ds, ax
			mov si, 0 
			; 定位第8行第3列的偏移量[bx存放]
			mov al,0A0h     ;00A0H为160[一行80个字符，共160字节]
			dec dh          ;行号在显存中下标从0开始,所以减1
			mul dh
			mov bx,ax
			mov al,2
			mul dl
			sub ax,2
			add bx, ax
			; 定义es为显卡段地址
			mov ax, 0B800H
			mov es, ax
			; di用于遍历
            mov di, 0
            ; 用al存储cl的值
            mov al, cl			
			; 跳转至子程序
			call show_str
			mov ax, 4c00H
			int 21h
     show_str:
			mov cl, ds:[si]
			jcxz ok 
			mov es:[bx+di], cl
			mov es:[bx+di+1], al
			inc si
			add di, 2
			jmp near ptr show_str
		  ok: 
			ret
code ends
end start