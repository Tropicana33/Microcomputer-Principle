        DATA  SEGMENT
       DATA1  DB        "AB9DEFGHIJKLMNOP"
       DATA2  DB        "ABCDEFGHIJKLMNOP"
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,ES:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX
              LEA       SI,DATA1
              LEA       DI,DATA2
              MOV       CX,DATA2-DATA1
              CLD
              REPE      CMPSB
              JCXZ      ALL
              DEC       SI
              DEC       DI
              JMP       EXIT
        ALL:  MOV       SI,-1
              MOV       DI,-1
       EXIT:  MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START

