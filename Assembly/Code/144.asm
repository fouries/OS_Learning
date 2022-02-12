assume cs:code
code segment
start:  mov al, 11
        out 70h, al
        in al, 71h

        mov ah, al
        mov cl, 4
        shr ah, cl              ; 8位月份值的高四位，即月份的十位数字
        and al, 00001111b       ; 8位月份值的低四位，即月份的个位数字

        add ah, 30h 
        add al, 30h

        mov bx, 0b800h
        mov es, bx
        mov byte ptr es:[160*12+40*2], ah     ; 显示月份的十位数码
        mov byte ptr es:[160*12+40*2+1], 02
        mov byte ptr es:[160*12+40*2+2], al   ; 接着显示月份的个位数码
        mov byte ptr es:[160*12+40*2+3], 02

        mov ax,4c00h
        int 21h
code ends
end