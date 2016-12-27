;N的阶乘
  DATA  SEGMENT
          P1  DB        'Input the number:(0-6)','$'
          P2  DB        'The result is:','$'
          CR  DB        0DH,0AH,'$'
        DATA  ENDS
      STACK1  SEGMENT   PARA STACK 'STACK1'
              DB        100 DUP(?)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
        MAIN  PROC      FAR
      START:
              MOV       AX,DATA
              MOV       DS,AX
              MOV       AX,STACK1
              MOV       SS,AX
      
              MOV       AH,9
              LEA       DX,P1
              INT       21H
              MOV       AH,1
              INT       21H
              AND       AL,0FH
              MOV       BL,AL
              LEA       DX,CR
              MOV       AH,9
              INT       21H
              MOV       DX,0        ;DX用于保存结果
              MOV       AL,BL
      ;FACT:输入AL=N，输出DX=N!
              CALL      FACT
              MOV       AX,DX
      ;B2TOBCD:输入AX=16位二进制数；输出AX=4位压缩型BCD码
              CALL      B2TOBCD
              MOV       BX,AX
              MOV       AH,9
              LEA       DX,P2
              INT       21H
      ;DISP:输入BX=4位压缩型BCD码;输出在屏幕上显示
              CALL      DISP
      
              MOV       AH,4CH
              INT       21H
              RET
        MAIN  ENDP
        FACT  PROC      NEAR        ;N!递归
              CMP       AL,0
              JNZ       CHN
              MOV       DL,1
              RET
        CHN:
              PUSH      AX
              DEC       AL
              CALL      FACT
              POP       AX
              MUL       DL
              MOV       DX,AX
              RET
        FACT  ENDP

     B2TOBCD  PROC      NEAR
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
        DISP  PROC      NEAR
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
