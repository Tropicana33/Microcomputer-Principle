      HTOBCD  MACRO     XXX         ;4位bcd转16进制 ，输入：xxx。输出：ax
              MOV       AX,0H
      AGAIN:  MOV       DX,0F000H
              AND       DX,XXX
              ROL       DX,4
             ; MOV       AX,DX
            
              ADD       AX,DX
              MOV       DX,10
              MUL       DX
           ;   MOV       DA2,AX
              SHL       XXX,4
            ;  AND       BX,BX
              DEC       CX
              JNZ       AGAIN
              ROL       XXX,4
              ADD       AX,XXX
              ENDM

        DATA  SEGMENT
           W  DW        4343H
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
              HTOBCD    BX

              
            
              MOV       AH,4CH
              INT       21H



        CODE  ENDS
              END       START
