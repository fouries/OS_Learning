assume cs:code
data segment
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995' ;bx+si:0-21*4=83
        dd 166678,22,382,1356,2390,8000,16000,24486,50065,97479,140417,42949672,65536,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000                ;bx+si:84-167
        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800                                                          ;bx+si:168-209
data ends

sdata segment
        db 32 dup (0)
sdata ends

table segment
	db 21 dup ('year sume ne ?? ')
table ends

; stack segment
;         dw 40H dup (0)
; stack ends

code segment
    start:  call write_table
            mov bx, sdata
            mov ds, bx          ; ds指向 sdata段
            mov ax, table       ; es指向 table段
            mov es, ax

            mov dh, 4   ; 1行 2列
            mov dl, 16
            call show_tabledata

            mov ax, 4c00h
            int 21h

;名称：show_tabledata
;功能：将表中的数据在屏幕的适当位置显示
;参数：(dh)、(dl)表首字符的行号和列号，(cl)表中数据的颜色
;返回：没有返回值
show_tabledata: 
                push es         ; es指向 table段， ds指向 sdata段
                push ds
                push ax
                push cx
                push dx
                
                mov si, 0
                mov di, 0
                mov cx, 21

        show:   push cx
                mov cl, 082h
                mov ch, 0 
                
                call show_year
                call show_sume
                call show_ne
                call show_average

                add dh, 1
                add si, 10h

                pop cx
                loop show

                pop dx
                pop cx
                pop ax
                pop ds
                pop es
                
                ret

;名称：show_year
;功能：将 table表中的年的数据按要求显示到屏幕
;参数：
;返回：没有返回值
show_year:      push si
                push di
                push ds
                push es
                push cx
                push dx

                mov ax, es:[si]
                mov ds:[di], ax 
                mov dx, es:[si+2]
                mov ds:[di+2], dx
                pop dx
                push dx
                call show_str
                call set0

                pop dx
                pop cx
                pop es
                pop ds
                pop di
                pop si

                ret

;名称：show_sume
;功能：将 table表中的收入的数据按要求显示到屏幕
;参数：
;返回：没有返回值
show_sume:      push si
                push di
                push dx

                mov ax, es:[si+5h]
                mov dx, es:[si+7h]
                call dtoc
                pop dx
                push dx            
                add dl, 0ah
                call show_str 
                call set0


                pop dx
                pop di
                pop si

                ret

; ;名称：show_ne
; ;功能：将 table表中的人数的数据按要求显示到屏幕
; ;参数：
; ;返回：没有返回值
show_ne:        push si
                push di
                push dx        

                mov ax, es:[si+0ah]
                mov dx, 0
                call dtoc            
                pop dx
                push dx
                add dl, 14h
                
                call show_str  
                call set0

                pop dx
                pop di
                pop si

                ret

; ;名称：show_average
; ;功能：将 table表中的人均值的数据按要求显示到屏幕
; ;参数：
; ;返回：没有返回值
show_average:   
                push si
                push di
                push dx

                mov ax, es:[si+0dh]
                mov dx, 0
                call dtoc            
                pop dx
                push dx
                add dl, 1eh
                
                call show_str  
                call set0

                pop dx
                pop di
                pop si
                ret
;名称：write_table
;功能：将 data段中数据按要求写入到 table段的表中
;参数：
;返回：没有返回值
write_table:    
        push ds
        push si
        push ss
        push bx
        push bp
        push cx

        mov ax, data
        mov ds, ax
        mov ax, table
        mov ss, ax
        mov si, 0					; 指向一年中的年份数据和总收入数据
        mov bx, 0					; 指向一年中的人数数据
        mov bp, 0					; 指向表的行

        mov cx, 21

s:	mov ax, [si]				; 处理年数据
        mov [bp], ax
        mov ax, [si+2]
        mov [bp+2], ax
        mov ax, [si+54h]			; 处理总收入数据
        mov dx, [si+56h]
        mov [bp+5h], ax
        mov [bp+7h], dx
        div word ptr [bx+0a8h]		        ; 处理人均收入数据
        mov [bp+0dh],ax
        mov ax, [bx+0a8h]			; 处理人数数据
        mov [bp+0ah],ax				; 数据至此全部处理完毕
        
        add si, 4	; 指向下一年
        add bp, 10h	; 指向下一行
        add bx, 2	; 指向下一年

        loop s

        pop cx
        pop bp
        pop bx
        pop ss
        pop si
        pop ds
        
        ret

;名称：show_str
;功能：在指定位置，用指定颜色，显示一个用0结束的字符串
;参数：(dh)=行号(取值范围0~24)，（dl）=列号（取值范围0~79），（cl）=颜色，ds:si指向字符串首地址
;结果：没有返回值
 show_str:  push cx
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
            
            mov si, 0           ;;;; 最强 Bug
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
            ret

; 名称：dtoc
; 功能：将 dword型数据转变为表示十进制数的字符串，字符串以 0为结尾符
; 参数：(ax)=dword型数据的低十六位
;      (dx)=dword型数据的高十六位
;      ds:si指向字符串的首地址
; 返回：无
; 应用举例：编程，将数据 66667以十进制的形式在屏幕的 8行 3列，用绿色显示出来
;         在显示时我们地奥哟经本次实验中的第一个子程序 show_str。
    dtoc:   push ax
            push dx
            push cx
            push ds
            push si
            push bx

            call getcnt
            sub si, 1   ; 字符串最后一位数的索引等于字符个数减1

  getmod:   mov cx, ax  ; 判断数字是否取模完成
            add cx, dx
            jcxz break
            
            ; 计算出数字每一位的值，将其放入数据段中，注意是从后往前存放，si的值依次减小 
            mov cx, 10          
            call divdw 

            add cl, 30h
            mov ds:[si], cl
            dec si

            jmp short getmod

    break:  pop bx
            pop si
            pop ds
            pop cx
            pop dx
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
; 参数：(ax)= dword型被除数的低16位，(dx)= dword型被除数的高16位， (bx)= word型除数，(si)=(ax)十进制表示的位数
; 返回：(si)
   getcnt:  push ax
            push bx
            push cx
            push dx

            mov si, 0
        a:  mov cx, ax
            add cx, dx
            jcxz b
            
            mov cx, 10
            call divdw
            inc si
            jmp short a

        b:  pop dx
            pop cx
            pop bx
            pop ax
            ret

; 名称：set0
; 功能：将 sdata段中的数据清零
; 参数：
; 返回：无
set0:   push ds
        push si
        push cx

        mov si, 0
        mov cx, 8
  set:  mov word ptr [si], 0  
        add si, 2
        loop set

        pop cx
        pop si
        pop ds
        ret

code ends
end start
