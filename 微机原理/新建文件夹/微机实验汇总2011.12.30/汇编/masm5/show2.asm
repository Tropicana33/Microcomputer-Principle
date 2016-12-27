

        DATA  SEGMENT

         BUF  DB        83H
        DATA  ENDS
      STACK1  SEGMENT
              DW        32 DUP(0)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,SS:STACK1
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       AH,2
              MOV       CX,8
      AGAIN:  MOV       DL,18H
              SHL       BUF,1
              RCL       DL,1
              INT       21H
              LOOP      AGAIN
              MOV       DL,'b'
              INT       21H


              MOV       AH,4CH
              INT       21H



        CODE  ENDS
              END       START
