;***********************************************************
;***********************************************************
;�˳�����ʾ�ö�ջ�ν��в�������
;***********************************************************
;***********************************************************
      STACKS  SEGMENT
         BUF  DW        20 DUP(?)
      STACKS  ENDS
       DATAS  SEGMENT               ;���ݶ�
       DATA1  DB        0FDH,0FFH
         SUM  DW        0
       DATAS  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATAS,SS:STACKS

      START:  MOV       AX,DATAS
              MOV       DS,AX
              MOV       AX,STACKS
              MOV       SS,AX
              MOV       SP,SIZE BUF
              
              LEA       BX,DATA1
              PUSH      BX
              LEA       BX,SUM
              PUSH      BX
              MOV       BX,0        ;���������ֻ��Ϊ���ô������BX�ı仯

              CALL      SUM1
              MOV       AH,4CH
              INT       21H

        SUM1  PROC      NEAR
              PUSH      AX
              PUSH      BX
              PUSH      BP
              MOV       BP,SP
              MOV       BX,[BP+8]
              MOV       SI,[BP+10]
              MOV       AX,0
              MOV       AL,[SI]
              INC       SI
              ADD       AL,[SI]
              ADC       AH,0
              MOV       [BX],AX
              POP       BP
              POP       BX
              POP       AX
              RET
        SUM1  ENDP
        CODE  ENDS
              END       START

