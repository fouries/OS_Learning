assume cs:code

a segment

	db 1,2,3,4,5,6,7,8

a ends

b segment

	db 1,2,3,4,5,6,7,8

b ends

c segment

	db 0,0,0,0,0,0,0,0

c ends

code segment

start:		mov ax,a
			mov ds,ax
			mov bx,0
			
			mov cx,8

	s:  		mov bx,8
			sub bx,cx
			mov al,[bx]
			add bx,10h
			add al,[bx]
			add bx,10h
			mov [bx],al

			loop s
code ends

end start