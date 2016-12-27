        DATA  SEGMENT
       ECHO1  DB        "INPUT DECIMAL:$"
       ECHO2  DB        "HEX RESULT IS:$"
       ECHO3  DB        "TOO BIG!$"
        DATA  ENDS
        CRLF  MACRO
              MOV       AH,2
              MOV       DL,0AH
              INT       21H
              MOV       AH,2
              MOV       DL,0DH
              INT       21H
              ENDM
        CODE  SEGMENT               ;从键盘输入十进制，转换为十六进制，并显示
              ASSUME    CS:CODE
      START:  MOV       AX,DATA
              MOV       DS,AX
     REPEAT:  MOV       AH,9
              MOV       DX,OFFSET ECHO1
              INT       21H
              CALL      DECBIN
              CRLF
              MOV       AH,9
              MOV       DX,OFFSET ECHO2
              INT       21H
              CALL      BINHEX
              CRLF
              JMP       REPEAT
     DECBIN:  MOV       BX,0
        NEW:  MOV       AH,1
              INT       21H
              SUB       AL,30H
              JL        EXIT
              CMP       AL,9
              JG        EXIT
              CBW
              XCHG      AX,BX
              MOV       CX,0AH
              MUL       CX
              JC        ERROR
              XCHG      AX,BX
              ADD       BX,AX
              JC        ERROR
              JMP       NEW
       EXIT:  RET
      ERROR:  MOV       AH,9
              MOV       DX,OFFSET ECHO3
              INT       21H
              MOV       AH,4CH
              INT       21H
     BINHEX:  MOV       CH,4
     ROTATE:  MOV       CL,4
              ROL       BX,CL
              MOV       AL,BL
              AND       AL,0FH
              ADD       AL,30H
              CMP       AL,3AH
              JL        PRINT
              ADD       AL,7
      PRINT:  MOV       DL,AL
              MOV       AH,2
              INT       21H
              DEC       CH
              JNZ       ROTATE
              RET
        CODE  ENDS
              END       START
      
