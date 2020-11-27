assume cs:codesg
datasg segment
       db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends

codesg segment
     begin: 
	        mov ax, datasg
	        mov ds, ax
			mov si, 0
			call letterc
			
			mov ax, 4c00h
			int 21h
     letterc:
	         ; 0、是否为'0'
             cmp byte ptr ds:[si], 48
			 je recall
			 ; 1、是否小于97
			 cmp byte ptr ds:[si], 97
			 jb next
			 ; 2、是否大于122 
			 cmp byte ptr ds:[si], 122
			 ja next
			  
			 ; 小写转大写
			 mov al, byte ptr ds:[si]
			 sub al, 32
			 mov ds:[si], al 
        next:
		     inc si 
			 loop letterc
		recall:
		       ret 

codesg ends 
end begin