data segment
ioport		equ 0ec00h-0280h
io8253a		equ ioport+280h
io8253b		equ ioport+283h
io8251a		equ ioport+2b8h
io8251b		equ ioport+2b9h
  mes1 db 'you can play a key on the keybord!',0dh,0ah,24h
  mes2 dd  mes1
data ends
code segment
   assume cs:code,ds:data
start:  mov ax,data
	  mov ds,ax
	  mov dx,io8253b    ;����8253������0������ʽ
	  mov al,16h
	  out dx,al
	  mov dx,io8253a
	  mov al,52         ;��8253������0�ͳ�ֵ
	  out dx,al
	  mov dx,io8251b    ;��ʼ��8251
	  xor al,al
	  mov cx,03         ;��8251���ƶ˿���3��0
 delay: call out1
	  loop delay
	  mov al,40h        ;��8251���ƶ˿���40H,ʹ�临λD6=1
	  call out1
	  mov al,4eh        ;����Ϊ1��ֹͣλ,8������λ,����������Ϊ16
	  call out1
	  mov al,27h        ;��8251�Ϳ����������䷢�ͺͽ���
	  call out1
	  lds dx,mes2       ;��ʾ��ʾ��Ϣ 'you can play a key on the keybord!'
	  mov ah,09
	  int 21h
waiti: mov dx,io8251b
	 in al,dx
	 test al,01        ;�����Ƿ�׼����
	 jz waiti
	 mov ah,01         ;��,�Ӽ����϶�һ�ַ�
	 int 21h
	 cmp al,27         ;��ΪESC,����
	 jz exit
	 mov dx,io8251a
	 inc al
	 out dx,al         ;����
	 mov cx,0F00h
s51:   loop s51          ;��ʱ
next:  mov dx,io8251b
	 in al,dx
	 test al,02        ;�������Ƿ�׼����
	 jz next           ;û��,�ȴ�
	 mov dx,io8251a
	 in al,dx          ;׼����,����
	 mov dl,al
	 mov ah,02         ;�����յ����ַ���ʾ����Ļ��
	 int 21h
	 jmp waiti
exit:  mov ah,4ch        ;�˳�
	 int 21h

out1    proc   near      ;���ⷢ��һ�ֽڵ��ӳ���
	  out  dx,al
	  push cx
	  mov  cx,0F00h
gg:     loop gg          ;��ʱ
	  pop  cx
	  ret
out1        endp
code ends
end start
