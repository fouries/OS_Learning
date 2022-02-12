assume cs:code
code segment
start:  ; 显示 年
        mov al, 9
        call readCMOS
        mov dh, 14
        mov dl, 30
        call display

        ; 显示 /
        add dl, 2
        mov al, 47
        call symbol

        ; 显示 月
        mov al, 8
        call readCMOS
        add dl, 1
        call display
                
        ; 显示 /
        add dl, 2
        mov al, 47
        call symbol

        ; 显示 日
        mov al, 7
        call readCMOS
        add dl, 1
        call display

        ; 显示 时
        mov al, 4
        call readCMOS
        add dl, 3
        call display

        ; 显示 :
        add dl, 2
        mov al, 58
        call symbol

        ; 显示 分
        mov al, 2
        call readCMOS
        add dl, 1
        call display

        ; 显示 :
        add dl, 2
        mov al, 58
        call symbol

        ; 显示 秒
        mov al, 0
        call readCMOS
        add dl, 1
        call display

; 函数名：readCMOS
; 功能：从 CMOS RAM读取数据到(al)中
; 参数：(al), 读取CMOS RAM的偏移地址
; 返回值：(al)
readCMOS:
        out 70h, al
        in al, 71h
        ret

; 函数名：display
; 功能：将从 CMOS中读取出的数字在屏幕的适当位置显示出来
; 参数：(al)读取出的BCD格式的时间信息，(dh), (dl)要显示的行列的起始位置
; 返回值：无
display:
        push dx
        mov ah, al
        mov cl, 4
        shr ah, cl              ; 8位月份值的高四位，即月份的十位数字
        and al, 00001111b       ; 8位月份值的低四位，即月份的个位数字       
                
        add ah, 30h
        add al, 30h

        push ax
        mov bx, 0b800h
        mov es, bx
        mov ax, 160
        mul dh
        mov si, ax
        mov ax, 2
        mul dl
        add si, ax
        pop ax

        mov byte ptr es:[si], ah     ; 显示月份的十位数码
        inc si
        mov byte ptr es:[si], 02
        inc si
        mov byte ptr es:[si], al   ; 接着显示月份的个位数码
        inc si
        mov byte ptr es:[si], 02
        inc si
        pop dx
        ret

; 函数名：symbol
; 功能：在屏幕的某位置显示符号
; 参数：(dh), (dl)要显示的行列的起始位置，(al)要显示的符号的 ascii码 '/':47， ':':58
; 返回值：无
symbol:
        push dx
        push ax
        mov bx, 0b800h
        mov es, bx
        mov ax, 160
        mul dh
        mov si, ax
        mov ax, 2
        mul dl
        add si, ax
        pop ax

        mov byte ptr es:[si], al     ; 显示月份的十位数码
        mov byte ptr es:[si+1], 02

        pop dx
        ret

        mov ax,4c00h
        int 21h
code ends
end