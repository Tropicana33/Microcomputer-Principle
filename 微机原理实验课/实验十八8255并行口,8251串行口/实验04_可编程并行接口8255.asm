ioport		equ 0d400h-0280h
io8255a		equ ioport+288h
io8255b		equ ioport+28bh
io8255c		equ ioport+28ah
code   segment
	  assume cs:code
start:  mov dx,io8255b           ;��8255ΪC������,A�����
	  mov al,8bh
	  out dx,al
inout:  mov dx,io8255c             ;��C������һ����
	  in al,dx
	  mov dx,io8255a             ;��A������ղ���C��
	  out dx,al               ;�����������
	  mov dl,0ffh                ;�ж��Ƿ��а���
	  mov ah,06h
	  int 21h
	  jz inout                ;����,�������C������,A�����
	  mov ah,4ch              ;���򷵻�DOS
	  int 21h
code   ends
	  end start
