       DATAS  SEGMENT
       ECH01  DB        "INPUT DECIMAL:$"
       ECH02  DB        "RESULT IS:$"
       ECH03  DB        "TOO BIG!$"
       DATAS  ENDS

        CRLF  MACRO
              MOV       AH,2
              MOV       DL,0AH
              INT       21H
              MOV       AH,2
              MOV       DL,0DH
              INT       21H
              ENDM
	

       CODES  SEGMENT
              ASSUME    CS:CODES,DS:DATAS
      START:
              MOV       AX,DATAS
              MOV       DS,AX
      RETRY:  MOV       AH,9
              MOV       DX,OFFSET ECH01
              INT       21H
              CALL      DECBIN
              CRLF
              MOV       AH,9
              MOV       DX,OFFSET ECH01
              INT       21H
              MOV       DI,BX
              CALL      DECBIN
              CRLF
              ADD       BX,DI
              MOV       AH,9
              MOV       DX,OFFSET ECH02
              INT       21H
              CALL      BINHEX
              CRLF
              JMP       RETRY
              
	
	
     DECBIN:
              MOV       BX,0
              MOV       SI,4
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
              DEC       SI
              CMP       SI,0
              JZ        EXIT
              JMP       NEW
       EXIT:  RET
      ERROR:
              MOV       AH,9
              MOV       DX,OFFSET ECH03
              INT       21H
              MOV       AH,4CH
              INT       21H
	
	
     BINHEX:  MOV       CH,4
     ROTATE:
              MOV       CL,4
              ROL       BX,CL
              MOV       AL,BL
              AND       AL,0FH
              ADD       AL,30H
              CMP       AL,3AH
              JL        PRINT
              ADD       AL,7
      PRINT:
              MOV       DL,AL
              MOV       AH,2
              INT       21H
              DEC       CH
              JNZ       ROTATE
              RET
	
    
       CODES  ENDS
              END       START
