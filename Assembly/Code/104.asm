assume cs:code

stack segment

	db 16 dup (0)

stack ends

code segment

start:	mov ax,stack
		mov ss,ax
		mov sp,16
 
		mov ax,6
		call ax
		inc ax
		mov bp,sp
		add ax,[bp]

		mov ax,4c00h
		int 21

code ends

end start