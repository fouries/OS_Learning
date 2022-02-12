assume cs:code

stack segment

	db 16 dup (0)

stack ends

code segment

start:	mov ax,stack
		mov ss,ax
		mov sp,16
 
		mov ax,0123h
		mov ds:[0],ax
		call word ptr ds:[0]

		mov ax,4c00h
		int 21

code ends

end start