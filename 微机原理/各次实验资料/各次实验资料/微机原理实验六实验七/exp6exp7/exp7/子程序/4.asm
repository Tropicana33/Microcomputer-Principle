;***********************************************************
;***********************************************************
;此程序演示用地址表进行参数传递
;***********************************************************
;***********************************************************
      STACKS  SEGMENT
         BUF  DW        20 DUP(?)
      STACKS  ENDS
       DATAS  SEGMENT               ;数据段
       DATA1  DB        0FFH,0FEH
         SUM  DW        0
        LIST  DW        2 DUP(0)
       DATAS  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATAS,SS:STACKS

      START:  MOV       AX,DATAS
              MOV       DS,AX
              MOV       AX,STACKS
              MOV       SS,AX
              
              MOV       LIST,OFFSET DATA1
              MOV       LIST+2,OFFSET SUM
              LEA       BX,LIST
                             
              CALL      SUM1
              MOV       SUM,AX
              MOV       AH,4CH
              INT       21H

        SUM1  PROC      NEAR
              PUSH      AX
              PUSH      BX
              PUSH      CX
              PUSH      SI
              
              MOV       SI,[BX]
              MOV       DI,[BX+2]
              MOV       AX,0
              MOV       AL,[SI]
              INC       SI
              ADD       AL,[SI]
              ADC       AH,0
              MOV       [DI],AX
              
              POP       SI
              POP       CX
              POP       BX
              POP       AX
              RET
        SUM1  ENDP
        CODE  ENDS
              END       START

