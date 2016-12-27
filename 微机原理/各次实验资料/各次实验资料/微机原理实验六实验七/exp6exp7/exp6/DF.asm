;***********************************************************
;***********************************************************
;此程序演示串操作指令在DF不同时方向不同，并演示重复前缀REP
;***********************************************************
;***********************************************************
        DATA  SEGMENT
     STRING1  DB        "ABCDEFG"
       COUNT  DW        $-STRING1
        DATA  ENDS
      STACKS  SEGMENT
         BUF  DB        30 DUP(0)
      STACKS  ENDS
       EXTRA  SEGMENT
       COPY1  DB        30 DUP(0)
       EXTRA  ENDS


        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,ES:EXTRA,SS:STACKS
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       AX,EXTRA
              MOV       ES,AX
              MOV       AX,STACKS
              MOV       SS,AX

              LEA       SI,STRING1
              MOV       DI, 8
              CLD                   ;DF=0,按递增方向进行
              MOVSB
              MOV       CX,[COUNT]
              REP       MOVSB

              DEC       SI
              DEC       SI
              MOV       DI,30H
              STD                   ;DF=1,按递减方向进行
              MOVSB




              MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START


