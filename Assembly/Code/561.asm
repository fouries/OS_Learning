assume cs:code
code segment

	mov ax,0ffffh
	mov ds,ax		;初始化ds:bx指向 ffff:0
	mov bx,0			

	mov dx,0			;初始化累加寄存器

	mov cx,12

s:	mov al,[bx]
	mov ah,0
	add dx, ax		;间接向dx中加上((ds)*16+(bx))单元的数值
	inc bx			;ds:bx 指向下一个单元
	loop s

	mov ax,4c00h
	int 21h

code ends
end