assume cs:code

code segment 
    start:  mov ax, 1
            mov cx, 5
            call s                                    
            mov bx, ax
            mov ax, 4c00h
            int 21
        s:  add ax, ax
            loop s
            ret
code ends
end start