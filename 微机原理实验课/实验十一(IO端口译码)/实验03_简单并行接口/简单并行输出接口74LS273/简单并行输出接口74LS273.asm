      IOPORT  EQU       0E800H-0280H
       LS273  EQU       IOPORT+2A8H
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:
              MOV       AH,2        ;�س���
              MOV       DL,0DH
              INT       21H
              MOV       AH,1        ;�ȴ���������
              INT       21H
              CMP       AL,27       ;�ж��Ƿ�ΪESC��
              JE        EXIT        ;�������˳�
              MOV       DX,LS273    ;������,��2A8H�����ASCII��
              OUT       DX,AL
              JMP       START       ;תstart
       EXIT:  MOV       AH,4CH      ;����
              INT       21H
        CODE  ENDS
              END       START
