assume cs:code

code segment
    start:  mov ax, cs
            mov ds, ax
            mov si, offset do0      ; 设置 ds:si指向 do
            mov ax, 0
            mov es, ax
            mov di, 200h
            mov cx, offset do0end - offset do0
            cld

            rep movsb

            ; 设置中断向量表
            mov ax, 0
            mov es, ax
            mov word ptr es:[0*4], 200h
            mov word ptr es:[0*4+2], 0

            mov ax, 4c00h
            int 21
       
      do0:  jmp short do0start
            db "divide error!"
            
 do0start:  mov ax, cs
            mov ds, ax
            mov si, 202h

            mov ax, 0b800h
            mov es, ax
            mov di, 12*160+34*2     ; 设置 es:di指向显存空间的中间位置

            mov cx, 13
            mov dl, 04h              ; black background, red font         
        s:  mov al, [si]
            mov es:[di], al
            mov es:[di+1], dl
            inc si
            add di, 2
            loop s          

            mov ax, 4c00h
            int 21h
   do0end:  nop  
code ends
end start
