      IOPORT  EQU       0EC00H-0280H
     IO8253A  EQU       IOPORT+283H
     IO8253B  EQU       IOPORT+280H
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       AL,14H      ;����8253ͨ��0Ϊ������ʽ2,�����Ƽ���
              MOV       DX,IO8253A
              OUT       DX,AL
              MOV       DX,IO8253B  ;�ͼ�����ֵΪ0FH
              MOV       AL,0FH
              OUT       DX,AL
        LLL:  IN        AL,DX       ;�Ӽ������˿ڶ�ȡ����ֵ
              CALL      DISP        ;����ʾ�ӳ���
              PUSH      DX
              MOV       AH,06H
              MOV       DL,0FFH
              INT       21H
              POP       DX
              JZ        LLL
              MOV       AH,4CH      ;�˳�
              INT       21H
        DISP  PROC      NEAR        ;��ʾ�ӳ���
              PUSH      DX
              AND       AL,0FH      ;����ȡ����λ
              MOV       DL,AL
              CMP       DL,9        ;�ж��Ƿ�<=9
              JLE       NUM         ;������Ϊ'0'-'9',ASCII���30H
              ADD       DL,7        ;����Ϊ'A'-'F',ASCII���37H
        NUM:  ADD       DL,30H
              MOV       AH,02H      ;��ʾ
              INT       21H
              MOV       DL,0DH      ;�ӻس���
              INT       21H
              MOV       DL,0AH      ;�ӻ��з�
              INT       21H
              POP       DX
              RET                   ;�ӳ��򷵻�
        DISP  ENDP
        CODE  ENDS
              END       START
