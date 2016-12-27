        DATA  SEGMENT
           W  DW        2222H
          P2  DB        'The result is:','$'
          CR  DB        0DH,0AH,'$'
        DATA  ENDS
      STACK1  SEGMENT   PARA STACK 'STACK1'
              DB        100 DUP(?)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
          
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       AX,STACK1
              MOV       SS,AX
              
      
              MOV       AX,W
              CALL      B2TOBCD
              MOV       BX,AX
              CALL      DISP
              MOV       AH,4CH
              INT       21H
              
     B2TOBCD  PROC      NEAR        ;B2TOBCD:输入AX=16位二进制数；输出AX=4位压缩型BCD码
              CMP       AX,9999     ;AX>9999,CF置1
              JBE       TRAN
              STC
              JMP       EXIT
       TRAN:
              PUSH      CX
              PUSH      DX
              SUB       DX,DX
              MOV       CX,1000
              DIV       CX
              XCHG      AX,DX       ;商在DX中，余数在AX中
              MOV       CL,4
              SHL       DX,CL
              MOV       CL,100
              DIV       CL
              ADD       DL,AL
              MOV       CL,4
              SHL       DX,CL
              XCHG      AL,AH       ;余数在AL中
              SUB       AH,AH
              MOV       CL,10
              DIV       CL
              ADD       DL,AL
              MOV       CL,4
              SHL       DX,CL
              ADD       DL,AH
              MOV       AX,DX
              POP       DX
              POP       CX
       EXIT:  RET
     B2TOBCD  ENDP
        DISP  PROC      NEAR        ;DISP:输入BX=4位压缩型BCD码;输出在屏幕上显示
              PUSH      AX
              PUSH      CX
              MOV       CH,4
              MOV       CL,4
         LZ:
              ROL       BX,CL
              MOV       DL,BL
              AND       DL,0FH
              CMP       DL,0
              JNE       LNZ
              DEC       CH
              JNZ       LZ
         LL:
              ROL       BX,CL
              MOV       DL,BL
              AND       DL,0FH
        LNZ:
              ADD       DL,30H
              MOV       AH,2
              INT       21H
              DEC       CH
              JNZ       LL
              POP       CX
              POP       AX
              RET
        DISP  ENDP

        
        CODE  ENDS
              END       START

