      IOPORT  EQU       0EC00H-0280H
     IO8255A  EQU       IOPORT+288H ;A口
     IO8255B  EQU       IOPORT+28BH ;控制口
     IO8255C  EQU       IOPORT+28AH ;C口
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       DX,IO8255B  ;设8255为C口输入,A口输出
              MOV       AL,8BH      ;10001011B,A口方式0输出，C，B口输入，B口工作方式0
          ，  OUT       DX,AL
      INOUT:  MOV       DX,IO8255C  ;从C口输入一数据
              IN        AL,DX
              MOV       DX,IO8255A  ;从A口输出刚才自C口所输入的数据
              OUT       DX,AL
              MOV       DL,0FFH     ;判断是否有按键
              MOV       AH,06H
              INT       21H
              JZ        INOUT       ;若无,则继续自C口输入,A口输出
              MOV       AH,4CH      ;否则返回DOS
              INT       21H
        CODE  ENDS
              END       START
