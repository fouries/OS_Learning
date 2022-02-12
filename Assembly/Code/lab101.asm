assume cs:code
data segment
    db 'Welcome to masm!', 0
data ends

code segment
    start:  mov dh, 25
            mov dl, 4
            mov cl, 2
            mov ax, data
            mov ds, ax
            mov si, 0
            call show_str

            mov ax, 4c00h
            int 21h
;名称：show_str
;功能：在指定位置，用指定颜色，显示一个用0结束的字符串
;参数：(dh)=行号(取值范围0~24)，（dl）=列号（取值范围0~79），（cl）=颜色，ds:si指向字符串首地址
;结果：没有返回值
 show_str:  push ax
            push cx
            push dx
            push es
            push si
            push di

            mov ax, 0b800h  ; 先计算出要显示的 8行 3列在显存中的地址
            mov es, ax
            mov al, 0a0h
            sub dh, 1   
            mul dh
            mov di, ax
            mov dh, 0
            add dl, dl
            add di, dx
            sub di, 2
            mov dl, cl

     disy:  mov cl, [si]
            mov ch, 0h
            jcxz ok

            ; 在屏幕上显示出来
            mov al, [si]
            mov es:[di], al
            mov es:[di+1h], dl
            add di, 2

            inc si
            jmp short disy

       ok:  pop di
            pop si
            pop es
            pop dx
            pop cx
            ret

code ends
end start


; display:    mov cl, [si]
;             mov ch, 0h 
;             jcxz ok