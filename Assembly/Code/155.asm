assume cs:code

stack segment
    db 128 dup (0)
stack ends

code segment
start:  mov ax, stack
        mov ss, ax
        mov sp, 128

        push cs     
        pop ds      ; (ds) = (cs)

        mov ax, 0
        mov es, ax

        mov si, offset int9                  ; 设置 ds:si指向源地址
        mov di, 204h                         ; 设置 es:di指向目标地址
        mov cx, offset int9end - offset int9 ; 设置 cx为传输长度
        cld                                  ; 设置传输方向为正
        rep movsb

        push es:[9*4]
        pop es:[200h]
        push es:[9*4+2]
        pop es:[202h]                        ; 将原来的 int 9中断例程的入口地址保存

        ; 该段程序用 cli和 sti包起来。防止执行到此段程序时发生键盘 int 9中断，导致跳转到错误的地址执行发生错误
        cli
        mov word ptr es:[9*4], 204h
        mov word ptr es:[9*4+2], 0  ; 在中断向量表中设置新的 int 9中断例程的入口地址。 
        sti

        mov ax, 4c00h
        int 21h    

; ------以下为新的 int 9中断例程--------------------
 int9:  push ax
        push bx
        push cx
        push es

        in al, 60h                  ; 从端口 60读键盘的输入
        pushf
        call dword ptr cs:[200h]    ; 当此中断例程执行时 (CS) = 0

        cmp al, 3bh                 ; f1的扫描码为 3bh
        jne int9ret

        mov ax, 0b800h
        mov es, ax
        mov bx, 1
        mov cx, 2000
    s:  inc byte ptr es:[bx]     ; 将属性值加 1，改变颜色
        add bx, 2
        loop s

int9ret:pop es
        pop cx
        pop bx
        pop ax
        iret

int9end:nop

code ends
end start