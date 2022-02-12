; 除法运算，寄存器低地址存商，高地址存余数

; 计算 100001/100
assume cs:code

code segment

	mov dx, 1H
	mov ax, 86A1H
	mov bx, 100
	div bx

; 计算 1001/100
	mov dx,0
	mov ax,0
	mov bx,0

	mov ax, 1001
	mov bl,100
	div bl

	mov ax,4c00H
	int 21H

code ends

end