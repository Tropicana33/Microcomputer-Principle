data segment
ioport		equ 01400h-0280h
luport		equ ioport+29ah             ;¼���ڵ�ַ
fangport		equ ioport+290h             ;�����ڵ�ַ
io8253a		equ ioport+283h
io8253b		equ ioport+280h
io8255c		equ ioport+28bh
io8255d		equ ioport+288h
data_qu  db 60000 dup(?)                         ;¼�����ݴ��������
news_1   db 'Press any key to record:',24h       ;¼����ʾ
news_2   db 0dh,0ah,' Playing:',24h              ;������ʾ
data     ends

code segment
	assume cs:code,ds:data,es:data
begin:	mov ax,data                              ;��ʼ��
	 mov  ds,ax
	 mov es,ax
	 mov  dx,offset news_1                    ;��ʾ¼����ʾ
	 mov  ah,9
	 int  21h
test_1:	 mov  ah,1                                ;�ȴ���������
	 int  16h
	 jz  test_1                               ;��������ѭ���ȴ�
	 call  lu                                 ;����¼���ӳ���
	 mov dx,offset news_2                     ;��ʾ������ʾ
	 mov ah,9
	 int 21h
fy: 	 call fang                                ;���÷����ӳ���
	 mov ax,0c07h
	 int 21h
	 cmp al,20h
	 jz fy
	 mov ah,4ch                              ;����DOS
	 int 21h
lu proc near                                ;¼���ӳ���
	 mov di,offset data_qu                   ;���������׵�ַΪDI
	 mov cx,60000                            ;¼60000������
	 cld
xunhuan:	mov dx,luport                             ;����A/D
	out dx,al
	call delay                               ;��ʱ
	in al,dx                                 ;��A/D�����ݵ�AL
	stosb                                    ;����������,ʹDI��1
	loop xunhuan                             ;ѭ��
	ret                                      ;�ӳ��򷵻�
lu endp
fang proc near                                  ;�����ӳ���
	 mov cx,60000                            ;��60000������
	 mov si,offset data_qu                   ;���������׵�ַΪSI
	 cld
fang_yin:	mov dx,fangport
	 lodsb                                   ;��������ȡ������
	 sub al,30h
	 out dx,al                               ;����
	 call delay                              ;��ʱ
	 loop fang_yin                           ;ѭ��
	 ret                                     ;�ӳ��򷵻�
fang endp
delay proc	near                                 ;��ʱ�ӳ���
	push	dx
	mov	al,10h                       ;��8254ͨ��0������ʽ0
	mov	dx,io8253a
	out	dx,al
	mov	al,200                           ;д���������ֵ200
	mov	dx,io8253b
	out	dx,al
	mov	dx,io8255c                       ;��8255��A��Ϊ����
	mov	al,9bh
	out	dx,al
	mov	dx,io8255d                       ;��8255��A������
delay1:	in	al,dx
	and	al,1                             ;�ж�PA0�Ƿ�Ϊ1
	jz	delay1                           ;��PA0��Ϊ1,תde_lay
	pop	dx
	ret                                          ;�ӳ��򷵻�
delay endp
	code ends
	end begin
