ioport		equ 0d400h-0280h
io8255a		equ ioport+280h
io8255b		equ ioport+281h
io8255c		equ ioport+283h
io8255d		equ ioport+288h
io8255e		equ ioport+28bh
code segment
	  assume cs:code
start:  mov dx,io8255e         ;��8255ΪA������,C�����
	mov al,90h
lll:    out dx,al
	mov al,01           ;��PC0��λ
	out dx,al
	call delay          ;��ʱ5s
	mov al,0            ;��PC0��λ
	out dx,al
	call delay          ;��ʱ5s
	jmp lll             ;תlll
delay proc near           ;��ʱ�ӳ���
	push dx
	mov dx,io8255c         ;��8254������Ϊ��ʽ3
	mov al,36h
	out dx,al
	mov dx,io8255a
	mov ax,10000          ;д���������ֵ10000
	out dx,al
	mov al,ah
	out dx,al
	mov dx,io8255c
	mov al,70h            ;�������1Ϊ������ʽ0
	out dx,al
	mov dx,io8255b
	mov ax,500            ;д���������ֵ500
	out dx,al
	mov al,ah
	out dx,al
ll2:  mov ah,06           ;�Ƿ��м�����
	mov dl,0ffh
	int 21h
	jne exit              ;������תexit
	mov dx,io8255d
	in  al,dx             ;��ѯ8255��PA0�Ƿ�Ϊ�ߵ�ƽ
	and al,01
	jz  ll2               ;�����������
	pop dx
	ret                   ;��ʱʱ�䵽���ӳ��򷵻�
exit: mov ah,4ch
	int 21h
delay endp
	code ends
	end start
