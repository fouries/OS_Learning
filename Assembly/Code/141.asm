assume cs:code
code segment
    ; 读取 CMOS RAM的 2号单元的内容
    mov al, 2
    mov ah, 0
    out 70h, al
    in al, 71h

    ; 向 CMOS RAM的 2号单元写入 0
    mov al, 2
    out 70h, al
    mov al, 0
    out 71h, al

    ; 读取 CMOS RAM的 2号单元的内容
    mov al, 2
    out 70h, al
    in al, 71h

	mov ax,4c00h
    int 21h
code ends
end