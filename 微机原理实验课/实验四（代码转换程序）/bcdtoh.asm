        DISP  MACRO     NN
              MOV       AH,02H
              MOV       DL,NN
              INT       21H
              ENDM

        DATA  SEGMENT
           W  DW        1234H
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
              MOV       CH,3
              MOV       CL,4
              MOV       BX,W
              MOV       AX,0H
      AGAIN:  MOV       DX,0F000H
              AND       DX,BX
              ROL       DX,CL
          
            
              ADD       AX,DX
              MOV       DX,10
              MUL       DX
         
              SHL       BX,CL
         
              DEC       CH
              JNZ       AGAIN
              ROL       BX,CL
              ADD       AX,BX

              
          
              MOV       AH,4CH
              INT       21H



        CODE  ENDS
              END       START
