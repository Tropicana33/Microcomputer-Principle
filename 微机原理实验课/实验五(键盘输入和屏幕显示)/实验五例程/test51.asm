        DATA  SEGMENT
       ECHO1  DB        "INPUT DECIMAL:$"
       ECHO2  DB        "HEX RESULT IS:$"
       ECHO3  DB        "TOO BIG!$"
        DATA  ENDS
        CRLF  MACRO                 ;��һ�γ������һ��������ʾ�ĺ�ָ�ģ��س���
              MOV       AH,2
              MOV       DL,0AH
              INT       21H
              MOV       AH,2
              MOV       DL,0DH
              INT       21H
              ENDM
        CODE  SEGMENT               ;�Ӽ�������ʮ���ƣ�ת��Ϊʮ�����ƣ�����ʾ
              ASSUME    CS:CODE
      START:  MOV       AX,DATA
              MOV       DS,AX
     REPEAT:  MOV       AH,9        ;��ʾ�ַ���
              MOV       DX,OFFSET ECHO1
              INT       21H
              CALL      DECBIN      ;����decbin��ʮ����ת��Ϊʮ������ ������ֱ�ӵ���
              CRLF                  ;����
              MOV       AH,9
              MOV       DX,OFFSET ECHO2
              INT       21H
              CALL      BINHEX
              CRLF
              JMP       REPEAT      ;����Ϊ������

     DECBIN:  MOV       BX,0
        NEW:  MOV       AH,1        ;�������벢���ԣ�AL=�����ַ�
              INT       21H
              SUB       AL,30H      ;�������ַ�ascii��ת����ʮ����
              JL        EXIT
              CMP       AL,9
              JG        EXIT        ;С��0����9����ʽ���ϸ�ֱ���˳�
              CBW                   ;�ֽ���չָ�al��չΪax ,��λ��0
              XCHG      AX,BX       ;��������ִ���bx��bx��������ۼӵ��м���
              MOV       CX,0AH
              MUL       CX          ;ax*10���ۼӽ��*10��������ڣ�dx��ax����
              JC        ERROR       ;�н�λ����������������
              XCHG      AX,BX       ;�������ݣ����м�������bx��
              ADD       BX,AX       ;�м������������������Ϊ�ۼӽ������bx
              JC        ERROR
              JMP       NEW
       EXIT:  RET

      ERROR:  MOV       AH,9        ;�������
              MOV       DX,OFFSET ECHO3
              INT       21H
              MOV       AH,4CH
              INT       21H

     BINHEX:  MOV       CH,4        ;ѭ������
     ROTATE:  MOV       CL,4        ;�ƶ�λ��
              ROL       BX,CL       ;ѭ���ƶ���ȡ���λ
              MOV       AL,BL
              AND       AL,0FH      ;ȡ�����λ
              ADD       AL,30H      ;ת��Ϊascii��
              CMP       AL,3AH      ;�ж��Ƿ����9�����С��9,ֻ���30H
              JL        PRINT
              ADD       AL,7        ;����9����37H
      PRINT:  MOV       DL,AL       ;����Ļ����ʾ
              MOV       AH,2
              INT       21H         ;��ʾ���
              DEC       CH
              JNZ       ROTATE
              RET
        CODE  ENDS
              END       START
      
