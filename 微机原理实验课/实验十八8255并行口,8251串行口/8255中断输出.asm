;*******************************;
;*        8255��ʽ1ʵ��1       *;
;*******************************;

        CODE  SEGMENT
              ASSUME    CS:CODE
      START:
              MOV       AX,CS
              MOV       DS,AX
              MOV       DX,OFFSET INT_PROC      ;�жϺ�����ƫ�Ƶ�ַ
              MOV       AX,250BH
              INT       21H         ;����IRQ3���ж�ʸ��
              MOV       DX,21H
              IN        AL,DX       ;���ж����μĴ���
              AND       AL,0F7H     ;����IRQ3�ж�
              OUT       DX,AL       ;�����ж����μĴ���
              MOV       DX,28BH     ;8255���ƿ�
              MOV       AL,0A0H     ;����A��ζ��ʽ1���
              OUT       DX,AL
              MOV       AL,0DH      ;��PC6��1��Ҳ������ACKʧЧ
              OUT       DX,AL
              MOV       BL,1        ;��ʼֵ01h
         LL:  JMP       LL          ;ѭ���ȴ��ж�
   INT_PROC:
              MOV       AL,BL
              MOV       DX,288H
              OUT       DX,AL       ;��AL��ֵ�͵�A�ڿ��Ƶ�
              MOV       AL,20H
              OUT       20H,AL      ;����EOI�����жϣ�ʹ��Ӧ���жϷ���Ĵ�����0
              SHL       BL,1        ;����1λ
              JNC       NEXT        ;����8��������ȴ�
              IN        AL,21H
              OR        AL,08H      ;�ر�IRQ3�ж�
              OUT       21H,AL
              STI                   ;�����жϱ�־λ
              MOV       AH,4CH
              INT       21H
       NEXT:  IRET
        CODE  ENDS
              END       START
