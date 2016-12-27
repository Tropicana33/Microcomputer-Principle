        DATA  SEGMENT
          A1  DW        1234H
              DB        56,56H,"ABCD"
        DATA  ENDS

       EXTRA  SEGMENT
          B1  DB        1,2,3,4,5
       EXTRA  ENDS

       STACK  SEGMENT
         BTM  DB        32 DUP(?)
      STACK  ENDS

        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,ES:EXTRA,SS:STACK
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       AX,EXTRA
              MOV       ES,AX
              MOV       AX,STACK
              MOV       SS,AX
              MOV       SP,SIZE BTM
              MOV       AX,A1+1
              MOV       AX,[BP]
              MOV       AX,DS:[BP]
              MOV       AX,ES:[BP]
              MOV       BX,OFFSET A1
              MOV       AX,[BX+3]
              MOV       AX,ES:[BX+3]
              PUSH      AX
              POP       BX
              MOV       AH,4CH
              INT       21H
        CODE  END
              END       START
