;功能：将一个趋势子母，以0结尾的字符串，转换为大写
;参数：ds:si指向字符串的首地址
;应用举例：将data段中的字符串转换为大写
assume cs:code

data segment
    db 'conversation', 0
data ends

code segment
    start:  mov ax, data
            mov ds, ax
            mov si, 0
            int 7ch

            mov ax, 4c00h
            int 21h
code ends
end start