data  segment
ioport		equ 0d400h-0280h
io8255a		equ ioport+28ah
io8255b		equ ioport+28bh
io8255c		equ ioport+288h
led      db        3fh,06h,5bh,4fh,66h,6dh,7dh,07h ;�����
data ends
code  segment
	assume cs:code,ds:data
start:	mov ax,data
	mov ds,ax
	mov dx,io8255b        ;��8255ΪA�����,C������
	mov ax,89h
	out dx,al
	mov bx,offset led  ;ʹBXָ��������ַ
sss:	mov dx,io8255a
	in  al,dx          ;��8255��C����������
	or  al,al          ;�Ƚ��Ƿ�Ϊ0
	je  sss            ;��Ϊ0,������޼����£�תsss
	mov cl,0ffh        ;cl��������,��ֵΪ-1
rr:	shr al,1
	inc cl
	jnc rr
	mov al,cl
	xlat
	mov dx,io8255c
	out dx,al
	mov dl,7           ;���� ASCII��Ϊ07
	mov ah,2
	int 21h
wai:	mov ah,1
	int 21h
	cmp al,20h         ;�Ƿ�Ϊ�ո�
	jne eee            ;����,תeee
	mov al,0           ;��,�����
	mov dx,io8255c
	out dx,al
	jmp sss
eee:	mov ah,4ch             ;����
	int 21h
code  ends
	end start
