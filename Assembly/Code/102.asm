assume cs:code

stack segment

	db 16 dup (0)

stack ends

code segment

start:	mov ax,stack
		mov ss,ax
		mov sp,16
 
		mov ax,0
		call ax
		inc ax
	s:	pop ax

		mov ax,4c00h
		int 21

code ends

end start