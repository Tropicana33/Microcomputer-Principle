        DATA  SEGMENT
        MESG  DB        0AH,0DH,'hello'
         BUF  DB        80 DUP(0)
        DATA  ENDS
      STACK1  SEGMENT
              DB        200 DUP(0)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX
              MOV       CX,5
        LL1:  MOV       MESG+7,'$'
           ;   MOV       MESG+8,0AH
            ;  MOV       MESG+9,
              CALL      DISP
              MOV       MESG+7,0
            ;  MOV       MESG+8,0
            ;  MOV       MESG+9,0
              LOOP      LL1
              MOV       AH,4CH
              INT       21H
        DISP  PROC
              MOV       AH,9
              MOV       DX,OFFSET MESG
              INT       21H
              RET
        DISP  ENDP



        CODE  ENDS
              END       START
