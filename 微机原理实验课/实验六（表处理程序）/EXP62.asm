        DATA  SEGMENT
     STRING1  DB        "ABCDEFG"
       COUNT  DW        $-STRING1
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,ES:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX
              LEA       DI,STRING1
              MOV       CX,[COUNT]

              CLD
              MOV       AL,"C"      ;����Ҫ�������ַ�

              REPNE     SCASB       ;cx=0,��zf!=0ʱ��������  al-es��(di)
              JCXZ      ALL         ;cx=0����ת������ִ����һ��
              DEC       DI          ;��ñȽϵĴ���
              MOV       BX,DI
              JMP       EXIT
        ALL:  MOV       BX,-1       ;�������������bx=-1
       EXIT:  MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START




