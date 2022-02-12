assume cs:code
code segment
    start:  mov ax, cs
            mov ds, ax
            mov di, 200h
            mov ax, 0
            mov es, ax
            mov si, offset sqr
            mov cx, offset sqrend - offset sqr
            cld
            rep movsb

            ; 设置中断向量表
            mov ax, 0
            mov ds, ax
            mov word ptr ds:[7ch*4], 200h
            mov word ptr ds:[7ch*4+2], 0

            mov ax, 4c00h
            int 21h

      sqr:  mul ax
            iret

   sqrend:  nop
code ends
end start