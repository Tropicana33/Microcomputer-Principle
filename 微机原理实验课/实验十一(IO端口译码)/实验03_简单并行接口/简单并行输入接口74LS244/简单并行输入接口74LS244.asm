;********************************;
;*    �򵥲�������ʵ��          *;
;********************************;
      IOPORT  EQU       0DC00H-0280H
       LS244  EQU       IOPORT+2A0H
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       DX,LS244    ;��2A0����һ����
              IN        AL,DX
              MOV       DL,AL       ;���������ݱ�����DL��
              MOV       AH,02
              INT       21H
              MOV       DL,0DH      ;��ʾ�س���
              INT       21H
              MOV       DL,0AH      ;��ʾ���з�
              INT       21H
              MOV       AH,06       ;�Ƿ��м�����
              MOV       DL,0FFH
              INT       21H
              JNZ       EXIT
              JE        START       ;����,��תstart
       EXIT:  MOV       AH,4CH      ;����
              INT       21H
        CODE  ENDS
              END       START
