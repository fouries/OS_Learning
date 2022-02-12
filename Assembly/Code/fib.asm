; 实现求 pow(n, m)
; (bl) = n, (cx) = m
; 结果装在 dx中
assume cs:code
code segment
    start:  mov al, 255  
            mov ah, 0
            mov bl, 255
            mul bl
            ; mov cx, 3
            ; call s

            mov ax, 4c00h
            int 21h

        ; s:  mul bl
        ;     loop s  
        ;     ret
code ends
end start