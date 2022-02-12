assume cs:code

data segment
    db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

code segment
    begin:  mov ax, data
            mov ds, ax
            mov si, 0
            call letterc

            mov ax, 4c00h
            int 21

  letterc:  mov cl, [si]
            mov ch, 0
            jcxz break    

            cmp byte ptr [si], 97
            jnb s1
            jmp short s2
        s1: cmp byte ptr [si], 123
            ja s2
            sub byte ptr [si], 20h
        s2: inc si
            loop letterc
     break: ret
            
code ends
end begin