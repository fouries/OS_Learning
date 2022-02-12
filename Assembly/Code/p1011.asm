; 将 data段的字符串转换位大写
assume cs:code

data segment
    db 'conversation' ; 16byte
data ends

code segment 
    start:  mov ax, data
            mov ds, ax
            mov si, 0
            mov cx, 12
            call capital
            
            mov ax, 4c00h
            int 21
  
  capital:  and byte ptr [si], 11011111b
            inc si
            loop capital
            ret
code ends
end start