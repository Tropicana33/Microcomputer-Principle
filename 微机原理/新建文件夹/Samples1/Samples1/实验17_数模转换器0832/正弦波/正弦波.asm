data  segment
ioport	equ 0d400h-0280h
io0832a	equ ioport+290h
sin	db 80h,96h,0aeh,0c5h,0d8h,0e9h,0f5h,0fdh
	db 0ffh,0fdh,0f5h,0e9h,0d8h,0c5h,0aeh,96h
	db 80h,66h,4eh,38h,25h,15h,09h,04h
	db 00h,04h,09h,15h,25h,38h,4eh,66h           ;���Ҳ�����
data ends
code segment
   assume cs:code,ds:data
start:
mov ax,data
	mov ds,ax
ll:	mov si,offset sin        ;�����Ҳ����ݵ�ƫ�Ƶ�ַΪSI
	mov bh,32                ;һ�����32������
lll:	mov al,[si]              ;�����������D/Aת����
	mov dx,io0832a
	out dx,al
	mov ah,06h
	mov dl,0ffh
	int 21h
	jne exit
	mov cx,1
delay:
loop delay               ;��ʱ
	inc si                   ;ȡ��һ������
	dec bh
	jnz lll                  ;��δȡ��32��������תlll
	jmp  ll
exit:	mov ah,4ch               ;�˳�
	int 21h
code ends
end start
