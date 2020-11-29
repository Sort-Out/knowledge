assume cs:code
code segment
     start:
			mov ax, cs
			mov ds, ax

			mov si, offset do0 ; do0中断程序的ip

			mov ax, 0 ; es:[di]指向0000:0200, 用于存放do0
			mov es, ax  
			mov di, 200h

			mov cx, offset do0end-offset do0 ; 正向遍历将ds:[si]地址内容赋值到es:[di]地址中
			cld 
			rep movsb

			mov ax, 0 ; 设置中断表项，将0号表项值设置为do0内存地址值
			mov es, ax
			mov word ptr es:[0*4], 200h
			mov word ptr es:[0*4+2], 0

			mov ax, 4c00h
			int 21h
		   
	   do0: jmp short do0start ; do0程序: 显示特定字符串
			db "overflow"
  do0start: mov ax, cs   
			mov ds, ax
			mov si, 202h ; overflow字符串开始地址

			mov ax, 0b800h
			mov es, ax
			mov di, 12*160+36*2 ; 设置显卡显示地址

			mov cx, 9   
	      s:mov al, [si]    ; 循环显示overflow
			mov es:[di], al
			mov al, 2
			mov es:[di+1], al 
			inc si
			add di, 2
			loop s

			mov ax, 4c00h
			int 21h
			  
    do0end: nop  ; do0end不做执行[仅用于计算do0代码占用字节长度]	
code ends
end