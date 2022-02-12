assume cs:code

stack segment
	db 16 dup (0)
stack ends

code segment 
		mov ax, 4c00h
		int 21
start:	mov ax,stack
		mov ss,ax
		mov sp,10h
		
		mov ax,0
		push ax
		ret
code ends

end start