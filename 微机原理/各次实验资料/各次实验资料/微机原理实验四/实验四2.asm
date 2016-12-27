DATAS SEGMENT
    DATA2 DB 5 DUP(0)
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
              MOV       AX,3039H
              MOV       DI,4
              MOV       CL,0
              MOV       BL,10
   
      RETRY:  MOV       DX,0000H
      DIV BX
              MOV       [DATA2+DI],DL
              DEC       DI
              INC       CL
      CMP CL,5             
              JNZ       RETRY
    MOV AH,4CH
    INT 21H
CODES ENDS
              END       START
