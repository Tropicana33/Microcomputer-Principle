      IOPORT  EQU       0EC00H-0280H
     IO8255A  EQU       IOPORT+288H ;A��
     IO8255B  EQU       IOPORT+28BH ;���ƿ�
     IO8255C  EQU       IOPORT+28AH ;C��
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       DX,IO8255B  ;��8255ΪC������,A�����
              MOV       AL,8BH      ;10001011B,A�ڷ�ʽ0�����C��B�����룬B�ڹ�����ʽ0
          ��  OUT       DX,AL
      INOUT:  MOV       DX,IO8255C  ;��C������һ����
              IN        AL,DX
              MOV       DX,IO8255A  ;��A������ղ���C�������������
              OUT       DX,AL
              MOV       DL,0FFH     ;�ж��Ƿ��а���
              MOV       AH,06H
              INT       21H
              JZ        INOUT       ;����,�������C������,A�����
              MOV       AH,4CH      ;���򷵻�DOS
              INT       21H
        CODE  ENDS
              END       START
