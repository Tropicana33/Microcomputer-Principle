      IOPORT  EQU       0D400H-0280H
     IO8253A  EQU       IOPORT+280H
     IO8253B  EQU       IOPORT+281H
     IO8253C  EQU       IOPORT+283H
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       DX,IO8253C  ;��8254д������
              MOV       AL,36H      ;ʹ0ͨ��Ϊ������ʽ3
              OUT       DX,AL
              MOV       AX,1000     ;д��ѭ��������ֵ1000
              MOV       DX,IO8253A
              OUT       DX,AL       ;��д����ֽ�
              MOV       AL,AH
              OUT       DX,AL       ;��д����ֽ�
              MOV       DX,IO8253C
              MOV       AL,76H      ;��8254ͨ��1������ʽ2
              OUT       DX,AL
              MOV       AX,1000     ;д��ѭ��������ֵ1000
              MOV       DX,IO8253B
              OUT       DX,AL       ;��д���ֽ�
              MOV       AL,AH
              OUT       DX,AL       ;��д���ֽ�
              MOV       AH,4CH      ;�����˳�
              INT       21H
        CODE  ENDS
              END       START
