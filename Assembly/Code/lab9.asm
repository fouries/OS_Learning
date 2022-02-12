assume cs:code, ds:data

data segment
    db 'welcome to masm!'
data ends

code segment
    start:  mov ax, data
            mov ds, ax
            
            mov ax, 0b800h
            mov es, ax

            mov cx, 3
            mov bx, 0
            mov di, 720h
        s:  
            mov dx, cx
            mov cx, 16
            mov si, di
            s1: mov al, ds:[bx]
                mov es:[si], al
                mov byte ptr es:[si+1h], 92h
                inc bx
                add si, 2
                loop s1
            add di,0a0h
            mov cx, dx
            mov bx, 0
            loop s
            
            mov ax, 4c00h
            int 21
code ends
end start