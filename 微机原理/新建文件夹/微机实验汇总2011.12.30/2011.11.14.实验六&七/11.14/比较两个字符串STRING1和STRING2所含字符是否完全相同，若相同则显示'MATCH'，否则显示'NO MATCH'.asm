; �Ƚ������ַ���STRING1��STRING2�����ַ��Ƿ���ȫ��ͬ������ͬ����ʾ'MATCH'��������ʾ'NO MATCH'

        DATA  SEGMENT

       MATCH  DB        'Match'
         EOS  DB        0
      NMATCH  DB        'No match'

        STR1  DB        'abcd'
        STR2  DB        'abcd'
        STR3  DB        ?

        DATA  ENDS

        CODE  SEGMENT
        MAIN  PROC      FAR
              ASSUME    CS:CODE,DS:DATA,ES:DATA
      START:
              PUSH      DS
              SUB       AX,AX
              PUSH      AX

              MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX

              MOV       CX,STR2-STR1            ; STRING1�ĳ��ȱ��浽CX
              CMP       CX,STR3-STR2            ; �Ƚ�STRING1��STRING2�ĳ����Ƿ���ͬ
              JNE       PRT_NM      ;��ͬ����ʾ'NO MATCH'

              LEA       SI,STR1
              LEA       DI,STR2
       COMP:  MOV       BL,[SI]
              CMP       BL,[DI]
            ; cmp     bl,ds:[di]
              JNE       PRT_NM
              INC       SI
              INC       DI
              LOOP      COMP



              LEA       SI,MATCH    ; �Ե����ַ���ʽ��ʾ�ַ���'MATCH' ,�ý�����־0����ѭ������
              MOV       AH,2
      CONTM:  MOV       DL,[SI]
              INT       21H
              INC       SI
              CMP       BYTE PTR [SI],0
              JNE       CONTM
              JMP       EXIT

     PRT_NM:  MOV       CX,8        ;�Ե����ַ���ʽ��ʾ�ַ���'NO MATCH'�����ַ����ַ���������ѭ������
              LEA       SI,NMATCH
              MOV       AH,02
     CONTNM:  MOV       DL,[SI]
              INT       21H
              INC       SI
              LOOP      CONTNM

       EXIT:  RET
        MAIN  ENDP

        CODE  ENDS
              END       START
