        DATA  SEGMENT
           W  DW        1684H
         BUF  DB        5 DUP(0)
        DATA  ENDS
      STACK1  SEGMENT
              DW        32 DUP(0)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:  MOV       AX,DATA
              MOV       DS,AX

              MOV       AX,W
              CMP       AX,9999     ;AX>9999,CF置1
              JBE       RUN         ;JBE指令：小于或等于跳转
              JMP       EXIT

        RUN:  LEA       SI,BUF
              MOV       BX,10
              MOV       CL,4
      RETRY:  MOV       DL,0
              DIV       BX
              MOV       [SI],DL
              INC       SI
              DEC       CL
              JNZ       RETRY

       EXIT:  MOV       AH,4CH
              INT       21H



        CODE  ENDS
              END       START
