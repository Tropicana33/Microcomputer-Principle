;***********************************************************
;***********************************************************
;�˳�����ʾ�ô洢��Ԫ�������������в�������
;***********************************************************
;***********************************************************
        DATA  SEGMENT
       ARRAY  DB        0FEH,0FDH
         SUM  DW        0
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              CALL      SUM1
              
              MOV       AH,4CH
              INT       21H
        SUM1  PROC      NEAR
              MOV       AX,0
              MOV       SI,0
              MOV       AL,[ARRAY+SI]
              INC       SI
              ADD       AL,[ARRAY+SI]
              ADC       AH,0
              MOV       SUM,AX
              RET
        SUM1  ENDP
        CODE  ENDS
              END       START

