assume cs:code 
code segment
      start:    mov ax, cs
                mov ds, ax
                mov si, offset lp
                mov ax, 0
                mov es, ax
                mov di, 200h
                mov cx, offset lpend - offset lp
                cld
                rep movsb

                ; 设置中断向量表
                mov ax, 0
                mov ds, ax
                mov word ptr ds:[7ch*4], 200h
                mov word ptr ds:[7ch*4+2], 0

                mov ax, 4c00h
                int 21h 

         lp:    push bp
                mov bp, sp
                add [bp+2], bx
                pop bp
                iret
      lpend:    nop
code ends
end start