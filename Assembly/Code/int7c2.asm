assume cs:code 
code segment
      start:    mov ax, cs
                mov ds, ax
                mov si, offset capital
                mov ax, 0
                mov es, ax
                mov di, 200h
                mov cx, offset capitalend - offset capital
                cld
                rep movsb

                ; 设置中断向量表
                mov ax, 0
                mov ds, ax
                mov word ptr ds:[7ch*4], 200h
                mov word ptr ds:[7ch*4+2], 0

                mov ax, 4c00h
                int 21h

    capital:    push cx
                push si

                mov si, 0
          s:    mov cl, [si]
                mov ch, 0
                jcxz ok

                and byte ptr [si], 11011111b
                inc si
                jmp short s
         ok:    pop si
                pop cx
                iret
 capitalend:    nop
code ends
end start