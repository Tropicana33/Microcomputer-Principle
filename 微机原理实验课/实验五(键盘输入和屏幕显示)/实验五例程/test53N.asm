DATAS  SEGMENT
       DATA1  DB        6     DUP(0)
       ECH01  DB        "INPUT HEX:$"
       ECH02  DB        "DECIMAL RESULT IS:$"
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
              MOV       DX,OFFSET ECH02
              INT       21H
              CALL      BINHEX
              CRLF
              JMP       RETRY
	
              
     DECBIN:  MOV       DI,0
              MOV       BX,0
        NEW:  MOV       AH,1
              INT       21H
              SUB       AL,30H
              JL        error
              CMP       AL,9
              JG        CHAN
              MOV       [DATA1+DI],AL

              INC       DI
              JMP       NEW
       CHAN:
              SUB       AL,7H
              MOV       [DATA1+DI],AL
              INC       DI
              JMP       NEW
       EXIT:  RET

                 
      ERROR:
              MOV       AH,9
              MOV       DX,OFFSET ECH03
              INT       21H
              MOV       AH,4CH
              INT       21H
	
	
     BINHEX:  MOV       DI,0
              MOV       BX,0010H
              MOV       AL,[DATA1]     
              JIA:      MUL       BX
              ADD       AL,[DATA1+DI+1]
              INC       DI
              CMP       DI,3
              JNZ       JIA
              
              MOV       DI,4
              MOV       CL,0
              MOV       BL,10
   
        PUT:  MOV       DX,0000H      
              DIV       BX
              MOV       [DATA1+DI],DL
              DEC       DI
              INC       CL
              CMP       CL,5
              JNZ       PUT
              MOV       DI,0
   PREPRINT:  ADD       [DATA1+DI],30H
              INC       DI
              CMP       DI,5
              JNZ       PREPRINT
              MOV       [DATA1+DI],24H
      PRINT:  MOV       DX,OFFSET DATA1
              MOV       AH,09H
              INT       21H
              RET

	
    ;此处输入代码据段代码
       CODES  ENDS
              END       START
