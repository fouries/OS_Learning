;功能：用 7ch中断例程完成 loop指令的功能
;应用举例：在屏幕中间显示 80个“!”
assume cs:code

code segment
    start:  mov ax, 0b800h
            mov es, ax
            mov di, 12*160


            mov bx, offset s - offset se    ; 设置从标号 se到标号 s的转移位移
            mov cx, 80
        s:  cmp byte ptr es:[di], '!'
            add di, 2
            
            int 7ch                         ; 如果(cx)!=0, 转移到标号 s处
       se:  nop
       
            mov ax, 4c00h
            int 21h
code ends
end start