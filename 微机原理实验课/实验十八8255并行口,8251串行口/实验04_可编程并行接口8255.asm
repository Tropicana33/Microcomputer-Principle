ioport		equ 0d400h-0280h
io8255a		equ ioport+288h
io8255b		equ ioport+28bh
io8255c		equ ioport+28ah
code   segment
	  assume cs:code
start:  mov dx,io8255b           ;设8255为C口输入,A口输出
	  mov al,8bh
	  out dx,al
inout:  mov dx,io8255c             ;从C口输入一数据
	  in al,dx
	  mov dx,io8255a             ;从A口输出刚才自C口
	  out dx,al               ;所输入的数据
	  mov dl,0ffh                ;判断是否有按键
	  mov ah,06h
	  int 21h
	  jz inout                ;若无,则继续自C口输入,A口输出
	  mov ah,4ch              ;否则返回DOS
	  int 21h
code   ends
	  end start
