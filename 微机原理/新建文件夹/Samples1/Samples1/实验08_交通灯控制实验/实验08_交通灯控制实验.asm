;***********************************;
;*    ʮ��·�ں��̵�ģ����ʾ����   *;
;* �˿ڸ��Ƶ�����:                 *;
;*   1�� 1�� 1�� 0 0 2�� 2�� 2��   *;
;***********************************;
data segment
ioport		equ 0d400h-0280h
io8255a		equ ioport+28ah
io8255b		equ ioport+28bh
portc1  db  24h,44h,04h,44h,04h,44h,04h   ;�����ƿ���
	db  81h,82h,80h,82h,80h,82h,80h   ;��״̬����
	db  0ffh                          ;������־
data ends
code  segment
      assume  cs:code,ds:data
start:
	mov   ax,data
	mov   ds,ax
	mov   dx,io8255b
	mov   al,90h
	out   dx,al           ;����8255ΪC�����
	mov   dx,io8255a
re_on:	mov   bx,0
on:	mov   al,portc1[bx]
	cmp   al,0ffh
	jz    re_on
	out   dx,al           ;������Ӧ�ĵ�
	inc   bx
	mov   cx,20           ;��������ֵ
	test  al,21h          ;�Ƿ����̵���
	jz    de1             ;û��,����ʱ
	mov   cx,2000         ;��,����ʱ
de1:	mov   di,9000         ;di����ֵ5000
de0:	dec   di              ;��1����
	jnz   de0             ;di��Ϊ0
	loop  de1
	push dx
	mov ah,06h
	mov dl,0ffh
	int 21h
	pop dx
	jz  on                ;û��,ת��on
exit:	mov   ah,4ch          ;����
	int   21h
code ends
	end start
