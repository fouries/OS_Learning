;功能：用7ch中断例程完成 jmp near ptr s指令的功能，用bx向中断例程传送转移位移
;参数：ds:si指向字符串的首地址
;应用举例：在屏幕的第12行，显示 data段中以0结尾的字符串
assume cs:code

data segment
    db "welcome to masm!", 0
data ends
`
code segment
    start:  mov dh, 10
            mov dl, 10
            mov cl, 02h
            mov ax, data
            mov ds, ax
            mov si, 0

            int 7ch                         ; 转移到标号 s处

            mov ax, 4c00h
            int 21h
code ends
end start