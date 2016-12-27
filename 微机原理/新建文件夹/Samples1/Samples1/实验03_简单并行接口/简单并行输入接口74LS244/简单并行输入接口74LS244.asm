;********************************;
;*    简单并行输入实验          *;
;********************************;
      IOPORT  EQU       0DC00H-0280H
       LS244  EQU       IOPORT+2A0H
        CODE  SEGMENT
              ASSUME    CS:CODE
      START:  MOV       DX,LS244    ;从2A0输入一数据
              IN        AL,DX
              MOV       DL,AL       ;将所读数据保存在DL中
              MOV       AH,02
              INT       21H
              MOV       DL,0DH      ;显示回车符
              INT       21H
              MOV       DL,0AH      ;显示换行符
              INT       21H
              MOV       AH,06       ;是否有键按下
              MOV       DL,0FFH
              INT       21H
              JNZ       EXIT
              JE        START       ;若无,则转start
       EXIT:  MOV       AH,4CH      ;返回
              INT       21H
        CODE  ENDS
              END       START
