assume cs:codesg, ds:data, es:table 
data segment 
     db '1975','1976','1977','1978','1979','1980','1981','1982','1983' 
     db '1984','1985','1986','1987','1988','1989','1990','1991','1992' 
     db '1993','1994','1995'           
     ;以上是21个年份字符(0-83) 
                             
     dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514 
     dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000 
     ;以上是21个双字型收入数据（84-167） 

     dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226 
     dw 11542,14430,15257,17800        
     ;以上是21个字型雇员数据（168—） 

data ends 

table segment 
      db 21 dup ('year sume ne ?? ' ) 
table ends                           ;21个数据放置点 

codesg segment 
start: mov ax,data 
       mov ds,ax 
       mov si,0 
       mov di,0                      ;定义数据段 
        
       mov ax,table  
       mov es,ax 
       mov bx,0                      ;定义table段 

       mov cx,21                     ;循环21次 

s:     mov ax,ds:[si] 
       mov word ptr es:[bx],ax 
       mov ax,ds:[si+2] 
       mov word ptr es:[bx+2],ax              ;完成年份的处理 

       mov ax,ds:[0a8h+di] 
       mov word ptr es:[bx+0ah],ax             ;完成雇员数据的处理 
       
       mov ax,ds:[54h+si] 
       mov word ptr es:[bx+5h],ax 
       mov dx,ds:[56h+si] 
       mov word ptr es:[bx+7h],dx              ;完成收入数据的处理 

       div word ptr es:[bx+0ah] 
       mov word ptr es:[bx+0dh],ax             ;完成人均收入数据的处理 

       add si,4 
       add di,2 
       add bx,10h               ;为下一轮做准备 
       loop s 

       mov ax,4c00h 
       int 21h                        ;返回 

codesg ends 
end start