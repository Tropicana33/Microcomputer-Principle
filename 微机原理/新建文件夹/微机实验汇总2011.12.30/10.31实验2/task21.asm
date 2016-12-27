

        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  mov bx,al
mov 100,cl
mov ss,2400h
MOV       [BX],20H
              MOV       AX,IP
              MOV       CS,AX
              MOV       [BX],[SI]
              MOV       AX,[BX+BP]
              MOV       AX,[SI+DI]
              MOV       AX,[BX-SI]
              MOV       AX,[DX]
              IN        AX,2100H
              LDS       AX,BX
              PUSH      IP
              POP       CS
              ADD       AX,DS
              INC       [BX]
              MUL       20H
              SHL       AX,4
              MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START
