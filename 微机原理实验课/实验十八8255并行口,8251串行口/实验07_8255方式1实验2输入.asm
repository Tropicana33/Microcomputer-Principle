;08.10.2 test OK
.MODEL        SMALL
.386
         IO_8255_ADDRESS  EQU       200H        ;8255��ֵַ
        DATA  SEGMENT
         TAB  DB        01H,02H,04H,08H,10H,20H,40H,80H
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       DX,IO_8255_ADDRESS+3    ;���ƿ�
              MOV       AL,0B0H     ;A�ڷ�ʽ1�����룬C������
              OUT       DX, AL
              MOV       AL,08H      ;����INTEA��0  ,pc4��0
              OUT       DX, AL
              MOV       DX,IO_8255_ADDRESS+1    ;A��
              MOV       AL,00H      ;���ó�ֵ=00H Ϩ��LED
              OUT       DX, AL
               
                
        SS0:  MOV       DX,IO_8255_ADDRESS+2    ;8255 C��
        SS1:  IN        AL, DX      ;����C�����ݵ�AL
              TEST      AL,00100000B            ;pc5=1?  æ������ȴ�
              JZ        SS1         ;=0  wait
              MOV       DX,IO_8255_ADDRESS      ;A��
              IN        AL,DX       ;A������AL
              AND       AL,07H      ;ȡ��3λ
              MOV       BX,OFFSET TAB
              XLAT      TAB         ;����ָ�al--al+bl        ,tabΪ�׵�ַ
              MOV       DX,IO_8255_ADDRESS+1
              OUT       DX,AL       ;AL�����B��
              JMP       SS0
                 
       
        CODE  ENDS
              END       START

