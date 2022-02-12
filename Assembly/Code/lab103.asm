assume cs:code
data segment
    db 10 dup (0)
data ends

code segment
    start:  mov bx, data
            mov ds, bx
            mov si, 0                                                                                                                                                                                
            mov ax, 65535
            call dtoc

            mov dh, 11
            mov dl, 11
            mov cl, 2
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

            add si,1
            jmp short disy

       ok:  pop di
            pop si
            pop es
            pop dx
            pop cx
            pop ax
            ret

; 名称：dtoc
; 功能：将 word型数据转变为表示十进制数的字符串，字符串以 0为结尾符
; 参数：(ax)=word型数据
;      ds:si指向字符串的首地址
; 返回：无
; 应用举例：编程，将数据 12666以十进制的形式在屏幕的 8行 3列，用绿色显示出来
;         在显示时我们地奥哟经本次实验中的第一个子程序 show_str。
    dtoc:   push ax
            push cx
            push ds
            push si
            push dx
            push bx
            
            mov bx, 10
            mov dx, 0

            call getcnt
            sub si, 1   ; 字符串最后一位数的索引等于字符个数减1

  getmod:   mov cx, ax  ; 判断数字是否取模完成
            jcxz break
            
            ; 计算出数字每一位的值，将其放入数据段中，注意是从后往前存放，si的值依次减小
            mov dx, 0 
            mov cx, 10          
            call divdw 

            add cl, 30h
            mov ds:[si], cl
            dec si

            jmp short getmod

    break:  pop bx
            pop dx
            pop si
            pop ds
            pop cx
            pop ax
            ret        

;名称:     divdw
;功能:     进行不会产生溢出的除法运算，被除数位 dword型，除数位 word型，结果为 dword型
;参数:     (ax)=dword型数据的低16位
;         (dx)=dword型数据的高16位
;         (cx)=除数
;返回:     (dx)=结果的高16位，(ax)=结果的低16位
;         (cx)=余数
divdw:  push bx                
        push ax        ;储存低位

        mov ax, dx
        mov dx, 0
        div cx          ;先计算高16位除法，(dx,ax)/cx=ax.....dx
        mov bx, ax      ;把高位除法结果暂存bx
        
        pop ax
        div cx         ;计算低16位除法，(dx,ax)/cx=ax.....dx
        
        mov cx, dx     ;返回余数cx
        mov dx, bx     ;返回高16位dx, 低16位ax
        
        pop bx                                
        ret            
            
; 名称：getcnt
; 功能：计算十进制的数有多少位
; 参数：(ax)= word型被除数，(bx)= word型除数，(si)=(ax)十进制表示的位数
; 返回：(si)
   getcnt:  push ax
            push bx
            push dx
            push cx

            mov si, 0
        a:  mov cx, ax
            jcxz b
            
            div bx
            mov dx, 0
            inc si
            jmp short a

        b:  pop cx
            pop dx
            pop bx
            pop ax
            ret
code ends
end start
