       DATAS  SEGMENT
    DATA1 DB 4 DUP(0)
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
              MOV       AX,1234H
              MOV       DI,3
              MOV       CL,0
              MOV       BL,10H
   
      RETRY:  MOV       DX,0000H
      DIV BX
              MOV       [DATA1+DI],DL
              DEC       DI
              INC       CL
              CMP       CL,4
      JNZ RETRY
      
¡¡¡¡¡¡MOV DI,0          
              MOV       AL,[DATA1]
              MOV       BL,10
RETRY2:MUL BL
              ADD       AL,[DATA1+DI+1]
              INC       DI
       CMP DI,3             
       JNZ RETRY2
       MOV BX,AX
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
