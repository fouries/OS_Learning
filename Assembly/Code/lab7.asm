ssume cs:code,ds:data,ss:table

data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
	; 以上是表示 21年的 21个字符串
	
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	; 以上是表示 21年公司总收入的 21个 dword型数据

	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
	; 以上是表示 21年公司雇员人数的 21个 word型数据
data ends

table segment
	db 21 dup ('year sume ne ?? ')
table ends

code segment
	start:	mov ax, data
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
			div word ptr [bx+0a8h]		; 处理人均收入数据
			mov [bp+0dh],ax
			mov ax, [bx+0a8h]			; 处理人数数据
			mov [bp+0ah],ax				; 数据至此全部处理完毕
			
			add si, 4	; 指向下一年
			add bp, 10h	; 指向下一行
			add bx, 2	; 指向下一年

			loop s

			mov ax, 4c00h
			int 21
code ends
end start