        DATA  SEGMENT
      IOPORT  EQU       0EC00H-0280H
     IO8253A  EQU       IOPORT+280H
     IO8253B  EQU       IOPORT+283H
     IO8251A  EQU       IOPORT+2B8H
     IO8251B  EQU       IOPORT+2B9H
        MES1  DB        'you can play a key on the keybord!',0DH,0AH,24H
        MES2  DD        MES1
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       DX,IO8253B  ;����8253������0������ʽ
              MOV       AL,16H
              OUT       DX,AL
              MOV       DX,IO8253A
              MOV       AL,52       ;��8253������0�ͳ�ֵ
              OUT       DX,AL
              MOV       DX,IO8251B  ;��ʼ��8251
              XOR       AL,AL
              MOV       CX,03       ;��8251���ƶ˿���3��0
      DELAY:  CALL      OUT1
              LOOP      DELAY
              MOV       AL,40H      ;��8251���ƶ˿���40H,ʹ�临λD6=1
              CALL      OUT1
              MOV       AL,4EH      ;����Ϊ1��ֹͣλ,8������λ,����������Ϊ16
              CALL      OUT1
              MOV       AL,27H      ;��8251�Ϳ����������䷢�ͺͽ���
              CALL      OUT1
              LDS       DX,MES2     ;��ʾ��ʾ��Ϣ 'you can play a key on the keybord!'
              MOV       AH,09
              INT       21H
      WAITI:  MOV       DX,IO8251B
              IN        AL,DX
              TEST      AL,01       ;�����Ƿ�׼����
              JZ        WAITI
              MOV       AH,01       ;��,�Ӽ����϶�һ�ַ�
              INT       21H
              CMP       AL,27       ;��ΪESC,����
              JZ        EXIT
              MOV       DX,IO8251A
              INC       AL
              OUT       DX,AL       ;����
              MOV       CX,0F00H
        S51:  LOOP      S51         ;��ʱ
       NEXT:  MOV       DX,IO8251B
              IN        AL,DX
              TEST      AL,02       ;�������Ƿ�׼����
              JZ        NEXT        ;û��,�ȴ�
              MOV       DX,IO8251A
              IN        AL,DX       ;׼����,����
              MOV       DL,AL
              MOV       AH,02       ;�����յ����ַ���ʾ����Ļ��
              INT       21H
              JMP       WAITI
       EXIT:  MOV       AH,4CH      ;�˳�
              INT       21H

        OUT1  PROC      NEAR        ;���ⷢ��һ�ֽڵ��ӳ���
              OUT       DX,AL
              PUSH      CX
              MOV       CX,0F00H
         GG:  LOOP      GG          ;��ʱ
              POP       CX
              RET
        OUT1  ENDP
        CODE  ENDS
              END       START
