ioport		equ 0d400h-0280h
io0832a	equ ioport+290h
code segment
   assume cs:code
start: mov cl,0
       mov dx,io0832a
lll:   mov al,cl
	out dx,al
	inc cl        ;cl��1
	inc cl
	inc cl
	inc cl
	inc cl
	inc cl
	inc cl
	push dx
	mov ah,06h      ;�ж��Ƿ��м�����
	mov dl,0ffh
	int 21h
	pop dx
	jz  lll       ;������תLLL
	mov ah,4ch    ;����DOS
	int 21h
code ends
end start
