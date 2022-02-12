assume cs:code 
code segment
      start:    mov ax, cs
                mov ds, ax
                mov si, offset display
                mov ax, 0
                mov es, ax
                mov di, 200h
                mov cx, offset displayend - offset display
                cld
                rep movsb

                ; 设置中断向量表
                mov ax, 0
                mov ds, ax
                mov word ptr ds:[7ch*4], 200h
                mov word ptr ds:[7ch*4+2], 0

                mov ax, 4c00h
                int 21h
        
    display:    mov ax, 0b800h
                mov es, ax
                mov di, 0
                mov al, 160
                mul dh  
                add di, ax

                mov al, 2
                mul dl
                add di, ax

          s:    cmp byte ptr [si], 0
                je send

                mov al, [si]
                mov byte ptr es:[di], al
                mov byte ptr es:[di+1], cl
                add di, 2
                inc si
                jmp short s

       send:    iret 
 displayend:    nop
code ends
end start