assume cs:b,ds:a,ss:c

a segment

	dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah,0987h

a ends

c segment

	dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

c ends

b segment

d:	mov ax,c
	mov ss,ax
	mov sp,20h
	
	mov ax,a
	mov ds,ax

 s:	push [bx]
	add bx,2
	loop s
	
	mov bx,0
	mov cx,8
s0:	pop [bx]
	add bx,2
	loop s0

	mov ax,4c00h
	int 21h

b ends

end d