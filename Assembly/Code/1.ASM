assume cs:code

data segment
  db 16 dup(0)
data ends

code segment
  start:                
         mov ax, 4c00h
         int 21
code ends
end start

