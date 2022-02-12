entry _start
_start:
! 首先读入光标的位置
	mov	ah,#0x03		! read cursor pos
	xor	bh,bh			! 读光标位置
	int	0x10

! 显示字符串 “Hello OS world, my name is ZQ”
	mov	cx,#35			! 共 35个字符
	mov	bx,#0x0007		! page 0, attribute 7 (normal)
	mov	bp,#msg1		! 指向要显示的字符串

! es:bp 是显示字符串的地址
! 相比与 linux-0.11中的代码，需要增加对 es的处理，因为源代码中在输出之前已经处理了 es
	mov	ax,#0x07c0		! 将 es段寄存器设置为 0x7c0
	mov es, ax
	mov ax, #0x1301		! write string, move cursor
	int	0x10			! 写字符串并移动光标

! 设置一个无限循环
inf_loop:
	jmp inf_loop

msg1:
	.byte 13,10
	.ascii "Hello OS world, my name is ZQ"
	.byte 13,10,13,10

.org 510
boot_flag:
	.word 0xAA55
