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
              DEC       CL
              JNZ       AGAIN
              ROL       XXX,4
              ADD       AX,XXX
              ENDM
        DISP  MACRO
              LEA       DX,BUF
              MOV       AH,9
              INT       21H
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
              MOV       CL,3
              MOV       CH,4
              MOV       SI,5
              MOV       BUF[SI],'$'
              MOV       AX,W
              MOV       BX,AX
              MOV       AX,0H
      AGAIN:  MOV       DX,0F000H
              AND       DX,BX
              ROL       DX,4
             ; MOV       AX,DX
            
              ADD       AX,DX
              MOV       DX,10
              MUL       DX
           ;   MOV       DA2,AX
              SHL       BX,4
            ;  AND       BX,BX
              DEC       CL
              JNZ       AGAIN
              ROL       BX,4
              ADD       AX,BX
         AG:
              MOV       DL,0FH
              AND       DL,AL
              ADD       DL,30H
              CMP       DL,3AH      ; (Dl)>=(3ah)时,则CF=0,即无借位.
              JC        NOAD7
              ADD       DL,7
      NOAD7:  DEC       SI
              MOV       BUF[SI],DL
              SHR       AX,CL
              DEC       CH
              JNZ       AG
              DISP
              
            
              MOV       AH,4CH
              INT       21H



        CODE  ENDS
              END       START
