assume cs:code

code segment
start:  mov ah, 0
        int 7ch

        mov ah, 1 
        mov al, 6
        int 7ch


        mov ah, 2
        mov al, 7
        int 7ch

        mov ah, 3
        int 7ch
        
        mov ax, 4c00h
        int 21h

delay:  push ax
        push dx
        mov dx, 10h
        mov ax, 0
    s1: sub ax, 1
        sbb dx, 0
        cmp ax, 0
        jne s1
        cmp dx, 0
        jne s1
        pop dx
        pop ax
        ret

code ends
end start