        DSEG  SEGMENT
        DATA  DB        0AH,0DH,'Can I display?$'
         BUF  DB        81
              DB        ?
              DB        80 DUP(0)
        DSEG  ENDS
      STACK1  SEGMENT
              DB        200 DUP(0)
      STACK1  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DSEG,SS:STACK1
      START:  MOV       AX,DSEG
              MOV       DS,AX
              LEA       DX,DATA
              MOV       AH,09H
              INT       21H
              LEA       DX,BUF
              MOV       AH,0AH
              INT       21H
              MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START
