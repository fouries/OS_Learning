;功能：求一 word型数据的平方
;参数：(ax)=要计算的数据
;返回值：dx、ax中存放结果的高16位和低16位
;应用举例：求 2*3456^2
assume cs:code
code segment
    start:  mov ax, 3456
            int 7ch
            add ax, ax
            adc dx, dx

            mov ax, 4c00h
            int 21h
code ends
end start