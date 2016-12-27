;***********************************************************
;***********************************************************
;此程序演示利用寄存器进行参数传递
;***********************************************************
;***********************************************************
        DATA  SEGMENT
       ARRAY  DB        0FFH,0FEH
         SUM  DW        0
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              LEA       SI,ARRAY
              CALL      SUM1
              MOV       SUM,AX
              MOV       AH,4CH
              INT       21H


        SUM1  PROC      NEAR
              MOV       AX,0
              MOV       AL,[SI]
              INC       SI
              ADD       AL,[SI]
              ADC       AH,0
              RET
        SUM1  ENDP


        CODE  ENDS
              END       START


