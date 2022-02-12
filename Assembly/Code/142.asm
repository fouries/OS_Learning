assume cs:code
code segment
    mov ax, 10
    push ax

    shl ax, 1
    mov bx, ax

    pop ax
    mov cl, 3
    shl ax, cl
    add ax, bx

	mov ax,4c00h
    int 21h
code ends
end