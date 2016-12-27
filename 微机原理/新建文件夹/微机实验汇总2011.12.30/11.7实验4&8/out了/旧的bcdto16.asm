        DISP  MACRO     NN
              MOV       AH,02H
              LEA       DX,NN
              INT       21H
              ENDM

        DATA  SEGMENT
           W  DW        9345H
         DA2  DW        0000H
         BUF  DB        5 DUP(0)
        DATA  ENDS
      STACK1  SEGMENT
              DW        32 DUP(0)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       CX,3
              MOV       AX,W
              MOV       BX,AX
      AGAIN:  MOV       DX,0F000H
              AND       DX,BX
              ROL       DX,4
              MOV       AX,DX
            
              ADD       AX,DA2
              MOV       DX,10
              MUL       DX
              MOV       DA2,AX
              SHL       BX,4
              AND       BX,BX
              DEC       CX
              JNZ       AGAIN
              ROL       BX,4
              ADD       DA2,BX

              
              MOV       AX,DA2
              MOV       AH,4CH
              INT       21H



        CODE  ENDS
              END       START
