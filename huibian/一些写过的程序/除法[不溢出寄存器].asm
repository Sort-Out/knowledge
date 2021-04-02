assume cs:codesg
data segment
     dd 1000099
     dw 10,0,0 
	 dd 0,0
data ends


codesg segment
    start: 
         ; 提取除数与被除数 
		 mov ax, data
		 mov ds, ax
		 mov cx, ds:[4]
		 ; 调用子程序divdw
         call divdw
		 
		 mov ax, 4c00h		 
	     int 21h		
		 
	divdw:
	    ;使用ds段H/N的商和余
	     mov dx, 0
		 mov ax, ds:[2]
 		 div cx; 
		 mov ds:[6], ax
		 mov ds:[8], dx
      
	     ; 涉及两次乘65536, 迭代si, 用ss:[si]存放两次结果
		 mov si, 0
				
		 ; 计算int(H/N)*65536
		 call mul_x
		 ; 计算rem(H/N)*65536
		 mov ax, ds:[8]
         call mul_x
		 
		 ; 计算+L的值
		 mov ax, ds:[0]
		 add ds:[14], ax
		
        ; 计算[rem(H/N)*65536+L]/N的值	
		 mov ax, ds:[14]
		 mov dx, ds:[16]
		 div cx 
		 mov cx, dx 
		 
		 ; 计算最终结果值
		 mov dx, ds:[12] 
		 ret 
		 
    mul_x: 
	     ; 乘法: 计算x*65536的值[高位放在dx中，低位放在ax中]
		 ; ss:[0]~ss:[2]存放int(H/N)*65536
		 ; ss:[4]~ss:[6]存放rem(H/N)*65536
		 mov bx, 0
		 mov ds:[10+si], bx 
		 mov ds:[10+si+2], ax
         add si, 4	 
		 ret 
		 
codesg ends
end start		

		 

                              
		 
	
        
		 
		 
           

       