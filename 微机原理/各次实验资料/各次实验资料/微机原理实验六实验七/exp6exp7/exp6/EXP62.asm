        DATA  SEGMENT
     STRING1  DB        "ABCDEFG"
       COUNT  DW        $-STRING1
        DATA  ENDS
        CODE  SEGMENT
              ASSUME    CS:CODE,DS:DATA,ES:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       ES,AX
              LEA       DI,STRING1
              MOV       CX,[COUNT]

              CLD
              MOV       AL,"C"      ;输入要搜索的字符

              REPNE     SCASB       ;cx=0,或zf!=0时结束计算  al-es：(di)
              JCXZ      ALL         ;cx=0是跳转，否则执行下一条
              DEC       DI          ;获得比较的次数
              MOV       BX,DI
              JMP       EXIT
        ALL:  MOV       BX,-1       ;不存在这个数，bx=-1
       EXIT:  MOV       AH,4CH
              INT       21H
        CODE  ENDS
              END       START




